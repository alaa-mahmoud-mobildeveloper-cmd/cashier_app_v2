enum ExpenseStatus { paid, pending }

class Expense {
  final String title;
  final String category;
  final String description;
  final DateTime date;
  final double amount;
  ExpenseStatus status;

  Expense({required this.title, required this.category, required this.description, required this.date, required this.amount, this.status = ExpenseStatus.paid});
}
