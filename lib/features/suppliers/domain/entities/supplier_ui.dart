/// نموذج مؤقت للمورد للعرض فقط.
/// استبدله بالـ Entity الحقيقي بتاع جدول Suppliers لما تبعتهولي
/// (أو خليه كـ mapper بين الـ Entity الحقيقي وبين احتياجات الواجهة).
class SupplierUi {
  final String id;
  final String name;
  final String? phone;
  final String? address;
  final String? notes;
  final int productsCount;

  /// إجمالي المتبقي (الأجل) على كل توريدات المورد ده لحد دلوقتي
  final double totalDue;

  /// إجمالي اللي اتحصّل من المورد ده لحد دلوقتي
  final double totalCollected;

  const SupplierUi({
    required this.id,
    required this.name,
    this.phone,
    this.address,
    this.notes,
    this.productsCount = 0,
    this.totalDue = 0,
    this.totalCollected = 0,
  });

  bool get hasDue => totalDue > 0;
}
