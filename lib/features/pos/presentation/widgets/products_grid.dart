import 'package:cashier_app_v2/features/pos/domain/entities/product.dart';
import 'package:flutter/material.dart';

import 'product_card.dart';

class ProductsGrid extends StatelessWidget {
  final List<Product> products;
  final ValueChanged<Product> onProductTap;

  const ProductsGrid({super.key, required this.products, required this.onProductTap});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(18),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 245,
        mainAxisExtent: 245,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (_, index) => ProductCard(product: products[index], onTap: () => onProductTap(products[index])),
    );
  }
}
