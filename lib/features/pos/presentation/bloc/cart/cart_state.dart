import 'package:equatable/equatable.dart';
import '../../../domain/entities/product.dart';

class CartLine extends Equatable {
  final Product product;
  final int quantity;
  const CartLine({required this.product, this.quantity = 1});

  double get total => product.price * quantity;

  CartLine copyWith({int? quantity}) =>
      CartLine(product: product, quantity: quantity ?? this.quantity);

  @override
  List<Object?> get props => [product, quantity];
}

abstract class CartState extends Equatable {
  const CartState();
  @override
  List<Object?> get props => [];
}

class CartUpdated extends CartState {
  final List<CartLine> items;
  final double discount;

  const CartUpdated({required this.items, this.discount = 0});

  double get subtotal => items.fold(0, (sum, item) => sum + item.total);
  double get total => (subtotal - discount).clamp(0, double.infinity);

  CartUpdated copyWith({List<CartLine>? items, double? discount}) =>
      CartUpdated(items: items ?? this.items, discount: discount ?? this.discount);

  @override
  List<Object?> get props => [items, discount];
}

class CheckoutInProgress extends CartState {
  @override
  List<Object?> get props => [];
}

class CheckoutSuccess extends CartState {
  @override
  List<Object?> get props => [];
}

class CheckoutError extends CartState {
  final String message;
  const CheckoutError(this.message);
  @override
  List<Object?> get props => [message];
}
