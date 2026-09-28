import 'package:cashier_app_v2/core/database/app_database.dart'; // عدّل المسار
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'product_lookup_local_datasource.dart';

@LazySingleton(as: ProductLookupLocalDataSource)
class ProductLookupLocalDataSourceImpl implements ProductLookupLocalDataSource {
  ProductLookupLocalDataSourceImpl(this._db);
  final AppDatabase _db;

  @override
  Future<List<Product>> search(String query, {int limit = 20}) {
    final like = '%${query.trim()}%';
    return (_db.select(_db.products)
      ..where((p) =>
      p.isActive.equals(true) &
      (p.name.like(like) | p.barcode.like(like)))
      ..orderBy([(p) => OrderingTerm.asc(p.name)])
      ..limit(limit))
        .get();
  }

  @override
  Future<Product?> findByBarcode(String barcode) {
    // من غير فلتر isActive عمدًا: الباركود محجوز حتى لو الصنف معطّل
    return (_db.select(_db.products)..where((p) => p.barcode.equals(barcode)))
        .getSingleOrNull();
  }

  @override
  Future<Product> insert(ProductsCompanion companion) async {
    final id = await _db.into(_db.products).insert(companion);
    return (_db.select(_db.products)..where((p) => p.id.equals(id))).getSingle();
  }
}