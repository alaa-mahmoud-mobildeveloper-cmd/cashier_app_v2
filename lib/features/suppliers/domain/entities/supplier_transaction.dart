import 'package:equatable/equatable.dart';

class SupplierTransaction extends Equatable {
  final int purchaseId;
  final String invoiceNumber;
  final DateTime date;
  final double totalAmount;
  final double collectedAmount;
  final String paymentMethod;
  final DateTime? dueDate;

  const SupplierTransaction({
    required this.purchaseId,
    required this.invoiceNumber,
    required this.date,
    required this.totalAmount,
    required this.collectedAmount,
    required this.paymentMethod,
    this.dueDate,
  });

  double get dueAmount {
    final value = totalAmount - collectedAmount;
    return value < 0 ? 0 : value;
  }

  bool get isPaid => dueAmount <= 0.01;

  bool get isPartial =>
      collectedAmount > 0 && dueAmount > 0.01;

  String get status {
    if (isPaid) return 'مدفوعة';
    if (isPartial) return 'جزئيًا';
    return 'آجلة';
  }

  @override
  List<Object?> get props => [
    purchaseId,
    invoiceNumber,
    date,
    totalAmount,
    collectedAmount,
    paymentMethod,
    dueDate,
  ];
}