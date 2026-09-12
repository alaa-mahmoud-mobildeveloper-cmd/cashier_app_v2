import 'product.dart';

class InvoiceItem {
  final Product product;
  final int quantity;
  const InvoiceItem({required this.product, required this.quantity});

  double get total => product.price * quantity;
}

class Invoice {
  final String id;
  final List<InvoiceItem> items;
  final double discount;
  final double total;
  final String paymentMethod;
  final DateTime createdAt;

  const Invoice({
    required this.id,
    required this.items,
    required this.discount,
    required this.total,
    required this.paymentMethod,
    required this.createdAt,
  });
}
