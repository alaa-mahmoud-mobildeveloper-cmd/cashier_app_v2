import 'package:flutter/material.dart';

class Product {
  final String name;
  final String category;
  final double price;
  final int stock;
  final String barcode;
  final IconData icon;

  const Product({
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
    required this.barcode,
    required this.icon,
  });
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  double get total => product.price * quantity;
}

enum PaymentMethod {
  cash('كاش', Icons.payments_outlined),
  wallet('محفظه ', Icons.wallet_outlined),

  visa('فيزا', Icons.credit_card_outlined),
  fawry('فوري', Icons.wifi_outlined),
  credit('آجل', Icons.access_time_outlined);

  final String label;
  final IconData icon;
  const PaymentMethod(this.label, this.icon);
}
