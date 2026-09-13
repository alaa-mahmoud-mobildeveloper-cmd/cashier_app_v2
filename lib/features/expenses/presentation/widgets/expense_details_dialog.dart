import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/expense.dart';
import 'expense_status_badge.dart';

class ExpenseDetailsDialog extends StatelessWidget {
  final Expense expense;
  const ExpenseDetailsDialog({super.key, required this.expense});

  @override
  Widget build(BuildContext context) => AlertDialog(title: const Row(children: [Icon(Icons.receipt_long_outlined, color: AppColors.gold), SizedBox(width: 8), Text('تفاصيل المصروف')]), content: SizedBox(width: 420, child: Column(mainAxisSize: MainAxisSize.min, children: [
    _row('اسم المصروف', expense.title), _row('التصنيف', expense.category), _row('المبلغ', '${expense.amount.toStringAsFixed(2)} ج', AppColors.danger), _row('الوصف', expense.description.isEmpty ? 'لا يوجد وصف' : expense.description), const SizedBox(height: 8), Align(alignment: Alignment.centerRight, child: ExpenseStatusBadge(status: expense.status)),
  ])), actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('إغلاق'))]);

  Widget _row(String label, String value, [Color? color]) => Container(width: double.infinity, margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.all(11), decoration: BoxDecoration(color: AppColors.surfaceLight, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.border)), child: Row(children: [Text('$label:', style: const TextStyle(color: AppColors.textSecondary)), const Spacer(), Flexible(child: Text(value, textAlign: TextAlign.end, style: TextStyle(color: color ?? AppColors.textPrimary, fontWeight: FontWeight.w600)))]));
}
