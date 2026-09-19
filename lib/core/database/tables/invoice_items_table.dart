import 'package:cashier_app_v2/core/database/tables/invoices_table.dart';
import 'package:cashier_app_v2/core/database/tables/products_table.dart';
import 'package:drift/drift.dart';

class InvoiceItems extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get invoiceId =>
      integer().references(
        Invoices,
        #id,
        onDelete: KeyAction.cascade,
      )();

  IntColumn get productId =>
      integer().references(
        Products,
        #id,
      )();

  TextColumn get productName => text()();

  TextColumn get barcode => text()();

  /// أضف هذا العمود
  TextColumn get category => text()();

  TextColumn get unit => text()();

  RealColumn get purchasePrice => real()();

  RealColumn get unitPrice => real()();

  IntColumn get quantity => integer()();

  RealColumn get totalPrice => real()();

  /// إجمالي ربح الصنف
  RealColumn get profit =>
      real().withDefault(const Constant(0.0))();
}