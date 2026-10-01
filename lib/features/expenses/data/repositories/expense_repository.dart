import 'package:cashier_app_v2/core/database/app_database.dart' as db;
import 'package:cashier_app_v2/features/expenses/domain/entities/expense.dart';
import 'package:drift/drift.dart';

class ExpenseRepository {
  final db.AppDatabase _database;

  const ExpenseRepository(this._database);

  Stream<List<Expense>> watchExpenses() {
    final query = _database.select(_database.expenses)
      ..orderBy([
        (expense) => OrderingTerm(
          expression: expense.expenseDate,
          mode: OrderingMode.desc,
        ),
        (expense) => OrderingTerm(
          expression: expense.createdAt,
          mode: OrderingMode.desc,
        ),
      ]);

    return query.watch().map((rows) => rows.map(_fromRow).toList());
  }

  Future<int> addExpense(Expense expense) async {
    _validate(expense);
    return _database.into(_database.expenses).insert(_toCompanion(expense));
  }

  Future<int> updateExpense(Expense expense) async {
    _validate(expense);
    final id = expense.id;
    if (id == null) {
      throw ArgumentError('لا يمكن تعديل مصروف بدون رقم تعريف');
    }

    return (_database.update(
      _database.expenses,
    )..where((row) => row.id.equals(id))).write(_toCompanion(expense));
  }

  Future<int> deleteExpense(int id) {
    return (_database.delete(
      _database.expenses,
    )..where((row) => row.id.equals(id))).go();
  }

  void _validate(Expense expense) {
    if (expense.title.trim().isEmpty) {
      throw ArgumentError('اسم المصروف مطلوب');
    }
    if (expense.category.trim().isEmpty) {
      throw ArgumentError('تصنيف المصروف مطلوب');
    }
    if (!expense.amount.isFinite || expense.amount <= 0) {
      throw ArgumentError('المبلغ يجب أن يكون أكبر من صفر');
    }
  }

  db.ExpensesCompanion _toCompanion(Expense expense) {
    final description = expense.description.trim();
    return db.ExpensesCompanion(
      title: Value(expense.title.trim()),
      category: Value(expense.category.trim()),
      amount: Value(expense.amount),
      notes: Value(description.isEmpty ? null : description),
      expenseDate: Value(expense.date),
      status: Value(expense.status.name),
    );
  }

  Expense _fromRow(db.Expense row) {
    final status = ExpenseStatus.values.firstWhere(
      (value) => value.name == row.status,
      orElse: () => ExpenseStatus.paid,
    );
    return Expense(
      id: row.id,
      title: row.title,
      category: row.category,
      description: row.notes ?? '',
      date: row.expenseDate,
      amount: row.amount,
      status: status,
    );
  }
}
