import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class AddProductSection extends StatelessWidget {
  final TextEditingController barcodeController;

  const AddProductSection({
    super.key,
    required this.barcodeController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('مسح منتج أخذه العامل', style: TextStyle(color: AppColors.gold, fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 12),
          TextField(
            controller: barcodeController,
            decoration: const InputDecoration(hintText: 'امسح الباركود أو اكتبه واضغط Enter...'),
          ),
        ],
      ),
    );
  }
}