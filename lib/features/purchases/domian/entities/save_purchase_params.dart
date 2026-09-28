import 'purchase_item_save.dart';

class SavePurchaseParams {
  const SavePurchaseParams({
    required this.supplierId,
    required this.invoiceNumber,
    required this.total,
    required this.discount,
    required this.tax,
    required this.netTotal,
    required this.paymentMethod,
    required this.items,
    this.dueDate,
    this.paidAmount = 0,
  });

  final int supplierId;
  final String invoiceNumber;
  final double total;
  final double discount;
  final double tax;
  final double netTotal;
  final String paymentMethod;
  final List<PurchaseItemSave> items;

  /// موعد تحصيل المبلغ المتبقي في الفاتورة الآجلة.
  final DateTime? dueDate;

  /// المبلغ المدفوع وقت إنشاء الفاتورة.
  final double paidAmount;
}