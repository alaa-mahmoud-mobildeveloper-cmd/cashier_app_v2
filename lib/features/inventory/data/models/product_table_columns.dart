/// عرض ثابت بالبكسل لكل عمود في الجدول (مستخدم في الهيدر والصفوف معًا).
/// بنستخدم عرض ثابت بدل flex عشان الجدول يفضل مقروء على أي شاشة،
/// ولو الشاشة ضيقة (موبايل) الجدول كله بيعمل scroll أفقي بدل ما يتزنق.
class ProductTableColumns {
  ProductTableColumns._();

  static const double image = 64;
  static const double name = 170;
  static const double barcode = 80;
  static const double category = 100;
  static const double sellPrice = 80;
  static const double unitCost = 90;
  static const double carton = 90;
  static const double quantity = 60;
  static const double status = 110;
  static const double actions = 120;

  /// إجمالي عرض الجدول بالبكسل = مجموع كل الأعمدة + الـ padding الجانبي
  static const double horizontalPadding = 32; // 16 يمين + 16 شمال لكل صف
  static double get contentWidth =>
      image + name + barcode + category + sellPrice + unitCost + carton + quantity + status + actions;
  static double get totalWidth => contentWidth + horizontalPadding;
}