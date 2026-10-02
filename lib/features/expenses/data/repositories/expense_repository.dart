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

  Future<int> addExpense(Expense expense, {int? userId}) async {
    _validate(expense);
    return _database.transaction(() async {
      final id = await _database
          .into(_database.expenses)
          .insert(_toCompanion(expense));
      await _recordPayment(
        expense,
        userId: userId,
        note: 'دفع مصروف ${expense.title}',
      );
      return id;
    });
  }

  Future<int> updateExpense(Expense expense, {int? userId}) async {
    _validate(expense);
    final id = expense.id;
    if (id == null) throw ArgumentError('لا يمكن تعديل مصروف بدون رقم تعريف');
    return _database.transaction(() async {
      final old = await (_database.select(
        _database.expenses,
      )..where((row) => row.id.equals(id))).getSingleOrNull();
      if (old == null) return 0;
      await _reversePayment(old, userId: userId);
      final affected = await (_database.update(
        _database.expenses,
      )..where((row) => row.id.equals(id))).write(_toCompanion(expense));
      await _recordPayment(
        expense,
        userId: userId,
        note: 'دفع مصروف ${expense.title} بعد التعديل',
      );
      return affected;
    });
  }

  Future<int> deleteExpense(int id) => _database.transaction(() async {
    final old = await (_database.select(
      _database.expenses,
    )..where((row) => row.id.equals(id))).getSingleOrNull();
    if (old == null) return 0;
    // Deletion is intentionally blocked for paid digital expenses: it would hide an audited movement.
    if (old.status == 'paid' && old.paymentAccountId != null) {
      throw StateError(
        'لا يمكن حذف مصروف مسجل على حساب إلكتروني؛ عدّله بدلًا من حذفه',
      );
    }
    return (_database.delete(
      _database.expenses,
    )..where((row) => row.id.equals(id))).go();
  });

  void _validate(Expense expense) {
    if (expense.title.trim().isEmpty) throw ArgumentError('اسم المصروف مطلوب');
    if (expense.category.trim().isEmpty)
      throw ArgumentError('تصنيف المصروف مطلوب');
    if (!expense.amount.isFinite || expense.amount <= 0)
      throw ArgumentError('المبلغ يجب أن يكون أكبر من صفر');
    if (expense.paymentMethod == 'credit' && expense.isPaid) {
      throw ArgumentError('المصروف المدفوع لا يمكن أن تكون طريقته آجل');
    }
    if (expense.paymentAccountId != null && expense.paymentMethod == 'cash') {
      throw ArgumentError('اختر الحساب الإلكتروني أو ألغِ اختياره');
    }
  }

  db.ExpensesCompanion _toCompanion(Expense expense) => db.ExpensesCompanion(
    title: Value(expense.title.trim()),
    category: Value(expense.category.trim()),
    amount: Value(expense.amount),
    notes: Value(
      expense.description.trim().isEmpty ? null : expense.description.trim(),
    ),
    expenseDate: Value(expense.date),
    status: Value(expense.status.name),
    paymentMethod: Value(expense.paymentMethod),
    paymentAccountId: Value(expense.paymentAccountId),
  );

  Future<void> _recordPayment(
    Expense expense, {
    required int? userId,
    required String note,
  }) async {
    if (!expense.isPaid || expense.paymentAccountId == null) return;
    if (userId == null)
      throw StateError('يجب تسجيل مستخدم حالي قبل الدفع من حساب إلكتروني');
    final account = await (_database.select(
      _database.paymentAccounts,
    )..where((a) => a.id.equals(expense.paymentAccountId!))).getSingleOrNull();
    if (account == null || !account.isActive)
      throw StateError('حساب الدفع غير موجود أو متوقف');
    await _database
        .into(_database.paymentAccountTransactions)
        .insert(
          db.PaymentAccountTransactionsCompanion.insert(
            accountId: account.id,
            invoiceId: const Value(null),
            invoiceNumber: const Value(null),
            userId: userId,
            kind: 'withdrawal',
            amount: expense.amount,
            note: Value(note),
          ),
        );
  }

  Future<void> _reversePayment(db.Expense old, {required int? userId}) async {
    if (old.status != 'paid' || old.paymentAccountId == null) return;
    if (userId == null)
      throw StateError('يجب تسجيل مستخدم حالي لتعديل مصروف إلكتروني');
    await _database
        .into(_database.paymentAccountTransactions)
        .insert(
          db.PaymentAccountTransactionsCompanion.insert(
            accountId: old.paymentAccountId!,
            invoiceId: const Value(null),
            invoiceNumber: const Value(null),
            userId: userId,
            kind: 'deposit',
            amount: old.amount,
            note: const Value('عكس دفع مصروف معدل'),
          ),
        );
  }

  Expense _fromRow(db.Expense row) => Expense(
    id: row.id,
    title: row.title,
    category: row.category,
    description: row.notes ?? '',
    date: row.expenseDate,
    amount: row.amount,
    status: ExpenseStatus.values.firstWhere(
      (v) => v.name == row.status,
      orElse: () => ExpenseStatus.paid,
    ),
    paymentMethod: row.paymentMethod,
    paymentAccountId: row.paymentAccountId,
  );
}
