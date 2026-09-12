import 'package:equatable/equatable.dart';
import '../../../domain/entities/product.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
  @override
  List<Object?> get props => [];
}

class AddToCart extends CartEvent {
  final Product product;
  const AddToCart(this.product);
  @override
  List<Object?> get props => [product];
}

class RemoveFromCart extends CartEvent {
  final String productId;
  const RemoveFromCart(this.productId);
  @override
  List<Object?> get props => [productId];
}

class UpdateQuantity extends CartEvent {
  final String productId;
  final int quantity;
  const UpdateQuantity(this.productId, this.quantity);
  @override
  List<Object?> get props => [productId, quantity];
}

class ApplyDiscount extends CartEvent {
  final double discount;
  const ApplyDiscount(this.discount);
  @override
  List<Object?> get props => [discount];
}

class ClearCart extends CartEvent {}

class CheckoutCart extends CartEvent {
  final String paymentMethod;
  const CheckoutCart(this.paymentMethod);
  @override
  List<Object?> get props => [paymentMethod];
}
