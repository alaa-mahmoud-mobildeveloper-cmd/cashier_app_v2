import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cashier_app_v2/features/purchases/domian/repositories/product_lookup_repository.dart';
import 'package:cashier_app_v2/features/purchases/domian/usecases/add_product_quickly_usecase.dart';
import 'package:cashier_app_v2/features/purchases/domian/usecases/get_product_by_barcode_usecase.dart';
import 'package:cashier_app_v2/features/purchases/domian/usecases/search_products_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'product_search_event.dart';
import 'product_search_state.dart';

@injectable
class ProductSearchBloc extends Bloc<ProductSearchEvent, ProductSearchState> {
  ProductSearchBloc(this._search, this._getByBarcode, this._addProduct)
      : super(const ProductSearchState()) {
    on<ProductSearchQueryChanged>(_onChanged, transformer: restartable());
    on<ProductSearchSubmitted>(_onSubmitted, transformer: droppable());
    on<ProductSearchCleared>((_, emit) => emit(const ProductSearchState()));
    // droppable: يمنع الحفظ المزدوج لو الزرار اتداس مرتين
    on<ProductAddSubmitted>(_onAddSubmitted, transformer: droppable());
  }

  final SearchProductsUseCase _search;
  final GetProductByBarcodeUseCase _getByBarcode;
  final AddProductQuicklyUseCase _addProduct;

  // ───────── البحث بالكتابة ─────────

  Future<void> _onChanged(
      ProductSearchQueryChanged event,
      Emitter<ProductSearchState> emit,
      ) async {
    final q = event.query.trim();
    if (q.isEmpty) {
      emit(const ProductSearchState());
      return;
    }

    emit(state.copyWith(status: ProductSearchStatus.loading, query: q));
    await Future<void>.delayed(const Duration(milliseconds: 300)); // debounce

    try {
      final found = await _search(q);
      emit(state.copyWith(
        status: found.isEmpty
            ? ProductSearchStatus.notFound
            : ProductSearchStatus.results,
        results: found,
      ));
    } catch (_) {
      emit(state.copyWith(
        status: ProductSearchStatus.failure,
        errorMessage: 'حصل خطأ أثناء البحث',
      ));
    }
  }

  // ───────── Enter / سكانر الباركود ─────────

  Future<void> _onSubmitted(
      ProductSearchSubmitted event,
      Emitter<ProductSearchState> emit,
      ) async {
    final q = event.query.trim();
    if (q.isEmpty) return;

    try {
      final exact = await _getByBarcode(q);
      if (exact != null) {
        if (!exact.isActive) {
          emit(state.copyWith(
            status: ProductSearchStatus.failure,
            errorMessage: 'الصنف "${exact.name}" معطّل. فعّله من شاشة الأصناف.',
          ));
          return;
        }
        emit(state.copyWith(
            status: ProductSearchStatus.exactMatch, selected: exact));
        return;
      }

      final found = await _search(q);
      if (found.length == 1) {
        emit(state.copyWith(
            status: ProductSearchStatus.exactMatch, selected: found.first));
      } else if (found.isEmpty) {
        emit(state.copyWith(
            status: ProductSearchStatus.addNewRequested, query: q));
      } else {
        emit(state.copyWith(
            status: ProductSearchStatus.results, results: found, query: q));
      }
    } catch (_) {
      emit(state.copyWith(
        status: ProductSearchStatus.failure,
        errorMessage: 'حصل خطأ أثناء البحث',
      ));
    }
  }

  // ───────── إضافة صنف جديد ─────────

  Future<void> _onAddSubmitted(
      ProductAddSubmitted event,
      Emitter<ProductSearchState> emit,
      ) async {
    emit(state.copyWith(addStatus: ProductAddStatus.submitting));
    try {
      final product = await _addProduct(event.params);
      emit(state.copyWith(
        addStatus: ProductAddStatus.success,
        createdProduct: product,
      ));
    } on DuplicateBarcodeException catch (e) {
      emit(state.copyWith(
        addStatus: ProductAddStatus.failure,
        addError: 'الباركود ده موجود لصنف "${e.existingProductName}"',
      ));
    } on ArgumentError catch (e) {
      emit(state.copyWith(
        addStatus: ProductAddStatus.failure,
        addError: e.message.toString(),
      ));
    } catch (_) {
      emit(state.copyWith(
        addStatus: ProductAddStatus.failure,
        addError: 'حصل خطأ أثناء حفظ الصنف، حاول تاني',
      ));
    }
  }
}