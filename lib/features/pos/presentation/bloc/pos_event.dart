import 'package:equatable/equatable.dart';
import 'package:cashier_app_v2/core/database/app_database.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class LoadProducts extends CartEvent {
  final String searchQuery;
  final String category;
  final bool loadMore;

  const LoadProducts({
    this.searchQuery = '',
    this.category = 'الكل',
    this.loadMore = false,
  });

  @override
  List<Object?> get props => [
    searchQuery,
    category,
    loadMore,
  ];
}

class AddProductToCart extends CartEvent {
  final Product product;

  const AddProductToCart(this.product);

  @override
  List<Object?> get props => [product];
}

class AddProductByBarcode extends CartEvent {
  final String barcode;

  const AddProductByBarcode(this.barcode);

  @override
  List<Object?> get props => [barcode];
}

class UpdateQuantity extends CartEvent {
  final int productId;
  final int newQuantity;

  const UpdateQuantity(
      this.productId,
      this.newQuantity,
      );

  @override
  List<Object?> get props => [
    productId,
    newQuantity,
  ];
}

class RemoveFromCart extends CartEvent {
  final int productId;

  const RemoveFromCart(this.productId);

  @override
  List<Object?> get props => [productId];
}

class ApplyDiscount extends CartEvent {
  final double discount;

  const ApplyDiscount(this.discount);

  @override
  List<Object?> get props => [discount];
}

class CheckoutCart extends CartEvent {
  final String paymentMethod;
  final double? paidAmount;

  const CheckoutCart({
    required this.paymentMethod,
    this.paidAmount,
  });

  @override
  List<Object?> get props => [
    paymentMethod,
    paidAmount,
  ];
}

class ClearCart extends CartEvent {
  const ClearCart();
}

class ReturnInvoiceEvent extends CartEvent {
  final int? invoiceId;

  const ReturnInvoiceEvent([this.invoiceId]);

  @override
  List<Object?> get props => [invoiceId];
}