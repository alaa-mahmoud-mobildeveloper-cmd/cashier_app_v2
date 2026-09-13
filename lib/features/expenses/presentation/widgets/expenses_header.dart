import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class ExpensesHeader extends StatelessWidget {
  final VoidCallback onAdd;
  const ExpensesHeader({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 14, 28, 18),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('المصروفات', style: TextStyle(color: AppColors.textPrimary, fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text('متابعة وإدارة مصروفات المحل', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
        ]),
        ElevatedButton.icon(onPressed: onAdd, icon: const Icon(Icons.add), label: const Text('إضافة مصروف')),
      ]),
    );
  }
}
