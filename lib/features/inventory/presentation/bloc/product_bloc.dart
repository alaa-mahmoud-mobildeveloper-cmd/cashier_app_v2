import 'dart:async';

import 'package:cashier_app_v2/features/inventory/domain/entities/product_items_entit.dart';
import 'package:cashier_app_v2/features/inventory/presentation/bloc/product_event.dart';
import 'package:cashier_app_v2/features/inventory/presentation/bloc/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/add_product.dart';
import '../../domain/usecases/get_products.dart';
import '../../domain/usecases/update_product.dart';
import '../../domain/usecases/watch_products.dart';


class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProducts _getProducts;
  final WatchProducts _watchProducts;
  final AddProduct _addProduct;
  final UpdateProduct _updateProduct;

  StreamSubscription<List<ProductItem>>? _productsSubscription;

  ProductsBloc({
    required GetProducts getProducts,
    required WatchProducts watchProducts,
    required AddProduct addProduct,
    required UpdateProduct updateProduct,
    required List<String> categories,
  })  : _getProducts = getProducts,
        _watchProducts = watchProducts,
        _addProduct = addProduct,
        _updateProduct = updateProduct,
        super(ProductsState(categories: categories)) {
    on<ProductsStarted>(_onStarted);
    on<ProductsSearchChanged>(_onSearchChanged);
    on<ProductsFilterChanged>(_onFilterChanged);
    on<ProductsCategoryChanged>(_onCategoryChanged);
    on<ProductAddRequested>(_onAddRequested);
    on<ProductUpdateRequested>(_onUpdateRequested);
    on<ProductsListUpdated>(_onListUpdated);
  }

  Future<void> _onStarted(ProductsStarted event, Emitter<ProductsState> emit) async {
    emit(state.copyWith(status: ProductsStatus.loading));
    try {
      final products = await _getProducts();
      emit(state.copyWith(status: ProductsStatus.success, products: products));

      // بعد أول تحميل، بنفضل متابعين أي تحديث جاي من مصدر البيانات
      // (سواء إضافة/تعديل من الشاشة نفسها أو من مكان تاني لو الريبو
      // متوصلة بقاعدة بيانات فعلية).
      await _productsSubscription?.cancel();
      _productsSubscription = _watchProducts().listen(
            (products) => add(ProductsListUpdated(products)),
      );
    } catch (e) {
      emit(state.copyWith(status: ProductsStatus.failure, errorMessage: e.toString()));
    }
  }

  void _onListUpdated(ProductsListUpdated event, Emitter<ProductsState> emit) {
    emit(state.copyWith(status: ProductsStatus.success, products: event.products));
  }

  void _onSearchChanged(ProductsSearchChanged event, Emitter<ProductsState> emit) {
    emit(state.copyWith(searchQuery: event.query));
  }

  void _onFilterChanged(ProductsFilterChanged event, Emitter<ProductsState> emit) {
    emit(state.copyWith(selectedFilter: event.filter));
  }

  void _onCategoryChanged(ProductsCategoryChanged event, Emitter<ProductsState> emit) {
    emit(state.copyWith(selectedCategory: event.category));
  }

  Future<void> _onAddRequested(
      ProductAddRequested event,
      Emitter<ProductsState> emit,
      ) async {
    try {
      await _addProduct(event.product);
      // مفيش داعي نعمل emit هنا يدوي — التحديث هيوصل لوحده عن طريق
      // الـ stream (ProductsListUpdated) بمجرد ما الـ Repository يبعته.
    } catch (e) {
      emit(state.copyWith(status: ProductsStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> _onUpdateRequested(
      ProductUpdateRequested event,
      Emitter<ProductsState> emit,
      ) async {
    try {
      await _updateProduct(event.product);
    } catch (e) {
      emit(state.copyWith(status: ProductsStatus.failure, errorMessage: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _productsSubscription?.cancel();
    return super.close();
  }
}