import 'package:equatable/equatable.dart';
import 'package:cashier_app_v2/core/database/app_database.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
  @override
  List<Object?> get props => [];
}

class LoadProducts extends CartEvent {
  const LoadProducts();
}

class AddProductToCart extends CartEvent {
  final Product product;
  const AddProductToCart(this.product);
  @override
  List<Object?> get props => [product];
}

class UpdateQuantity extends CartEvent {
  final int productId;
  final int newQuantity;
  const UpdateQuantity(this.productId, this.newQuantity);
  @override
  List<Object?> get props => [productId, newQuantity];
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

/// لاحظ: مفيش userId هنا. الـ Bloc نفسه هيجيبه من SessionProvider
class CheckoutCart extends CartEvent {
  final String paymentMethod;
  final double? paidAmount;

  const CheckoutCart({
    required this.paymentMethod,
    this.paidAmount,
  });

  @override
  List<Object?> get props => [paymentMethod, paidAmount];
}

class ClearCart extends CartEvent {
  const ClearCart();
}