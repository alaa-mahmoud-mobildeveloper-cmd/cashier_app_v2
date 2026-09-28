import 'package:cashier_app_v2/core/database/app_database.dart'; // عدّل المسار
import 'package:cashier_app_v2/features/purchases/domian/entities/product_search_result.dart';
import 'package:cashier_app_v2/features/purchases/domian/repositories/product_lookup_repository.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../datasources/product_lookup_local_datasource.dart';

@LazySingleton(as: ProductLookupRepository)
class ProductLookupRepositoryImpl implements ProductLookupRepository {
  ProductLookupRepositoryImpl(this._local);
  final ProductLookupLocalDataSource _local;

  ProductSearchResult _map(Product p) => ProductSearchResult(
    id: p.id,
    name: p.name,
    barcode: p.barcode,
    category: p.category,
    unit: p.unit,
    unitsPerCarton: p.unitsPerCarton,
    cartonPrice: p.cartonPrice,
    purchasePrice: p.purchasePrice,
    salePrice: p.price,
    stockQuantity: p.stockQuantity,
    isActive: p.isActive,
  );

  @override
  Future<List<ProductSearchResult>> search(String query) async =>
      (await _local.search(query)).map(_map).toList();

  @override
  Future<ProductSearchResult?> findByBarcode(String barcode) async {
    final row = await _local.findByBarcode(barcode);
    return row == null ? null : _map(row);
  }

  @override
  Future<ProductSearchResult> createProduct(NewProductParams p) async {
    final now = DateTime.now();
    final row = await _local.insert(
      ProductsCompanion.insert(
        name: p.name,
        barcode: p.barcode,
        category: p.category.isEmpty ? 'عام' : p.category,
        price: p.price,
        stockQuantity: 0,
        unit: Value(p.unit.isEmpty ? 'قطعة' : p.unit),
        cartonPrice: Value(p.cartonPrice),
        unitsPerCarton: Value(p.unitsPerCarton),
        purchasePrice: Value(p.cartonPrice / p.unitsPerCarton),
        cartonQuantity: const Value(0.0),
        createdAt: Value(now),
        updatedAt: Value(now),
      ),
    );
    return _map(row);
  }
}