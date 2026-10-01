import 'package:cashier_app_v2/features/inventory/domain/entities/product_items_entit.dart';
import 'package:cashier_app_v2/features/inventory/domain/entities/product_status.dart';
import 'package:cashier_app_v2/features/inventory/domain/repositories/product_repository.dart';
import 'package:equatable/equatable.dart';

enum ProductsStatus {
  initial,
  loading,
  success,
  failure,
}

class ProductsState extends Equatable {
  static const allCategoriesLabel = 'كل الفئات';

  final ProductsStatus status;
  final List<ProductItem> products;
  final List<String> categories;

  final ProductFilter selectedFilter;
  final String selectedCategory;
  final String searchQuery;

  final int totalCount;
  final bool hasMore;
  final bool isLoadingMore;

  final ProductStats? stats;

  final String? errorMessage;

  const ProductsState({
    this.status = ProductsStatus.initial,
    this.products = const [],
    this.categories = const [],
    this.selectedFilter = ProductFilter.all,
    this.selectedCategory = allCategoriesLabel,
    this.searchQuery = '',
    this.totalCount = 0,
    this.hasMore = true,
    this.isLoadingMore = false,
    this.stats,
    this.errorMessage,
  });

  ProductsState copyWith({
    ProductsStatus? status,
    List<ProductItem>? products,
    List<String>? categories,
    ProductFilter? selectedFilter,
    String? selectedCategory,
    String? searchQuery,
    int? totalCount,
    bool? hasMore,
    bool? isLoadingMore,
    ProductStats? stats,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ProductsState(
      status: status ?? this.status,
      products: products ?? this.products,
      categories: categories ?? this.categories,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
      totalCount: totalCount ?? this.totalCount,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      stats: stats ?? this.stats,
      errorMessage: clearError
          ? null
          : errorMessage ?? this.errorMessage,
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
    totalCount,
    hasMore,
    isLoadingMore,
    stats,
    errorMessage,
  ];
}