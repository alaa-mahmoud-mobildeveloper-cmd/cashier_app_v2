/// نموذج مؤقت لعملية توريد بضاعة من المورد (عن طريق المندوب).
/// استبدله بالـ Entity الحقيقي المرتبط بجدول Purchases لما تضيف
/// حقول المدفوع/المتبقي هناك.
class SupplierTransactionUi {
  final String id;
  final DateTime date;

  /// اسم المندوب اللي ورد البضاعة
  final String repName;

  /// إجمالي قيمة البضاعة الموردة في العملية دي
  final double totalAmount;

  /// اللي اتحصّل (اتدفع) من قيمة العملية دي لحد دلوقتي
  final double collectedAmount;

  final String? note;

  const SupplierTransactionUi({
    required this.id,
    required this.date,
    required this.repName,
    required this.totalAmount,
    this.collectedAmount = 0,
    this.note,
  });

  /// المتبقي (الأجل) على العملية دي
  double get dueAmount => totalAmount - collectedAmount;

  bool get isFullyCollected => dueAmount <= 0;
}
