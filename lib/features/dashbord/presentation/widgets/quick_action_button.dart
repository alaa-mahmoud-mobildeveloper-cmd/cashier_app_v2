import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class QuickActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool highlighted;
  final VoidCallback? onTap;

  const QuickActionButton({
    super.key,
    required this.label,
    required this.icon,
    this.highlighted = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final background = highlighted ? AppColors.gold : Theme.of(context).cardColor;
    final foreground = highlighted ? Colors.black : AppColors.textPrimary;

    return Material(
      color: background,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: foreground, size: 26),
              const SizedBox(height: 10),
              Text(label, style: TextStyle(color: foreground, fontWeight: FontWeight.w600, fontSize: 13)),
            ],
          ),
        ),
      ),
    );
  }
}
