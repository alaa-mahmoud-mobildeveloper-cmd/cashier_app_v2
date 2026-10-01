import 'dart:async';

import 'package:cashier_app_v2/features/inventory/domain/entities/product_items_entit.dart';
import 'package:cashier_app_v2/features/inventory/domain/entities/product_status.dart';

import '../../domain/repositories/product_repository.dart';

class InMemoryProductRepository implements ProductRepository {
  final List<ProductItem> _items = [
    ProductItem.fromCartonQuantity(
      id: '1',
      name: 'زيت عباد الشمس 1.5 لتر',
      barcode: '6001',
      category: 'مواد غذائية',
      sellPrice: 28,
      cartonPrice: 230,
      unitsPerCarton: 12,
      cartonQuantity: 4,
    ).sellUnits(3),
    ProductItem.fromCartonQuantity(
      id: '2',
      name: 'سكر أبيض 1 كجم',
      barcode: '6002',
      category: 'مواد غذائية',
      sellPrice: 12,
      cartonPrice: 155,
      unitsPerCarton: 20,
      cartonQuantity: 1,
    ).sellUnits(17),
    ProductItem.fromCartonQuantity(
      id: '3',
      name: 'شاي ليبتون 100 كيس',
      barcode: '6003',
      category: 'مشروبات',
      sellPrice: 45,
      cartonPrice: 188,
      unitsPerCarton: 6,
      cartonQuantity: 1,
    ).sellUnits(6),
    ProductItem.fromCartonQuantity(
      id: '4',
      name: 'أرز بسمتي 5 كجم',
      barcode: '6004',
      category: 'مواد غذائية',
      sellPrice: 85,
      cartonPrice: 235,
      unitsPerCarton: 4,
      cartonQuantity: 6,
    ).sellUnits(2),
    ProductItem.fromCartonQuantity(
      id: '5',
      name: 'صابون اريل 3 كجم',
      barcode: '6005',
      category: 'منظفات',
      sellPrice: 55,
      cartonPrice: 224,
      unitsPerCarton: 6,
      cartonQuantity: 1,
    ).sellUnits(1),
    ProductItem.fromCartonQuantity(
      id: '6',
      name: 'حليب بارمالات 1 لتر',
      barcode: '6006',
      category: 'ألبان',
      sellPrice: 18,
      cartonPrice: 152,
      unitsPerCarton: 12,
      cartonQuantity: 5,
    ),
    ProductItem.fromCartonQuantity(
      id: '7',
      name: 'ماء معدني 1.5 لتر',
      barcode: '6007',
      category: 'مشروبات',
      sellPrice: 5,
      cartonPrice: 28,
      unitsPerCarton: 12,
      cartonQuantity: 10,
    ),
  ];

  final StreamController<List<ProductItem>> _controller =
  StreamController<List<ProductItem>>.broadcast();

  InMemoryProductRepository() {
    _emit();
  }

  void _emit() {
    if (!_controller.isClosed) {
      _controller.add(
        List.unmodifiable(_items),
      );
    }
  }

  @override
  Future<ProductPage> getProductsPage({
    required int offset,
    required int limit,
    String searchQuery = '',
    ProductFilter filter = ProductFilter.all,
    String? category,
  }) async {
    final filtered = _applyFilters(
      searchQuery: searchQuery,
      filter: filter,
      category: category,
    );

    final safeOffset = offset.clamp(0, filtered.length);
    final safeEnd = (safeOffset + limit).clamp(
      safeOffset,
      filtered.length,
    );

    final page = filtered.sublist(
      safeOffset,
      safeEnd,
    );

    return ProductPage(
      items: List.unmodifiable(page),
      totalCount: filtered.length,
    );
  }

  @override
  Future<ProductStats> getProductStats({
    String searchQuery = '',
    ProductFilter filter = ProductFilter.all,
    String? category,
  }) async {
    final products = _applyFilters(
      searchQuery: searchQuery,
      filter: filter,
      category: category,
    );

    double stockValue = 0;
    double expectedProfit = 0;
    int outOfStockCount = 0;
    int lowStockCount = 0;

    for (final product in products) {
      stockValue += product.unitCost * product.quantity;
      expectedProfit += product.profit * product.quantity;

      if (product.quantity <= 0) {
        outOfStockCount++;
      } else if (product.quantity <= 10) {
        lowStockCount++;
      }
    }

    return ProductStats(
      productsCount: products.length,
      stockValue: stockValue,
      expectedProfit: expectedProfit,
      outOfStockCount: outOfStockCount,
      lowStockCount: lowStockCount,
    );
  }

  List<ProductItem> _applyFilters({
    required String searchQuery,
    required ProductFilter filter,
    String? category,
  }) {
    final query = searchQuery.trim().toLowerCase();

    return _items.where((product) {
      final matchesSearch = query.isEmpty ||
          product.name.toLowerCase().contains(query) ||
          product.barcode.toLowerCase().contains(query);

      final matchesCategory =
          category == null || category.isEmpty || product.category == category;

      final matchesFilter = filter.matches(product.status);

      return matchesSearch && matchesCategory && matchesFilter;
    }).toList();
  }

  @override
  Stream<List<ProductItem>> watchProducts() {
    return _controller.stream;
  }

  @override
  Future<List<ProductItem>> getProducts() async {
    return List.unmodifiable(_items);
  }

  @override
  Future<void> addProduct(ProductItem product) async {
    _items.insert(0, product);
    _emit();
  }

  @override
  Future<void> updateProduct(ProductItem product) async {
    final index = _items.indexWhere(
          (item) => item.id == product.id,
    );

    if (index != -1) {
      _items[index] = product;
      _emit();
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    _items.removeWhere(
          (item) => item.id == id,
    );

    _emit();
  }

  void dispose() {
    _controller.close();
  }
}