enum DebtStatus {
  unpaid,
  partial,
  paid,
}

class DebtInvoice {
  final int id;
  final String invoiceNumber;
  final String customerName;
  final String phone;
  final DateTime date;
  final double total;
  final double paid;
  final DebtStatus status;
  final String paymentMethod;

  const DebtInvoice({
    required this.id,
    required this.invoiceNumber,
    required this.customerName,
    required this.phone,
    required this.date,
    required this.total,
    required this.paid,
    required this.status,
    required this.paymentMethod,
  });

  double get remaining {
    final value = total - paid;
    return value < 0 ? 0 : value;
  }

  bool get isCredit => paymentMethod == 'credit';

  bool get isCash => paymentMethod == 'cash';
}