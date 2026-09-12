import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// عنوان قسم فرعي جوه القائمة (زي "العمليات" أو "الإدارة")
class SidebarSectionTitle extends StatelessWidget {
  final String title;
  const SidebarSectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 4),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(title, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
      ),
    );
  }
}
