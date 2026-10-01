import 'package:equatable/equatable.dart';
import 'package:cashier_app_v2/core/database/app_database.dart';
import 'package:cashier_app_v2/features/pos/data/models/cart_item_model.dart';

enum CartStatus {
  initial,
  loading,
  success,
  failure,
  checkoutSuccess,
}

class CartState extends Equatable {
  final List<Product> products;
  final List<CartItem> cartItems;

  final double discount;
  final double tax;

  final CartStatus status;
  final String? errorMessage;
  final int? lastInvoiceId;

  final bool hasMoreProducts;
  final bool isLoadingMore;

  final String searchQuery;
  final String category;

  static const int pageSize = 50;

  const CartState({
    this.products = const [],
    this.cartItems = const [],
    this.discount = 0,
    this.tax = 0,
    this.status = CartStatus.initial,
    this.errorMessage,
    this.lastInvoiceId,
    this.hasMoreProducts = true,
    this.isLoadingMore = false,
    this.searchQuery = '',
    this.category = 'الكل',
  });

  double get totalAmount {
    return cartItems.fold(
      0,
          (sum, item) => sum + item.totalPrice,
    );
  }

  double get netAmount {
    return totalAmount + tax - discount;
  }

  CartState copyWith({
    List<Product>? products,
    List<CartItem>? cartItems,
    double? discount,
    double? tax,
    CartStatus? status,
    String? errorMessage,
    int? lastInvoiceId,
    bool? hasMoreProducts,
    bool? isLoadingMore,
    String? searchQuery,
    String? category,
  }) {
    return CartState(
      products: products ?? this.products,
      cartItems: cartItems ?? this.cartItems,
      discount: discount ?? this.discount,
      tax: tax ?? this.tax,
      status: status ?? this.status,
      errorMessage: errorMessage,
      lastInvoiceId: lastInvoiceId ?? this.lastInvoiceId,
      hasMoreProducts: hasMoreProducts ?? this.hasMoreProducts,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      searchQuery: searchQuery ?? this.searchQuery,
      category: category ?? this.category,
    );
  }

  @override
  List<Object?> get props => [
    products,
    cartItems,
    discount,
    tax,
    status,
    errorMessage,
    lastInvoiceId,
    hasMoreProducts,
    isLoadingMore,
    searchQuery,
    category,
  ];
}