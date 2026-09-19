import 'package:flutter/material.dart';
import 'package:cashier_app_v2/core/database/app_database.dart';

import '../../../../core/constants/app_colors.dart';

class ProductsGrid extends StatelessWidget {
  final List<Product> products;
  final ValueChanged<Product> onProductTap;

  const ProductsGrid({super.key, required this.products, required this.onProductTap});

  IconData _iconFor(String category) {
    switch (category) {
      case 'ألبان':
        return Icons.local_drink_outlined;
      case 'مشروبات':
        return Icons.water_drop_outlined;
      case 'منظفات':
        return Icons.cleaning_services_outlined;
      case 'مخبوزات':
        return Icons.bakery_dining_outlined;
      default:
        return Icons.inventory_2_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(child: Text('لا توجد منتجات', style: TextStyle(color: AppColors.textSecondary)));
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = (constraints.maxWidth / 180).floor();
        if (crossAxisCount < 2) crossAxisCount = 2;

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 0.85,
          ),
          itemBuilder: (_, i) {
            final product = products[i];
            final outOfStock = product.stockQuantity <= 0;

            return InkWell(
              onTap: outOfStock ? null : () => onProductTap(product),
              borderRadius: BorderRadius.circular(16),
              child: Opacity(
                opacity: outOfStock ? 0.5 : 1,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(12)),
                          child: Icon(_iconFor(product.category), color: AppColors.textSecondary, size: 32),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.name,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      const SizedBox(height: 4),
                      Text('متبقي: ${product.stockQuantity}', style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
                      const SizedBox(height: 4),
                      Text('${product.price.toStringAsFixed(0)} ج', style: const TextStyle(color: AppColors.gold, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}