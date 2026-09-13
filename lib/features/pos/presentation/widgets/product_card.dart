import 'package:cashier_app_v2/features/pos/domain/entities/product.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';


class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: product.stock > 0 ? onTap : null,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Expanded(child: Container(
              decoration: BoxDecoration(color: AppColors.surfaceLight, borderRadius: BorderRadius.circular(12)),
              child: Icon(product.icon, size: 52, color: AppColors.textHint),
            )),
            const SizedBox(height: 9),
            Text(product.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('${product.price.toStringAsFixed(0)} ج', style: const TextStyle(color: AppColors.gold, fontSize: 17, fontWeight: FontWeight.bold)),
              Text('متبقي: ${product.stock}', style: TextStyle(color: product.stock <= 5 ? AppColors.danger : AppColors.textHint, fontSize: 11)),
            ]),
          ]),
        ),
      ),
    );
  }
}
