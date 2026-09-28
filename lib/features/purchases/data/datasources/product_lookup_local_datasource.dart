import 'package:cashier_app_v2/core/database/app_database.dart'; // عدّل المسار
import 'package:drift/drift.dart';

abstract class ProductLookupLocalDataSource {
  Future<List<Product>> search(String query, {int limit = 20});
  Future<Product?> findByBarcode(String barcode);
  Future<Product> insert(ProductsCompanion companion);
}