import 'package:cashier_app_v2/features/debts/domain/entities/debt_invoice.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';


class DebtStatusBadge extends StatelessWidget {
  final DebtStatus status;

  const DebtStatusBadge({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    late final String label;
    late final Color color;

    switch (status) {
      case DebtStatus.paid:
        label = 'محصل';
        color = AppColors.success;

      case DebtStatus.partial:
        label = 'جزئي';
        color = AppColors.warning;

      case DebtStatus.unpaid:
        label = 'آجل كامل';
        color = AppColors.danger;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withValues(alpha: 0.35),
        ),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
