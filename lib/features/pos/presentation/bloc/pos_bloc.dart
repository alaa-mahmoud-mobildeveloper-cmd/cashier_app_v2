import 'package:cashier_app_v2/features/auth/domain/session_provider.dart';
import 'package:cashier_app_v2/features/pos/data/models/cart_item_model.dart';
import 'package:cashier_app_v2/features/pos/domain/repositories/sales_repository.dart';
import 'package:cashier_app_v2/features/pos/presentation/bloc/pos_event.dart';
import 'package:cashier_app_v2/features/pos/presentation/bloc/pos_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CartBloc extends Bloc<CartEvent, CartState> {
  final SalesRepository _salesRepository;
  final SessionProvider _session;

  CartBloc(
      this._salesRepository,
      this._session,
      ) : super(const CartState()) {
    on<LoadProducts>(_loadProducts);
    on<AddProductToCart>(_addProduct);
    on<AddProductByBarcode>(_addProductByBarcode);
    on<UpdateQuantity>(_updateQuantity);
    on<RemoveFromCart>(_removeItem);
    on<ApplyDiscount>(_applyDiscount);
    on<CheckoutCart>(_checkout);
    on<ClearCart>(_clearCart);
    on<ReturnInvoiceEvent>(_returnInvoice);
  }

  Future<void> _loadProducts(
      LoadProducts event,
      Emitter<CartState> emit,
      ) async {
    final isLoadMore = event.loadMore;

    if (isLoadMore) {
      if (state.isLoadingMore || !state.hasMoreProducts) {
        return;
      }

      emit(
        state.copyWith(
          isLoadingMore: true,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: CartStatus.loading,
          products: const [],
          hasMoreProducts: true,
          isLoadingMore: false,
          searchQuery: event.searchQuery.trim(),
          category: event.category,
        ),
      );
    }

    try {
      final offset = isLoadMore ? state.products.length : 0;

      final products = await _salesRepository.getProductsPage(
        limit: CartState.pageSize,
        offset: offset,
        searchQuery:
        isLoadMore ? state.searchQuery : event.searchQuery,
        category: isLoadMore ? state.category : event.category,
      );

      final hasMore = products.length == CartState.pageSize;

      final updatedProducts = isLoadMore
          ? [
        ...state.products,
        ...products,
      ]
          : products;

      emit(
        state.copyWith(
          status: CartStatus.success,
          products: updatedProducts,
          hasMoreProducts: hasMore,
          isLoadingMore: false,
          searchQuery:
          isLoadMore ? state.searchQuery : event.searchQuery,
          category:
          isLoadMore ? state.category : event.category,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CartStatus.failure,
          isLoadingMore: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _addProductByBarcode(
      AddProductByBarcode event,
      Emitter<CartState> emit,
      ) async {
    final barcode = event.barcode.trim();

    if (barcode.isEmpty) {
      return;
    }

    try {
      final product = await _salesRepository.getProductByBarcode(
        barcode,
      );

      if (product == null) {
        _error(
          emit,
          'لا يوجد منتج بهذا الباركود',
        );
        return;
      }

      _addProduct(
        AddProductToCart(product),
        emit,
      );
    } catch (e) {
      _error(
        emit,
        e.toString(),
      );
    }
  }

  void _addProduct(
      AddProductToCart event,
      Emitter<CartState> emit,
      ) {
    final product = event.product;

    if (!product.isActive) {
      _error(
        emit,
        'هذا المنتج موقوف',
      );
      return;
    }

    if (product.stockQuantity <= 0) {
      _error(
        emit,
        'المنتج غير متوفر',
      );
      return;
    }

    final cart = List<CartItem>.from(
      state.cartItems,
    );

    final index = cart.indexWhere(
          (item) => item.product.id == product.id,
    );

    if (index == -1) {
      cart.add(
        CartItem(
          product: product,
          quantity: 1,
        ),
      );
    } else {
      final item = cart[index];

      if (item.quantity >= product.stockQuantity) {
        _error(
          emit,
          'لا توجد كمية كافية',
        );
        return;
      }

      cart[index] = item.copyWith(
        quantity: item.quantity + 1,
      );
    }

    emit(
      state.copyWith(
        cartItems: cart,
        status: CartStatus.success,
        errorMessage: null,
      ),
    );
  }

  void _updateQuantity(
      UpdateQuantity event,
      Emitter<CartState> emit,
      ) {
    final cart = List<CartItem>.from(
      state.cartItems,
    );

    final index = cart.indexWhere(
          (item) => item.product.id == event.productId,
    );

    if (index == -1) {
      return;
    }

    final item = cart[index];

    if (event.newQuantity <= 0) {
      cart.removeAt(index);
    } else {
      if (event.newQuantity > item.product.stockQuantity) {
        _error(
          emit,
          'الكمية غير متوفرة',
        );
        return;
      }

      cart[index] = item.copyWith(
        quantity: event.newQuantity,
      );
    }

    emit(
      state.copyWith(
        cartItems: cart,
        status: CartStatus.success,
      ),
    );
  }

  void _removeItem(
      RemoveFromCart event,
      Emitter<CartState> emit,
      ) {
    final cart = List<CartItem>.from(
      state.cartItems,
    )..removeWhere(
          (item) => item.product.id == event.productId,
    );

    emit(
      state.copyWith(
        cartItems: cart,
        status: CartStatus.success,
      ),
    );
  }

  void _applyDiscount(
      ApplyDiscount event,
      Emitter<CartState> emit,
      ) {
    emit(
      state.copyWith(
        discount: event.discount,
        status: CartStatus.success,
      ),
    );
  }

  Future<void> _checkout(
      CheckoutCart event,
      Emitter<CartState> emit,
      ) async {
    if (state.cartItems.isEmpty) {
      return;
    }

    emit(
      state.copyWith(
        status: CartStatus.loading,
      ),
    );

    try {
      final invoiceId = await _salesRepository.checkout(
        userId: _session.currentUserId,
        cartItems: state.cartItems,
        discount: state.discount,
        tax: state.tax,
        paymentMethod: event.paymentMethod,
        paidAmount: event.paidAmount,
        paymentAccountId: event.paymentAccountId,
        customerId: event.customerId,
        newCustomerName: event.newCustomerName,
        newCustomerPhone: event.newCustomerPhone,
      );

      final products = await _salesRepository.getProductsPage(
        limit: CartState.pageSize,
        offset: 0,
        searchQuery: state.searchQuery,
        category: state.category,
      );

      emit(
        state.copyWith(
          status: CartStatus.checkoutSuccess,
          products: products,
          cartItems: const [],
          discount: 0,
          lastInvoiceId: invoiceId,
          hasMoreProducts:
          products.length == CartState.pageSize,
          isLoadingMore: false,
        ),
      );

      emit(
        state.copyWith(
          status: CartStatus.success,
        ),
      );
    } catch (e) {
      _error(
        emit,
        e.toString(),
      );
    }
  }

  Future<void> _returnInvoice(
      ReturnInvoiceEvent event,
      Emitter<CartState> emit,
      ) async {
    emit(
      state.copyWith(
        status: CartStatus.loading,
      ),
    );

    try {
      await _salesRepository.returnInvoice(
        userId: _session.currentUserId,
        invoiceId: event.invoiceId,
      );

      final products = await _salesRepository.getProductsPage(
        limit: CartState.pageSize,
        offset: 0,
        searchQuery: state.searchQuery,
        category: state.category,
      );

      emit(
        state.copyWith(
          status: CartStatus.success,
          products: products,
          hasMoreProducts:
          products.length == CartState.pageSize,
          isLoadingMore: false,
          errorMessage: null,
        ),
      );
    } catch (e) {
      _error(
        emit,
        e.toString(),
      );
    }
  }

  void _clearCart(
      ClearCart event,
      Emitter<CartState> emit,
      ) {
    emit(
      state.copyWith(
        cartItems: const [],
        discount: 0,
        status: CartStatus.success,
      ),
    );
  }

  void _error(
      Emitter<CartState> emit,
      String message,
      ) {
    emit(
      state.copyWith(
        status: CartStatus.failure,
        errorMessage: message,
      ),
    );
  }

}
