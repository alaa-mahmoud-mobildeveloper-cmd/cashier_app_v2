import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class AddProductSection extends StatelessWidget {
  final TextEditingController barcodeController;
  final ValueChanged<String>? onSubmit;
  final bool isSubmitting;

  const AddProductSection({
    super.key,
    required this.barcodeController,
    this.onSubmit,
    this.isSubmitting = false,
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
          const Text(
            'مسح منتج أخذه العامل',
            style: TextStyle(
              color: AppColors.gold,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: barcodeController,
            onSubmitted: isSubmitting ? null : onSubmit,
            decoration: InputDecoration(
              hintText: 'امسح الباركود أو اكتبه واضغط Enter...',
              suffixIcon: IconButton(
                tooltip: 'تسجيل المنتج',
                onPressed: isSubmitting
                    ? null
                    : () => onSubmit?.call(barcodeController.text),
                icon: isSubmitting
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.add_box_outlined),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
