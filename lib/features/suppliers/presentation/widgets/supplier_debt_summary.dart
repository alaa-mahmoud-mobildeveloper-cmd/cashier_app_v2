import 'package:flutter/material.dart';
import 'package:cashier_app_v2/core/constants/app_colors.dart';

class SupplierDebtSummary extends StatelessWidget {
  final double totalAmount;
  final double totalCollected;
  final double totalDue;

  const SupplierDebtSummary({
    super.key,
    required this.totalAmount,
    required this.totalCollected,
    required this.totalDue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _Metric(
                  label: 'إجمالي التوريدات',
                  value: totalAmount,
                  color: AppColors.textPrimary,
                ),
              ),
              Expanded(
                child: _Metric(
                  label: 'تم تحصيله',
                  value: totalCollected,
                  color: AppColors.success,
                ),
              ),
              Expanded(
                child: _Metric(
                  label: 'الأجل المتبقي',
                  value: totalDue,
                  color: totalDue > 0 ? AppColors.danger : AppColors.textHint,
                ),
              ),
            ],
          ),
          if (totalAmount > 0) ...[
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: (totalCollected / totalAmount).clamp(0, 1),
                minHeight: 8,
                backgroundColor: AppColors.surfaceLight,
                valueColor: const AlwaysStoppedAnimation(AppColors.gold),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  final String label;
  final double value;
  final Color color;
  const _Metric({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label,
            style: const TextStyle(color: AppColors.textHint, fontSize: 11)),
        const SizedBox(height: 4),
        Text(
          '${value.toStringAsFixed(0)} ج.م',
          style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ],
    );
  }
}
