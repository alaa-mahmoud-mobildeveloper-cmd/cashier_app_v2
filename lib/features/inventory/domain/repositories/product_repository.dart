import 'package:cashier_app_v2/features/inventory/domain/entities/product_items_entit.dart';



/// العقد اللي الـ Domain layer بيحدده لأي مصدر بيانات للأصناف.
/// الـ Data layer هو اللي بيوفر التنفيذ الفعلي (In-memory دلوقتي،
/// Drift لاحقًا)، والـ BLoC بيتعامل مع الـ interface ده بس من غير ما
/// يعرف حاجة عن مصدر البيانات الحقيقي.
abstract class ProductRepository {
  /// بيرجع Stream بيبعت أحدث نسخة من القائمة كل ما يحصل تغيير
  /// (إضافة/تعديل/حذف)، سواء جوه نفس التطبيق أو من مصدر خارجي.
  Stream<List<ProductItem>> watchProducts();

  /// جلب فوري للقائمة الحالية (مفيد للتحميل الأول قبل الاشتراك في الـ Stream).
  Future<List<ProductItem>> getProducts();

  Future<void> addProduct(ProductItem product);

  Future<void> updateProduct(ProductItem product);

  Future<void> deleteProduct(String id);
}