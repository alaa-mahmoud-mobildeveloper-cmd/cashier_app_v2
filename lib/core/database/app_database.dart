import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'package:cashier_app_v2/core/database/tables/app_settings.dart';
import 'package:cashier_app_v2/core/database/tables/customers_table.dart';
import 'package:cashier_app_v2/core/database/tables/dailyclosing.dart';
import 'package:cashier_app_v2/core/database/tables/expenses.dart';
import 'package:cashier_app_v2/core/database/tables/invoice_items_table.dart';
import 'package:cashier_app_v2/core/database/tables/invoices_table.dart';
import 'package:cashier_app_v2/core/database/tables/products_table.dart';
import 'package:cashier_app_v2/core/database/tables/purchase_items.dart';
import 'package:cashier_app_v2/core/database/tables/purchase_payments.dart';
import 'package:cashier_app_v2/core/database/tables/purchases.dart';
import 'package:cashier_app_v2/core/database/tables/stock_movements_table.dart';
import 'package:cashier_app_v2/core/database/tables/suppliers.dart';
import 'package:cashier_app_v2/core/database/tables/users_table.dart';

part 'app_database.g.dart';

@lazySingleton
@DriftDatabase(
  tables: [
    Users,
    Products,
    Invoices,
    InvoiceItems,
    StockMovements,
    Suppliers,
    Purchases,
    PurchaseItems,
    PurchasePayments,
    Expenses,
    DailyClosings,
    Customers,
    AppSettings,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 16;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      // Version 2
      if (from < 2) {
        await _safeCreateTable(m, stockMovements);
      }

      // Version 3
      if (from < 3) {
        await _safeCreateTable(m, suppliers);
      }

      // Version 4
      if (from < 4) {
        await _safeCreateTable(m, purchases);
        await _safeCreateTable(m, purchaseItems);
      }

      // Version 6
      if (from < 6) {
        await _safeCreateTable(m, expenses);
      }

      // Version 8
      if (from < 8) {
        await _safeCreateTable(m, dailyClosings);
      }

      // Version 9
      if (from < 9) {
        await _safeCreateTable(m, appSettings);
      }

      // Version 11
      if (from < 11) {
        await _safeAddColumn(m, invoices, invoices.profit);
        await _safeAddColumn(m, invoiceItems, invoiceItems.profit);
      }

      // Version 12
      if (from < 12) {
        await _safeAddColumn(m, products, products.cartonPrice);
        await _safeAddColumn(m, products, products.unitsPerCarton);
        await _safeCreateTable(m, customers);
      }

      // Version 13
      if (from < 13) {
        await _safeAddColumn(m, invoices, invoices.customerId);
      }

      // Version 14
      if (from < 14) {
        await _safeAddColumn(m, products, products.cartonQuantity);
      }

      // Version 15
      if (from < 15) {
        await _safeAddColumn(m, purchaseItems, purchaseItems.cartonQuantity);
        await _safeAddColumn(m, purchaseItems, purchaseItems.unitsPerCarton);
        await _safeAddColumn(m, purchaseItems, purchaseItems.salePrice);
      }

      // Version 16
      if (from < 16) {
        await _safeAddColumn(m, purchases, purchases.dueDate);
        await _safeCreateTable(m, purchasePayments);
      }
    },
  );

  Future<void> _safeAddColumn(
      Migrator m,
      TableInfo table,
      GeneratedColumn column,
      ) async {
    try {
      await m.addColumn(table, column);
    } catch (e) {
      final message = e.toString().toLowerCase();
      if (!message.contains('duplicate column name')) {
        rethrow;
      }
      print('Migration: column ${column.name} already exists, skipped.');
    }
  }

  Future<void> _safeCreateTable(
      Migrator m,
      TableInfo table,
      ) async {
    try {
      await m.createTable(table);
    } catch (e) {
      final message = e.toString().toLowerCase();
      if (!message.contains('already exists')) {
        rethrow;
      }
      print('Migration: table already exists, skipped.');
    }
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'nova_pos.sqlite'));

    print('DATABASE PATH: ${file.path}');

    return NativeDatabase.createInBackground(file);
  });
}