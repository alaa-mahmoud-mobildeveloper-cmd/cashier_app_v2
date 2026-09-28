import 'package:drift/drift.dart';

import 'purchases.dart';

class PurchasePayments extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get purchaseId =>
      integer().references(Purchases, #id)();

  RealColumn get amount => real()();

  TextColumn get paymentMethod =>
      text().withDefault(const Constant('cash'))();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  TextColumn get note => text().nullable()();
}