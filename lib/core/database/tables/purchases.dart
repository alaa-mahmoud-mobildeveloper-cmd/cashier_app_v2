import 'package:cashier_app_v2/core/database/tables/suppliers.dart';
import 'package:drift/drift.dart';


class Purchases extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get supplierId =>
      integer().references(Suppliers, #id)();

  TextColumn get invoiceNumber => text()();

  RealColumn get total => real()();

  RealColumn get discount =>
      real().withDefault(const Constant(0))();

  RealColumn get tax =>
      real().withDefault(const Constant(0))();

  RealColumn get netTotal => real()();

  TextColumn get paymentMethod => text()();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
}