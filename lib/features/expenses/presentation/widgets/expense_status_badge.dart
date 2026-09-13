import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/expense.dart';

class ExpenseStatusBadge extends StatelessWidget {
  final ExpenseStatus status;
  const ExpenseStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final isPaid = status == ExpenseStatus.paid;
    final color = isPaid ? AppColors.success : AppColors.warning;
    return Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), decoration: BoxDecoration(color: color.withValues(alpha: .12), borderRadius: BorderRadius.circular(16), border: Border.all(color: color.withValues(alpha: .35))), child: Text(isPaid ? 'مدفوع' : 'معلق', style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)));
  }
}
