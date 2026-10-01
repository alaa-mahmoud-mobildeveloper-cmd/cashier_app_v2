import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class AddAdvanceSection extends StatelessWidget {
  final TextEditingController amountController;
  final TextEditingController reasonController;
  final VoidCallback? onSubmit;
  final bool isSubmitting;

  const AddAdvanceSection({
    super.key,
    required this.amountController,
    required this.reasonController,
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
            'إضافة سلفة',
            style: TextStyle(
              color: AppColors.danger,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: amountController,
            decoration: const InputDecoration(hintText: 'المبلغ (ج)'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: reasonController,
            decoration: const InputDecoration(hintText: 'السبب (اختياري)'),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isSubmitting ? null : onSubmit,
              child: isSubmitting
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('تسجيل السلفة'),
            ),
          ),
        ],
      ),
    );
  }
}
