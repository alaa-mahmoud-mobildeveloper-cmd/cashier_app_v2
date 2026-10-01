import 'dart:io';

import 'package:cashier_app_v2/core/database/app_database.dart' as db;
import 'package:cashier_app_v2/features/expenses/data/repositories/expense_repository.dart';
import 'package:cashier_app_v2/features/expenses/domain/entities/expense.dart';
import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final previousDuplicateDatabaseWarning =
      driftRuntimeOptions.dontWarnAboutMultipleDatabases;
  late db.AppDatabase database;
  late ExpenseRepository repository;

  // This suite deliberately closes and reopens a file-backed database.
  setUpAll(() {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  });

  tearDownAll(() {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases =
        previousDuplicateDatabaseWarning;
  });

  setUp(() {
    database = db.AppDatabase.forTesting(NativeDatabase.memory());
    repository = ExpenseRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  test('persists expense CRUD, description, and paid/pending status', () async {
    final paidId = await repository.addExpense(
      Expense(
        title: 'إيجار المحل',
        category: 'إيجار',
        description: 'إيجار شهر سبتمبر',
        date: DateTime(2026, 9, 1),
        amount: 3500,
      ),
    );
    final pendingId = await repository.addExpense(
      Expense(
        title: 'شراء أكياس',
        category: 'مشتريات',
        description: '',
        date: DateTime(2026, 9, 7),
        amount: 420,
        status: ExpenseStatus.pending,
      ),
    );

    var expenses = await repository.watchExpenses().first;
    expect(expenses, hasLength(2));
    expect(expenses.first.id, pendingId);
    expect(expenses.first.status, ExpenseStatus.pending);
    expect(expenses.first.description, isEmpty);
    expect(expenses.last.id, paidId);
    expect(expenses.last.status, ExpenseStatus.paid);
    expect(expenses.last.description, 'إيجار شهر سبتمبر');

    final updatedRows = await repository.updateExpense(
      Expense(
        id: pendingId,
        title: 'شراء مستلزمات',
        category: 'مشتريات',
        description: 'تم السداد',
        date: DateTime(2026, 9, 7),
        amount: 500,
        status: ExpenseStatus.paid,
      ),
    );
    expect(updatedRows, 1);
    expenses = await repository.watchExpenses().first;
    final updated = expenses.firstWhere((expense) => expense.id == pendingId);
    expect(updated.title, 'شراء مستلزمات');
    expect(updated.amount, 500);
    expect(updated.status, ExpenseStatus.paid);
    expect(updated.description, 'تم السداد');

    expect(await repository.deleteExpense(paidId), 1);
    expenses = await repository.watchExpenses().first;
    expect(expenses, hasLength(1));
    expect(expenses.single.id, pendingId);
  });

  test(
    'expense survives database reopen and legacy rows migrate to paid',
    () async {
      final directory = await Directory.systemTemp.createTemp('expenses_test_');
      final file = File('${directory.path}/expenses.sqlite');
      var fileDatabase = db.AppDatabase.forTesting(NativeDatabase(file));

      try {
        final fileRepository = ExpenseRepository(fileDatabase);
        final id = await fileRepository.addExpense(
          Expense(
            title: 'فاتورة الكهرباء',
            category: 'مرافق',
            description: 'فاتورة شهرية',
            date: DateTime(2026, 9, 5),
            amount: 850,
            status: ExpenseStatus.pending,
          ),
        );

        // Simulate the old v17 schema, which had no status column.
        await fileDatabase.customStatement(
          'ALTER TABLE expenses RENAME TO expenses_with_status',
        );
        await fileDatabase.customStatement('''
        CREATE TABLE expenses (
          id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          category TEXT NOT NULL,
          amount REAL NOT NULL,
          notes TEXT NULL,
          expense_date INTEGER NOT NULL,
          created_at INTEGER NOT NULL DEFAULT (strftime('%s','now') * 1000)
        )
      ''');
        await fileDatabase.customStatement('''
        INSERT INTO expenses (id, title, category, amount, notes, expense_date, created_at)
        SELECT id, title, category, amount, notes, expense_date, created_at
        FROM expenses_with_status
      ''');
        await fileDatabase.customStatement('DROP TABLE expenses_with_status');
        await fileDatabase.customStatement('PRAGMA user_version = 17');
        await fileDatabase.close();

        fileDatabase = db.AppDatabase.forTesting(NativeDatabase(file));
        final migrated = await ExpenseRepository(
          fileDatabase,
        ).watchExpenses().first;

        expect(migrated, hasLength(1));
        expect(migrated.single.id, id);
        expect(migrated.single.title, 'فاتورة الكهرباء');
        expect(migrated.single.description, 'فاتورة شهرية');
        expect(migrated.single.status, ExpenseStatus.paid);
      } finally {
        await fileDatabase.close();
        await directory.delete(recursive: true);
      }
    },
  );
}
