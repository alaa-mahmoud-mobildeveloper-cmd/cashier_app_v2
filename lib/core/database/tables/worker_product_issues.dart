import 'package:drift/drift.dart';

import 'users_table.dart';

class WorkerProductIssues extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get workerId =>
      integer().references(Users, #id, onDelete: KeyAction.cascade)();

  /// Product identity snapshot: history remains readable if the catalog item changes.
  IntColumn get productId => integer()();

  TextColumn get productName => text()();

  TextColumn get barcode => text()();

  IntColumn get quantity => integer().withDefault(const Constant(1))();

  /// Selling price captured when the product was issued.
  RealColumn get unitPrice => real()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
