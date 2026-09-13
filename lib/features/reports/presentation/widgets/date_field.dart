import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class DateField extends StatelessWidget {
  final DateTime date;
  final VoidCallback? onTap;

  const DateField({super.key, required this.date, this.onTap});

  String get _formatted =>
      '${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}/${date.year}';

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_formatted, style: const TextStyle(color: AppColors.textPrimary, fontSize: 13)),
              const SizedBox(width: 8),
              const Icon(Icons.calendar_today_outlined, size: 15, color: AppColors.textSecondary),
            ],
          ),
        ),
      ),
    );
  }
}
