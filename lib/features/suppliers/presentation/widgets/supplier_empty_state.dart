import 'package:flutter/material.dart';
import 'package:cashier_app_v2/core/constants/app_colors.dart';

class SupplierEmptyState extends StatelessWidget {
  const SupplierEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: const BoxDecoration(
              color: AppColors.surfaceLight,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.local_shipping_outlined,
                size: 32, color: AppColors.textHint),
          ),
          const SizedBox(height: 16),
          const Text(
            'لا يوجد موردين',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'اضغط على "إضافة مورد" لإضافة أول مورد',
            style: TextStyle(color: AppColors.textHint, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
