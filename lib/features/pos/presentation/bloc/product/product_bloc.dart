import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/product.dart';
import '../../../domain/usecases/get_products.dart';
import '../../../../../core/usecases/usecase.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;

  ProductBloc(this.getProducts) : super(ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<FilterProductsByCategory>(_onFilterByCategory);
    on<SearchProducts>(_onSearch);
  }

  Future<void> _onLoadProducts(LoadProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final products = await getProducts(const NoParams());
      emit(ProductLoaded(allProducts: products, filteredProducts: products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void _onFilterByCategory(FilterProductsByCategory event, Emitter<ProductState> emit) {
    final s = state;
    if (s is ProductLoaded) {
      final filtered = _applyFilters(s.allProducts, event.category, s.searchQuery);
      emit(s.copyWith(filteredProducts: filtered, selectedCategory: event.category));
    }
  }

  void _onSearch(SearchProducts event, Emitter<ProductState> emit) {
    final s = state;
    if (s is ProductLoaded) {
      final filtered = _applyFilters(s.allProducts, s.selectedCategory, event.query);
      emit(s.copyWith(filteredProducts: filtered, searchQuery: event.query));
    }
  }

  List<Product> _applyFilters(List<Product> all, String category, String query) {
    var result = category == 'الكل' ? all : all.where((p) => p.category == category).toList();
    if (query.isNotEmpty) {
      result = result
          .where((p) => p.name.toLowerCase().contains(query.toLowerCase()) || p.id == query)
          .toList();
    }
    return result;
  }
}
