import 'package:cashier_app_v2/core/database/app_database.dart';
import 'package:cashier_app_v2/features/inventory/domain/entities/product_status.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

abstract class ProductsLocalDataSource {
  Stream<List<Product>> watchAll();

  Future<List<Product>> getAll();

  Future<List<Product>> getPage({
    required int offset,
    required int limit,
    String searchQuery,
    ProductFilter filter,
    String? category,
  });

  Future<int> count({
    String searchQuery,
    ProductFilter filter,
    String? category,
  });

  Future<ProductStatsRow> getStats({
    String searchQuery,
    ProductFilter filter,
    String? category,
  });

  Future<int> insert(ProductsCompanion entry);

  Future<void> update(int id, ProductsCompanion entry);

  Future<void> delete(int id);
}

class ProductStatsRow {
  final int productsCount;
  final double stockValue;
  final double expectedProfit;
  final int outOfStockCount;
  final int lowStockCount;

  const ProductStatsRow({
    required this.productsCount,
    required this.stockValue,
    required this.expectedProfit,
    required this.outOfStockCount,
    required this.lowStockCount,
  });
}

@Injectable(as: ProductsLocalDataSource)
class DriftProductsLocalDataSource implements ProductsLocalDataSource {
  final AppDatabase _db;

  DriftProductsLocalDataSource(this._db);

  @override
  Stream<List<Product>> watchAll() {
    return _db.select(_db.products).watch();
  }

  @override
  Future<List<Product>> getAll() {
    return _db.select(_db.products).get();
  }

  @override
  Future<List<Product>> getPage({
    required int offset,
    required int limit,
    String searchQuery = '',
    ProductFilter filter = ProductFilter.all,
    String? category,
  }) async {
    final query = _buildFilteredQuery(
      searchQuery: searchQuery,
      filter: filter,
      category: category,
    );

    query
      ..orderBy([
            (p) => OrderingTerm(
          expression: p.id,
          mode: OrderingMode.desc,
        ),
      ])
      ..limit(limit, offset: offset);

    return query.get();
  }

  @override
  Future<int> count({
    String searchQuery = '',
    ProductFilter filter = ProductFilter.all,
    String? category,
  }) async {
    final query = _buildFilteredQuery(
      searchQuery: searchQuery,
      filter: filter,
      category: category,
    );

    final result = await query.get();
    return result.length;
  }

  @override
  Future<ProductStatsRow> getStats({
    String searchQuery = '',
    ProductFilter filter = ProductFilter.all,
    String? category,
  }) async {
    final products = await _buildFilteredQuery(
      searchQuery: searchQuery,
      filter: filter,
      category: category,
    ).get();

    double stockValue = 0;
    double expectedProfit = 0;
    int outOfStockCount = 0;
    int lowStockCount = 0;

    for (final product in products) {
      final unitCost = product.unitsPerCarton > 0
          ? product.cartonPrice / product.unitsPerCarton
          : product.purchasePrice;

      stockValue += unitCost * product.stockQuantity;

      expectedProfit +=
          (product.price - unitCost) * product.stockQuantity;

      if (product.stockQuantity <= 0) {
        outOfStockCount++;
      } else if (product.stockQuantity <= 10) {
        lowStockCount++;
      }
    }

    return ProductStatsRow(
      productsCount: products.length,
      stockValue: stockValue,
      expectedProfit: expectedProfit,
      outOfStockCount: outOfStockCount,
      lowStockCount: lowStockCount,
    );
  }

  SimpleSelectStatement<$ProductsTable, Product> _buildFilteredQuery({
    required String searchQuery,
    required ProductFilter filter,
    String? category,
  }) {
    final query = _db.select(_db.products);

    final conditions = <Expression<bool>>[];

    final normalizedSearch = searchQuery.trim();

    if (normalizedSearch.isNotEmpty) {
      conditions.add(
        _db.products.name.like('%$normalizedSearch%') |
        _db.products.barcode.like('%$normalizedSearch%'),
      );
    }

    if (category != null && category.isNotEmpty) {
      conditions.add(
        _db.products.category.equals(category),
      );
    }

    switch (filter) {
      case ProductFilter.all:
        break;

      case ProductFilter.available:
        conditions.add(
          _db.products.stockQuantity.isBiggerThanValue(10),
        );
        break;

      case ProductFilter.lowStock:
        conditions.add(
          _db.products.stockQuantity.isBetweenValues(1, 10),
        );
        break;

      case ProductFilter.outOfStock:
        conditions.add(
          _db.products.stockQuantity.isSmallerOrEqualValue(0),
        );
        break;
    }

    if (conditions.isNotEmpty) {
      query.where((_) {
        Expression<bool> expression = conditions.first;

        for (var i = 1; i < conditions.length; i++) {
          expression = expression & conditions[i];
        }

        return expression;
      });
    }

    return query;
  }

  @override
  Future<int> insert(ProductsCompanion entry) {
    return _db.into(_db.products).insert(entry);
  }

  @override
  Future<void> update(
      int id,
      ProductsCompanion entry,
      ) async {
    await (_db.update(_db.products)
      ..where((t) => t.id.equals(id)))
        .write(entry);
  }

  @override
  Future<void> delete(int id) async {
    await (_db.delete(_db.products)
      ..where((t) => t.id.equals(id)))
        .go();
  }
}