/// عمود واحد من جدول الأصناف: العنوان ونسبة العرض (flex).
///
/// ملحوظة: نقلت الملف ده من data/models لـ presentation/widgets، لأن
/// أعمدة الجدول ونسب عرضها شكل عرض (UI) مش موديل بيانات، ومكانه الصح
/// جوه presentation.
class ProductTableColumn {
  final String label;
  final int flex;

  const ProductTableColumn(this.label, this.flex);
}

/// مصدر واحد لأعمدة الجدول بيتشارك فيه ProductsTableHeader و
/// ProductTableRow عشان يفضلوا متطابقين دايمًا بدل ما كل واحد يكرر
/// نفس الأرقام لوحده.
class ProductTableColumns {
  static const List<ProductTableColumn> columns = [
    ProductTableColumn('الصورة', 1),
    ProductTableColumn('اسم الصنف', 3),
    ProductTableColumn('الباركود', 2),
    ProductTableColumn('الفئة', 2),
    ProductTableColumn('سعر البيع', 2),
    ProductTableColumn('سعر الشراء/وحدة', 2),
    ProductTableColumn('هامش الربح', 2),
    ProductTableColumn('كرتونة', 2),
    ProductTableColumn('الكمية', 2),
    ProductTableColumn('الحالة', 2),
    ProductTableColumn('إجراءات', 2),
  ];

  static List<int> get flexes => columns.map((c) => c.flex).toList(growable: false);

  static List<String> get labels => columns.map((c) => c.label).toList(growable: false);
}