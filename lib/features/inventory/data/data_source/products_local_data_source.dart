import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import 'package:cashier_app_v2/core/database/app_database.dart';

/// مصدر البيانات المحلي (قاعدة بيانات Drift) لجدول الأصناف.
/// بيتكلم بأنواع Drift الخام (Product/ProductsCompanion) بس، ومفيهوش
/// أي علاقة بـ ProductItem (domain entity) — التحويل مسؤولية الـ
/// Repository.
abstract class ProductsLocalDataSource {
  Stream<List<Product>> watchAll();

  Future<List<Product>> getAll();

  Future<int> insert(ProductsCompanion entry);

  Future<void> update(int id, ProductsCompanion entry);

  Future<void> delete(int id);
}

@Injectable(as: ProductsLocalDataSource)
class DriftProductsLocalDataSource implements ProductsLocalDataSource {
  final AppDatabase _db;

  DriftProductsLocalDataSource(this._db);

  @override
  Stream<List<Product>> watchAll() => _db.select(_db.products).watch();

  @override
  Future<List<Product>> getAll() => _db.select(_db.products).get();

  @override
  Future<int> insert(ProductsCompanion entry) => _db.into(_db.products).insert(entry);

  @override
  Future<void> update(int id, ProductsCompanion entry) async {
    await (_db.update(_db.products)..where((t) => t.id.equals(id))).write(entry);
  }

  @override
  Future<void> delete(int id) async {
    await (_db.delete(_db.products)..where((t) => t.id.equals(id))).go();
  }
}