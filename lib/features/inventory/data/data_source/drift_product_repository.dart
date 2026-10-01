import 'package:cashier_app_v2/core/database/app_database.dart';
import 'package:cashier_app_v2/features/inventory/data/data_source/products_local_data_source.dart';
import 'package:cashier_app_v2/features/inventory/domain/entities/product_items_entit.dart';
import 'package:cashier_app_v2/features/inventory/domain/entities/product_status.dart';
import 'package:cashier_app_v2/features/inventory/presentation/uitl/duplicate_barcode_exception.dart';
import 'package:cashier_app_v2/features/inventory/domain/repositories/product_repository.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:sqlite3/sqlite3.dart';

@Injectable(as: ProductRepository)
class DriftProductRepository implements ProductRepository {
  final ProductsLocalDataSource _dataSource;

  DriftProductRepository(this._dataSource);

  @override
  Future<ProductPage> getProductsPage({
    required int offset,
    required int limit,
    String searchQuery = '',
    ProductFilter filter = ProductFilter.all,
    String? category,
  }) async {
    final rows = await _dataSource.getPage(
      offset: offset,
      limit: limit,
      searchQuery: searchQuery,
      filter: filter,
      category: category,
    );

    final totalCount = await _dataSource.count(
      searchQuery: searchQuery,
      filter: filter,
      category: category,
    );

    return ProductPage(
      items: rows.map(_toEntity).toList(),
      totalCount: totalCount,
    );
  }

  @override
  Future<ProductStats> getProductStats({
    String searchQuery = '',
    ProductFilter filter = ProductFilter.all,
    String? category,
  }) async {
    final stats = await _dataSource.getStats(
      searchQuery: searchQuery,
      filter: filter,
      category: category,
    );

    return ProductStats(
      productsCount: stats.productsCount,
      stockValue: stats.stockValue,
      expectedProfit: stats.expectedProfit,
      outOfStockCount: stats.outOfStockCount,
      lowStockCount: stats.lowStockCount,
    );
  }

  @override
  Stream<List<ProductItem>> watchProducts() {
    return _dataSource
        .watchAll()
        .map((rows) => rows.map(_toEntity).toList());
  }

  @override
  Future<List<ProductItem>> getProducts() async {
    final rows = await _dataSource.getAll();
    return rows.map(_toEntity).toList();
  }

  @override
  Future<void> addProduct(ProductItem product) async {
    try {
      await _dataSource.insert(_toCompanion(product));
    } on SqliteException catch (e) {
      throw _mapSqliteException(e, product);
    }
  }

  @override
  Future<void> updateProduct(ProductItem product) async {
    final id = int.tryParse(product.id);

    if (id == null) {
      return;
    }

    try {
      await _dataSource.update(
        id,
        _toCompanion(product),
      );
    } on SqliteException catch (e) {
      throw _mapSqliteException(e, product);
    }
  }

  @override
  Future<void> deleteProduct(String id) {
    final parsedId = int.tryParse(id);

    if (parsedId == null) {
      return Future.value();
    }

    return _dataSource.delete(parsedId);
  }

  ProductItem _toEntity(Product row) {
    return ProductItem(
      id: row.id.toString(),
      name: row.name,
      barcode: row.barcode,
      category: row.category,
      sellPrice: row.price,
      cartonPrice: row.cartonPrice,
      unitsPerCarton: row.unitsPerCarton,
      cartonQuantity: row.cartonQuantity,
      quantity: row.stockQuantity,
    );
  }

  ProductsCompanion _toCompanion(ProductItem item) {
    return ProductsCompanion(
      name: Value(item.name),
      barcode: Value(item.barcode),
      category: Value(item.category),
      price: Value(item.sellPrice),
      cartonPrice: Value(item.cartonPrice),
      unitsPerCarton: Value(item.unitsPerCarton),
      cartonQuantity: Value(item.cartonQuantity),
      purchasePrice: Value(item.unitCost),
      stockQuantity: Value(item.quantity),
    );
  }

  Exception _mapSqliteException(
      SqliteException e,
      ProductItem product,
      ) {
    final message = e.message.toLowerCase();

    final isDuplicateBarcode =
        message.contains('unique') &&
            message.contains('barcode');

    if (isDuplicateBarcode) {
      return DuplicateBarcodeException(product.barcode);
    }

    return e;
  }
}