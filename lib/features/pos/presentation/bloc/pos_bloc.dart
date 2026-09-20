import 'dart:async';

import 'package:cashier_app_v2/core/database/app_database.dart';
import 'package:cashier_app_v2/features/pos/presentation/bloc/pos_event.dart';
import 'package:cashier_app_v2/features/pos/presentation/bloc/pos_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cashier_app_v2/features/auth/domain/session_provider.dart';
import 'package:cashier_app_v2/features/pos/data/models/cart_item_model.dart';
import 'package:cashier_app_v2/features/pos/domain/repositories/sales_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class CartBloc extends Bloc<CartEvent, CartState> {
  final SalesRepository _salesRepository;
  final SessionProvider _session;
  // هنا بالضبط
  StreamSubscription<List<Product>>? _productsSubscription;
  CartBloc(this._salesRepository, this._session) : super(const CartState()) {
    on<LoadProducts>(_loadProducts);
    on<AddProductToCart>(_addProduct);
    on<UpdateQuantity>(_updateQuantity);
    on<RemoveFromCart>(_removeItem);
    on<ApplyDiscount>(_applyDiscount);
    on<CheckoutCart>(_checkout);
    on<ClearCart>(_clearCart);
    on<ReturnInvoiceEvent>(_returnInvoice);

    _productsSubscription = _salesRepository.watchAllProducts().listen((products) {
      add(const LoadProducts());
    });

  }
  Future<void> _returnInvoice(
      ReturnInvoiceEvent event,
      Emitter<CartState> emit,
      ) async {
    emit(state.copyWith(status: CartStatus.loading));

    try {
      // استدعاء دالة الإرجاع من الـ Repository وإرسال الـ ID لو موجود
      await _salesRepository.returnInvoice(
        userId: _session.currentUserId,
        invoiceId: event.invoiceId,
      );

      // إعادة تحميل المنتجات عشان كميات المخزون تحدث في الشاشة فوراً
      final products =  _salesRepository.getAllProducts();

      emit(
        state.copyWith(
          status: CartStatus.success,
          products: await products,
          errorMessage: null,
        ),
      );
    } catch (e) {
      _error(emit, e.toString());
    }
  }
  Future<void> _loadProducts(LoadProducts event, Emitter<CartState> emit) async {
    emit(state.copyWith(status: CartStatus.loading));
    try {
      final products = await _salesRepository.getAllProducts();
      emit(state.copyWith(status: CartStatus.success, products: products));
    } catch (e) {
      emit(state.copyWith(status: CartStatus.failure, errorMessage: e.toString()));
    }
  }

  void _addProduct(AddProductToCart event, Emitter<CartState> emit) {
    final product = event.product;

    if (!product.isActive) {
      _error(emit, "هذا المنتج موقوف");
      return;
    }
    if (product.stockQuantity <= 0) {
      _error(emit, "المنتج غير متوفر");
      return;
    }

    final cart = List<CartItem>.from(state.cartItems);
    final index = cart.indexWhere((item) => item.product.id == product.id);

    if (index == -1) {
      cart.add(CartItem(product: product, quantity: 1));
    } else {
      final item = cart[index];
      if (item.quantity >= product.stockQuantity) {
        _error(emit, "لا توجد كمية كافية");
        return;
      }
      cart[index] = item.copyWith(quantity: item.quantity + 1);
    }

    emit(state.copyWith(cartItems: cart, status: CartStatus.success, errorMessage: null));
  }

  void _updateQuantity(UpdateQuantity event, Emitter<CartState> emit) {
    final cart = List<CartItem>.from(state.cartItems);
    final index = cart.indexWhere((item) => item.product.id == event.productId);
    if (index == -1) return;

    final item = cart[index];
    if (event.newQuantity <= 0) {
      cart.removeAt(index);
    } else {
      if (event.newQuantity > item.product.stockQuantity) {
        _error(emit, "الكمية غير متوفرة");
        return;
      }
      cart[index] = item.copyWith(quantity: event.newQuantity);
    }

    emit(state.copyWith(cartItems: cart, status: CartStatus.success));
  }

  void _removeItem(RemoveFromCart event, Emitter<CartState> emit) {
    final cart = List<CartItem>.from(state.cartItems)
      ..removeWhere((item) => item.product.id == event.productId);
    emit(state.copyWith(cartItems: cart, status: CartStatus.success));
  }

  void _applyDiscount(ApplyDiscount event, Emitter<CartState> emit) {
    emit(state.copyWith(discount: event.discount, status: CartStatus.success));
  }

  Future<void> _checkout(CheckoutCart event, Emitter<CartState> emit) async {
    if (state.cartItems.isEmpty) return;
    emit(state.copyWith(status: CartStatus.loading));

    try {
      final invoiceId = await _salesRepository.checkout(
        userId: _session.currentUserId,
        cartItems: state.cartItems,
        discount: state.discount,
        tax: state.tax,
        paymentMethod: event.paymentMethod,
        paidAmount: event.paidAmount,
      );

      final products = await _salesRepository.getAllProducts();

      emit(state.copyWith(
        status: CartStatus.checkoutSuccess,
        products: products,
        cartItems: const [],
        discount: 0,
        lastInvoiceId: invoiceId,
      ));

      emit(state.copyWith(status: CartStatus.success));
    } catch (e) {
      _error(emit, e.toString());
    }
  }

  void _clearCart(ClearCart event, Emitter<CartState> emit) {
    emit(state.copyWith(cartItems: const [], discount: 0, status: CartStatus.success));
  }

  void _error(Emitter<CartState> emit, String message) {
    emit(state.copyWith(status: CartStatus.failure, errorMessage: message));
  }
}