import 'package:cashier_app_v2/core/database/tables/users_table.dart';
import 'package:drift/drift.dart';


class Invoices extends Table {
  /// رقم الفاتورة الداخلي
  IntColumn get id => integer().autoIncrement()();

  /// رقم الفاتورة الظاهر للمستخدم
  TextColumn get invoiceNumber => text().unique()();

  /// الكاشير
  IntColumn get userId =>
      integer().references(Users, #id)();

  /// إجمالي المنتجات قبل الخصم
  RealColumn get totalAmount => real()();

  /// الخصم
  RealColumn get discount =>
      real().withDefault(const Constant(0.0))();

  /// الضريبة
  RealColumn get tax =>
      real().withDefault(const Constant(0.0))();

  /// صافي الفاتورة
  RealColumn get netAmount => real()();

  /// إجمالي ربح الفاتورة
  RealColumn get profit =>
      real().withDefault(const Constant(0.0))();

  /// المبلغ المدفوع
  RealColumn get paidAmount =>
      real().withDefault(const Constant(0.0))();

  /// المبلغ المتبقي
  RealColumn get remainingAmount =>
      real().withDefault(const Constant(0.0))();

  /// طريقة الدفع
  TextColumn get paymentMethod =>
      text().withDefault(const Constant('cash'))();

  /// الحالة
  TextColumn get status =>
      text().withDefault(const Constant('completed'))();

  /// تاريخ إنشاء الفاتورة
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
}