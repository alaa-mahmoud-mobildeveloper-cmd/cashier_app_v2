import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class ProductsListSection extends StatelessWidget {
  const ProductsListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('الأصناف المأخوذة (0)', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 14)),
          Expanded(
            child: Center(
              child: Text('لا توجد أصناف مأخوذة', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
            ),
          ),
        ],
      ),
    );
  }
}