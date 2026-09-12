import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

/// عنصر واحد في القائمة الجانبية.
class SidebarNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const SidebarNavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final activeColor = AppColors.gold;
    final inactiveColor = AppColors.textSecondary;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 3,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30),
          hoverColor: AppColors.gold.withValues(alpha: 0.06),
          splashColor: AppColors.gold.withValues(alpha: 0.10),
          highlightColor: AppColors.gold.withValues(alpha: 0.05),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,

            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),

              color: isActive
                  ? AppColors.gold.withValues(alpha: 0.08)
                  : Colors.transparent,

              border: Border.all(
                color: isActive
                    ? AppColors.gold.withValues(alpha: 0.28)
                    : Colors.transparent,
                width: 1,
              ),

              gradient: isActive
                  ? LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  AppColors.gold.withValues(alpha: 0.02),
                  AppColors.gold.withValues(alpha: 0.16),
                ],
              )
                  : null,

              boxShadow: isActive
                  ? [
                BoxShadow(
                  color: AppColors.gold.withValues(alpha: 0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 3),
                ),
              ]
                  : null,
            ),

            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                Expanded(
                  child: Text(
                    label,
                    textAlign: TextAlign.right,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isActive
                          ? activeColor
                          : AppColors.textPrimary.withValues(alpha: 0.85),
                      fontSize: 14,
                      fontWeight: isActive
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                ),

                const SizedBox(width: 14),

                Icon(
                  icon,
                  size: 19,
                  color: isActive ? activeColor : inactiveColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
