class SalesInvoice {
  final int id;
  final String invoiceNumber;
  final int cashierId;
  final String cashierName;
  final String paymentMethod;
  final DateTime createdAt;
  final int itemsCount;
  final double totalAmount;
  final double discount;
  final double tax;
  final double netAmount;
  final double profit;
  final double paidAmount;
  final double remainingAmount;
  final String status;

  const SalesInvoice({
    required this.id,
    required this.invoiceNumber,
    required this.cashierId,
    required this.cashierName,
    required this.paymentMethod,
    required this.createdAt,
    required this.itemsCount,
    required this.totalAmount,
    required this.discount,
    required this.tax,
    required this.netAmount,
    required this.profit,
    required this.paidAmount,
    required this.remainingAmount,
    required this.status,
  });
}