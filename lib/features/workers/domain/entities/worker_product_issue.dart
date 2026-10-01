class WorkerProductIssue {
  final int id;
  final int workerId;
  final int productId;
  final String productName;
  final String barcode;
  final int quantity;
  final double unitPrice;
  final DateTime createdAt;

  const WorkerProductIssue({
    required this.id,
    required this.workerId,
    required this.productId,
    required this.productName,
    required this.barcode,
    required this.quantity,
    required this.unitPrice,
    required this.createdAt,
  });

  double get total => quantity * unitPrice;
}
