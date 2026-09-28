class PurchaseInvoiceDetails {
  const PurchaseInvoiceDetails({
    required this.id,
    required this.invoiceNumber,
    required this.supplierName,
    required this.createdAt,
    required this.total,
    required this.discount,
    required this.tax,
    required this.netTotal,
    required this.paymentMethod,
    required this.dueDate,
    required this.paidAmount,
    required this.remainingAmount,
    required this.items,
    this.payments = const [],
  });

  final int id;
  final String invoiceNumber;
  final String supplierName;
  final DateTime createdAt;

  final double total;
  final double discount;
  final double tax;
  final double netTotal;

  final String paymentMethod;

  /// موعد تحصيل المبلغ المتبقي
  final DateTime? dueDate;

  /// إجمالي ما تم دفعه حتى الآن
  final double paidAmount;

  /// المبلغ المتبقي
  final double remainingAmount;

  final List<PurchaseInvoiceItem> items;

  /// سجل دفعات المورد
  final List<PurchasePaymentEntity> payments;

  bool get isCash {
    final value = paymentMethod.trim().toLowerCase();

    return value == 'cash' ||
        value == 'نقد' ||
        value == 'نقدي';
  }

  bool get isCredit {
    final value = paymentMethod.trim().toLowerCase();

    return value == 'credit' ||
        value == 'آجل' ||
        value == 'اجل';
  }

  bool get isFullyPaid {
    return remainingAmount <= 0.01;
  }

  bool get hasRemaining {
    return remainingAmount > 0.01;
  }

  String get status {
    if (isCash || isFullyPaid) {
      return 'مدفوعة';
    }

    if (paidAmount > 0) {
      return 'دفع جزئي';
    }

    return 'آجلة';
  }
}

class PurchasePaymentEntity {
  const PurchasePaymentEntity({
    required this.id,
    required this.purchaseId,
    required this.amount,
    required this.paymentMethod,
    required this.createdAt,
    this.note,
  });

  final int id;
  final int purchaseId;
  final double amount;
  final String paymentMethod;
  final DateTime createdAt;
  final String? note;
}

class PurchaseInvoiceItem {
  const PurchaseInvoiceItem({
    required this.productId,
    required this.productName,
    required this.barcode,
    required this.cartonQuantity,
    required this.unitsPerCarton,
    required this.purchasePrice,
    required this.salePrice,
    required this.total,
  });

  final int productId;
  final String productName;
  final String barcode;
  final double cartonQuantity;
  final int unitsPerCarton;
  final double purchasePrice;
  final double salePrice;
  final double total;

  double get units =>
      cartonQuantity * unitsPerCarton;

  double get unitPurchasePrice =>
      unitsPerCarton > 0
          ? purchasePrice / unitsPerCarton
          : 0;
}