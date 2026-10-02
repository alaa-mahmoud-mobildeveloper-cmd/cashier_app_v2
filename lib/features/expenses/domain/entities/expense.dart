enum ExpenseStatus { paid, pending }

class Expense {
  final int? id;
  final String title;
  final String category;
  final String description;
  final DateTime date;
  final double amount;
  final ExpenseStatus status;

  /// cash, credit, or the selected payment account type.
  final String paymentMethod;
  final int? paymentAccountId;

  const Expense({
    this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.date,
    required this.amount,
    this.status = ExpenseStatus.paid,
    this.paymentMethod = 'cash',
    this.paymentAccountId,
  });

  bool get isPaid => status == ExpenseStatus.paid;
}
