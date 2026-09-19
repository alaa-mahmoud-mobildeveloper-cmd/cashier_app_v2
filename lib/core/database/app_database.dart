import 'dart:io';

import 'package:cashier_app_v2/core/database/tables/app_settings.dart';
import 'package:cashier_app_v2/core/database/tables/dailyclosing.dart';
import 'package:cashier_app_v2/core/database/tables/expenses.dart';
import 'package:cashier_app_v2/core/database/tables/purchase_items.dart';
import 'package:cashier_app_v2/core/database/tables/purchases.dart';
import 'package:cashier_app_v2/core/database/tables/suppliers.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:injectable/injectable.dart';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/users_table.dart';
import 'tables/products_table.dart';
import 'tables/invoices_table.dart';
import 'tables/invoice_items_table.dart';
import 'tables/stock_movements_table.dart';

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
    Expenses,
    DailyClosings,
    AppSettings,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  @override
  int get schemaVersion => 12;   // كانت 11

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },

    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.createTable(stockMovements);
      }

      if (from < 3) {
        await m.createTable(suppliers);
      }

      if (from < 4) {
        await m.createTable(purchases);
        await m.createTable(purchaseItems);
      }

      if (from < 6) {
        await m.createTable(expenses);
      }

      if (from < 8) {
        await m.createTable(dailyClosings);
      }

      if (from < 9) {
        await m.createTable(appSettings);
      }

      if (from < 11) {
        await m.addColumn(invoices, invoices.profit);
        await m.addColumn(invoiceItems, invoiceItems.profit);
      }

      // Version 12
      // إضافة سعر الكرتونة وعدد الوحدات فيها لحساب سعر شراء الوحدة تلقائيًا
      if (from < 12) {
        await m.addColumn(products, products.cartonPrice);
        await m.addColumn(products, products.unitsPerCarton);
      }
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();

    final file = File(
      p.join(dir.path, 'nova_pos.sqlite'),
    );

    print('DATABASE PATH:');
    print(file.path);

    return NativeDatabase.createInBackground(file);
  });
}