class PurchaseInvoice {
  const PurchaseInvoice({
    required this.id,
    required this.invoiceNumber,
    required this.supplier,
    required this.createdAt,
    required this.itemsCount,
    required this.total,
    required this.discount,
    required this.tax,
    required this.netTotal,
    required this.paymentMethod,
    this.paidAmount = 0,
    this.remainingAmount = 0,
  });

  final int id;
  final String invoiceNumber;
  final String supplier;
  final DateTime createdAt;
  final int itemsCount;
  final double total;
  final double discount;
  final double tax;
  final double netTotal;
  final String paymentMethod;

  final double paidAmount;
  final double remainingAmount;

  bool get isCash {
    final value = paymentMethod.trim().toLowerCase();

    return value == 'cash' ||
        value == 'نقد' ||
        value == 'نقدي';
  }

  bool get isFullyPaid => remainingAmount <= 0.01;

  bool get isPartiallyPaid =>
      paidAmount > 0 && remainingAmount > 0.01;

  bool get isCredit {
    final value = paymentMethod.trim().toLowerCase();

    return value == 'credit' ||
        value == 'آجل' ||
        value == 'اجل';
  }

  String get status {
    if (isCash || isFullyPaid) {
      return 'تم التحصيل';
    }

    if (isPartiallyPaid) {
      return 'دفع جزئي';
    }

    return 'آجلة';
  }
}