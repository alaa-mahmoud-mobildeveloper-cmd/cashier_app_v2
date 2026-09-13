enum DebtStatus { unpaid, partial, paid }

class DebtInvoice {
  final String invoiceNumber;
  final String customerName;
  final String phone;
  final DateTime date;
  final double total;
  final double paid;
  final DebtStatus status;

  const DebtInvoice({
    required this.invoiceNumber,
    required this.customerName,
    required this.phone,
    required this.date,
    required this.total,
    required this.paid,
    required this.status,
  });

  double get remaining => total - paid;
}
