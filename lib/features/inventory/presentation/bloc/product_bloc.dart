import 'dart:async';

import 'package:cashier_app_v2/features/inventory/domain/repositories/product_repository.dart';
import 'package:cashier_app_v2/features/inventory/presentation/bloc/product_event.dart';
import 'package:cashier_app_v2/features/inventory/presentation/bloc/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/add_product.dart';
import '../../domain/usecases/delete_product.dart';
import '../../domain/usecases/get_product_stats.dart';
import '../../domain/usecases/get_products.dart';
import '../../domain/usecases/update_product.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  static const int _pageSize = 50;

  final GetProducts _getProducts;
  final GetProductStats _getProductStats;
  final AddProduct _addProduct;
  final UpdateProduct _updateProduct;
  final DeleteProduct _deleteProduct;

  Timer? _searchDebounce;

  ProductsBloc({
    required GetProducts getProducts,
    required GetProductStats getProductStats,
    required AddProduct addProduct,
    required UpdateProduct updateProduct,
    required DeleteProduct deleteProduct,
    required List<String> categories,
  })  : _getProducts = getProducts,
        _getProductStats = getProductStats,
        _addProduct = addProduct,
        _updateProduct = updateProduct,
        _deleteProduct = deleteProduct,
        super(
        ProductsState(
          categories: categories,
        ),
      ) {
    on<ProductsStarted>(_onStarted);
    on<ProductsSearchChanged>(_onSearchChanged);
    on<ProductsSearchSubmitted>(_onSearchSubmitted);
    on<ProductsFilterChanged>(_onFilterChanged);
    on<ProductsCategoryChanged>(_onCategoryChanged);
    on<ProductsLoadMoreRequested>(_onLoadMore);
    on<ProductsRefreshRequested>(_onRefresh);
    on<ProductAddRequested>(_onAddRequested);
    on<ProductUpdateRequested>(_onUpdateRequested);
    on<ProductDeleteRequested>(_onDeleteRequested);
  }

  Future<void> _onStarted(
      ProductsStarted event,
      Emitter<ProductsState> emit,
      ) async {
    await _loadFirstPage(emit);
  }

  void _onSearchChanged(
      ProductsSearchChanged event,
      Emitter<ProductsState> emit,
      ) {
    _searchDebounce?.cancel();

    _searchDebounce = Timer(
      const Duration(milliseconds: 350),
          () {
        if (!isClosed) {
          add(
            ProductsSearchSubmitted(event.query),
          );
        }
      },
    );
  }

  Future<void> _onSearchSubmitted(
      ProductsSearchSubmitted event,
      Emitter<ProductsState> emit,
      ) async {
    emit(
      state.copyWith(
        searchQuery: event.query.trim(),
      ),
    );

    await _loadFirstPage(emit);
  }

  Future<void> _onFilterChanged(
      ProductsFilterChanged event,
      Emitter<ProductsState> emit,
      ) async {
    emit(
      state.copyWith(
        selectedFilter: event.filter,
      ),
    );

    await _loadFirstPage(emit);
  }

  Future<void> _onCategoryChanged(
      ProductsCategoryChanged event,
      Emitter<ProductsState> emit,
      ) async {
    emit(
      state.copyWith(
        selectedCategory: event.category,
      ),
    );

    await _loadFirstPage(emit);
  }

  Future<void> _onLoadMore(
      ProductsLoadMoreRequested event,
      Emitter<ProductsState> emit,
      ) async {
    if (state.isLoadingMore || !state.hasMore) {
      return;
    }

    emit(
      state.copyWith(
        isLoadingMore: true,
      ),
    );

    try {
      final page = await _getProducts(
        offset: state.products.length,
        limit: _pageSize,
        searchQuery: state.searchQuery,
        filter: state.selectedFilter,
        category: _selectedCategory,
      );

      final mergedProducts = [
        ...state.products,
        ...page.items,
      ];

      emit(
        state.copyWith(
          status: ProductsStatus.success,
          products: mergedProducts,
          totalCount: page.totalCount,
          hasMore: mergedProducts.length < page.totalCount,
          isLoadingMore: false,
          clearError: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingMore: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onRefresh(
      ProductsRefreshRequested event,
      Emitter<ProductsState> emit,
      ) async {
    await _loadFirstPage(
      emit,
      showLoading: false,
    );
  }

  Future<void> _onAddRequested(
      ProductAddRequested event,
      Emitter<ProductsState> emit,
      ) async {
    try {
      await _addProduct(event.product);

      await _loadFirstPage(
        emit,
        showLoading: false,
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ProductsStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onUpdateRequested(
      ProductUpdateRequested event,
      Emitter<ProductsState> emit,
      ) async {
    try {
      await _updateProduct(event.product);

      await _loadFirstPage(
        emit,
        showLoading: false,
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ProductsStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onDeleteRequested(
      ProductDeleteRequested event,
      Emitter<ProductsState> emit,
      ) async {
    try {
      await _deleteProduct(event.id);

      await _loadFirstPage(
        emit,
        showLoading: false,
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ProductsStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _loadFirstPage(
      Emitter<ProductsState> emit, {
        bool showLoading = true,
      }) async {
    if (showLoading) {
      emit(
        state.copyWith(
          status: ProductsStatus.loading,
          products: const [],
          totalCount: 0,
          hasMore: true,
          isLoadingMore: false,
          clearError: true,
        ),
      );
    } else {
      emit(
        state.copyWith(
          isLoadingMore: false,
          clearError: true,
        ),
      );
    }

    try {
      final results = await Future.wait([
        _getProducts(
          offset: 0,
          limit: _pageSize,
          searchQuery: state.searchQuery,
          filter: state.selectedFilter,
          category: _selectedCategory,
        ),
        _getProductStats(
          searchQuery: state.searchQuery,
          filter: state.selectedFilter,
          category: _selectedCategory,
        ),
      ]);

      final page = results[0] as ProductPage;
      final stats = results[1] as ProductStats;

      emit(
        state.copyWith(
          status: ProductsStatus.success,
          products: page.items,
          totalCount: page.totalCount,
          hasMore: page.items.length < page.totalCount,
          isLoadingMore: false,
          stats: stats,
          clearError: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ProductsStatus.failure,
          errorMessage: e.toString(),
          isLoadingMore: false,
        ),
      );
    }
  }

  String? get _selectedCategory {
    if (state.selectedCategory ==
        ProductsState.allCategoriesLabel) {
      return null;
    }

    return state.selectedCategory;
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }
}