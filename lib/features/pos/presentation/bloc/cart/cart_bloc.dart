import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/invoice.dart';
import '../../../domain/usecases/create_invoice.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CreateInvoice createInvoice;
  List<CartLine> _items = [];
  double _discount = 0;

  CartBloc(this.createInvoice) : super(const CartUpdated(items: [])) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateQuantity>(_onUpdateQuantity);
    on<ApplyDiscount>(_onApplyDiscount);
    on<ClearCart>(_onClearCart);
    on<CheckoutCart>(_onCheckout);
  }

  void _emitUpdated(Emitter<CartState> emit) =>
      emit(CartUpdated(items: List.from(_items), discount: _discount));

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    final index = _items.indexWhere((i) => i.product.id == event.product.id);
    if (index >= 0) {
      _items[index] = _items[index].copyWith(quantity: _items[index].quantity + 1);
    } else {
      _items.add(CartLine(product: event.product));
    }
    _emitUpdated(emit);
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    _items.removeWhere((i) => i.product.id == event.productId);
    _emitUpdated(emit);
  }

  void _onUpdateQuantity(UpdateQuantity event, Emitter<CartState> emit) {
    final index = _items.indexWhere((i) => i.product.id == event.productId);
    if (index >= 0) {
      if (event.quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index] = _items[index].copyWith(quantity: event.quantity);
      }
    }
    _emitUpdated(emit);
  }

  void _onApplyDiscount(ApplyDiscount event, Emitter<CartState> emit) {
    _discount = event.discount;
    _emitUpdated(emit);
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    _items = [];
    _discount = 0;
    _emitUpdated(emit);
  }

  Future<void> _onCheckout(CheckoutCart event, Emitter<CartState> emit) async {
    if (_items.isEmpty) {
      emit(const CheckoutError('السلة فارغة'));
      _emitUpdated(emit);
      return;
    }
    emit(CheckoutInProgress());
    try {
      final invoiceItems = _items
          .map((line) => InvoiceItem(product: line.product, quantity: line.quantity))
          .toList();
      final subtotal = _items.fold<double>(0, (sum, i) => sum + i.total);
      final total = (subtotal - _discount).clamp(0, double.infinity).toDouble();

      await createInvoice(CreateInvoiceParams(
        items: invoiceItems,
        discount: _discount,
        total: total,
        paymentMethod: event.paymentMethod,
      ));

      emit(CheckoutSuccess());
      _items = [];
      _discount = 0;
      _emitUpdated(emit);
    } catch (e) {
      emit(CheckoutError(e.toString()));
      _emitUpdated(emit);
    }
  }
}
