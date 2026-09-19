import 'package:cashier_app_v2/features/inventory/domain/entities/product_items_entit.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/product_status.dart';

enum ProductsStatus { initial, loading, success, failure }

class ProductsState extends Equatable {
  static const allCategoriesLabel = 'كل الفئات';

  final ProductsStatus status;
  final List<ProductItem> products;
  final List<String> categories;
  final ProductFilter selectedFilter;
  final String selectedCategory;
  final String searchQuery;
  final String? errorMessage;

  const ProductsState({
    this.status = ProductsStatus.initial,
    this.products = const [],
    this.categories = const [],
    this.selectedFilter = ProductFilter.all,
    this.selectedCategory = allCategoriesLabel,
    this.searchQuery = '',
    this.errorMessage,
  });

  /// القائمة بعد تطبيق الفلتر + الفئة + البحث. الشاشة بتقرا من هنا
  /// بس، مفيهاش أي منطق فلترة بتاعها هي.
  List<ProductItem> get filteredProducts {
    final query = searchQuery.trim();
    return products.where((p) {
      final matchesFilter = selectedFilter.matches(p.status);
      final matchesCategory =
          selectedCategory == allCategoriesLabel || p.category == selectedCategory;
      final matchesSearch =
          query.isEmpty || p.name.contains(query) || p.barcode.contains(query);
      return matchesFilter && matchesCategory && matchesSearch;
    }).toList();
  }

  ProductsState copyWith({
    ProductsStatus? status,
    List<ProductItem>? products,
    List<String>? categories,
    ProductFilter? selectedFilter,
    String? selectedCategory,
    String? searchQuery,
    String? errorMessage,
  }) {
    return ProductsState(
      status: status ?? this.status,
      products: products ?? this.products,
      categories: categories ?? this.categories,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    products,
    categories,
    selectedFilter,
    selectedCategory,
    searchQuery,
    errorMessage,
  ];
}