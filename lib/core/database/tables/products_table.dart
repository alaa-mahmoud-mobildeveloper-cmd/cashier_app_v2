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

  IntColumn get stockQuantity => integer()();

  IntColumn get minStockLimit => integer().withDefault(const Constant(5))();

  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  TextColumn get imageUrl => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}