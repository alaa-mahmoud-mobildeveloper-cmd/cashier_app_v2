/// استثناء مخصص لما نحاول نضيف أو نعدّل صنف بباركود مسجل بالفعل لصنف
/// تاني (قيد الـ UNIQUE على عمود barcode فى قاعدة البيانات).
///
/// الـ Data layer (DriftProductRepository) هو اللي بيكتشف الحالة دي
/// من رسالة SqliteException الخام، ويرميها بدل ما يسيب الرسالة
/// التقنية توصل للمستخدم زي ما هي. أي حد بيمسك الـ Exception ده
/// (البلوك، الشاشة) هيلاقي toString() جاهزة كرسالة عربية واضحة.
class DuplicateBarcodeException implements Exception {
  final String barcode;

  const DuplicateBarcodeException(this.barcode);

  @override
  String toString() =>
      'الباركود "$barcode" مسجل بالفعل لصنف تاني. جرّب باركود مختلف.';
}
