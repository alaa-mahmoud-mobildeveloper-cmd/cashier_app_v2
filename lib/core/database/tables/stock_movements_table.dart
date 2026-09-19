import 'package:drift/drift.dart';

import 'products_table.dart';
import 'users_table.dart';

class StockMovements extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// المنتج
  IntColumn get productId =>
      integer().references(Products, #id)();

  /// المستخدم الذي قام بالحركة
  IntColumn get userId =>
      integer().references(Users, #id)();

  /// كمية الحركة
  IntColumn get quantity => integer()();

  /// نوع الحركة
  /// purchase
  /// sale
  /// adjustment
  /// damaged
  /// return
  TextColumn get type => text()();

  /// ملاحظات
  TextColumn get note => text().nullable()();

  /// تاريخ الحركة
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
}