import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class ExportButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  const ExportButton({super.key, required this.label, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600, fontSize: 13)),
              const SizedBox(width: 8),
              Icon(icon, size: 16, color: AppColors.gold),
            ],
          ),
        ),
      ),
    );
  }
}
