import 'package:drift/drift.dart';

class Customers extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// اسم العميل
  TextColumn get name => text()();

  /// رقم التليفون (اختياري - لكن لو اتسجل، بيبقى فريد عشان نقدر ندور بيه على العميل)
  TextColumn get phone =>
      text().nullable().unique()();

  /// عنوان العميل (اختياري)
  TextColumn get address =>
      text().withDefault(const Constant(''))();

  /// إجمالي المديونية الحالية على العميل (مجموع remainingAmount بتاع فواتيره)
  RealColumn get totalDebt =>
      real().withDefault(const Constant(0.0))();

  /// تاريخ إضافة العميل
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
}