import 'package:cashier_app_v2/core/database/tables/products_table.dart';
import 'package:cashier_app_v2/core/database/tables/purchases.dart';
import 'package:drift/drift.dart';

class PurchaseItems extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get purchaseId => integer().references(Purchases, #id)();

  IntColumn get productId => integer().references(Products, #id)();

  IntColumn get quantity => integer()();

  RealColumn get cartonQuantity => real().withDefault(const Constant(1.0))();

  IntColumn get unitsPerCarton => integer().withDefault(const Constant(1))();

  RealColumn get purchasePrice => real()();

  RealColumn get salePrice => real().withDefault(const Constant(0.0))();

  RealColumn get total => real()();
}