enum ExpenseStatus { paid, pending }

class Expense {
  final int? id;
  final String title;
  final String category;
  final String description;
  final DateTime date;
  final double amount;
  final ExpenseStatus status;

  const Expense({
    this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.date,
    required this.amount,
    this.status = ExpenseStatus.paid,
  });
}
