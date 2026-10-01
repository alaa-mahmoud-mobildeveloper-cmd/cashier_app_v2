enum PaymentMethod { cash, visa, credit, wallet, fawry }

enum InvoiceStatus { completed, cancelled }

class SalesInvoiceRow {
  final String invoiceNumber;
  final DateTime date;
  final String cashier;
  final int itemsCount;
  final double total;
  final PaymentMethod paymentMethod;
  final InvoiceStatus status;

  const SalesInvoiceRow({
    required this.invoiceNumber,
    required this.date,
    required this.cashier,
    required this.itemsCount,
    required this.total,
    required this.paymentMethod,
    required this.status,
  });
}
