import 'package:drift/drift.dart';

/// جدول الأصناف في قاعدة البيانات.
///
/// ملحوظة مهمة: purchasePrice رجعت (كانت اتشالت غلط في تعديل سابق).
/// هي مستخدمة فعليًا في SalesRepositoryImpl لحساب ربح فاتورة البيع
/// (product.price - product.purchasePrice) ومتخزنة كمان جوه
/// invoiceItems وقت كل عملية بيع، فمينفعش تتشال.
///
/// السلوك دلوقتي: purchasePrice لسه عمود مخزّن فعليًا (مش computed)،
/// بس DriftProductRepository (تبع شاشة إدارة الأصناف) بيحسبها
/// تلقائيًا = cartonPrice ÷ unitsPerCarton ويحطها في نفس العمود ده
/// كل ما تضيف أو تعدّل صنف من هناك. يعني احنا لسه بنحسب سعر شراء
/// الوحدة من الكرتونة زي ما اتطلب، بس بنخزن الناتج في العمود اللي
/// باقي المشروع (المبيعات) شايفه أصلًا، بدل ما نستحدث عمود جديد
/// ونكسر حاجة تانية.
///
/// ملحوظة عن الكمية: stockQuantity هو الكمية الفعلية بالوحدة المتاحة
/// للبيع، وهو اللي بينقص مع كل عملية بيع (نفس quantity في
/// ProductItem). cartonQuantity عمود منفصل بيسجل عدد الكراتين اللي
/// اتوردت، وبيتستخدم بس وقت الإضافة/التوريد لحساب stockQuantity
/// تلقائيًا (= cartonQuantity × unitsPerCarton) فى
/// DriftProductRepository، وبعد كده stockQuantity بيتغير لوحده مع
/// المبيعات من غير ما يرجع يتحسب من cartonQuantity تاني.
class Products extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get barcode => text().unique()();

  TextColumn get category => text()();

  TextColumn get unit => text().withDefault(const Constant("قطعة"))();

  /// سعر شراء الوحدة. بيتخزن فعليًا (مستخدم في المبيعات/الفواتير)،
  /// وبيتزامن تلقائيًا من cartonPrice/unitsPerCarton في شاشة إدارة
  /// الأصناف.
  RealColumn get purchasePrice => real().withDefault(const Constant(0))();

  /// سعر بيع الوحدة.
  RealColumn get price => real()();

  /// سعر الكرتونة كاملة (المصدر الأساسي لحساب purchasePrice).
  RealColumn get cartonPrice => real().withDefault(const Constant(0))();

  /// عدد الوحدات في الكرتونة الواحدة.
  IntColumn get unitsPerCarton => integer().withDefault(const Constant(1))();

  /// عدد الكراتين اللي اتوردت (بيانة توريد، مش بتنقص مع البيع).
  /// بيتستخدم لحساب stockQuantity تلقائيًا وقت الإضافة/التوريد:
  /// stockQuantity = cartonQuantity × unitsPerCarton.
  RealColumn get cartonQuantity =>
      real().withDefault(const Constant(0))();
  /// الكمية الفعلية بالوحدة المتاحة للبيع. دي اللي بتنقص مع كل عملية
  /// بيع، ومستقلة عن cartonQuantity بعد أول حساب.
  IntColumn get stockQuantity => integer()();

  IntColumn get minStockLimit => integer().withDefault(const Constant(5))();

  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  TextColumn get imageUrl => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}