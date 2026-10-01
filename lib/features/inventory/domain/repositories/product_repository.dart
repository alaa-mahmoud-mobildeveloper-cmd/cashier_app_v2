import 'package:cashier_app_v2/features/inventory/domain/entities/product_items_entit.dart';
import 'package:cashier_app_v2/features/inventory/domain/entities/product_status.dart';

class ProductPage {
  final List<ProductItem> items;
  final int totalCount;

  const ProductPage({
    required this.items,
    required this.totalCount,
  });

  bool get hasMore => items.length < totalCount;
}

class ProductStats {
  final int productsCount;
  final double stockValue;
  final double expectedProfit;
  final int outOfStockCount;
  final int lowStockCount;

  const ProductStats({
    required this.productsCount,
    required this.stockValue,
    required this.expectedProfit,
    required this.outOfStockCount,
    required this.lowStockCount,
  });
}

abstract class ProductRepository {
  Future<ProductPage> getProductsPage({
    required int offset,
    required int limit,
    String searchQuery,
    ProductFilter filter,
    String? category,
  });

  Future<ProductStats> getProductStats({
    String searchQuery,
    ProductFilter filter,
    String? category,
  });

  Stream<List<ProductItem>> watchProducts();

  Future<List<ProductItem>> getProducts();

  Future<void> addProduct(ProductItem product);

  Future<void> updateProduct(ProductItem product);

  Future<void> deleteProduct(String id);
}