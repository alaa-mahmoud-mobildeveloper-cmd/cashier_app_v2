import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class DebtsHeader extends StatelessWidget {
  final String outstanding;
  final VoidCallback? onReminder;

  const DebtsHeader({super.key, required this.outstanding, this.onReminder});

  static const double _mobileBreakpoint = 600;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < _mobileBreakpoint;

        const titleBlock = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'الآجل والمديونيات',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'متابعة الفواتير الآجلة وسجل السداد',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
            ),
          ],
        );

        final reminderButton = OutlinedButton.icon(
          onPressed: onReminder,
          icon: const Icon(Icons.schedule_outlined, size: 18),
          label: Text(
            'متبقي: $outstanding',
            overflow: TextOverflow.ellipsis,
          ),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.danger,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        );

        if (isMobile) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                titleBlock,
                const SizedBox(height: 12),
                reminderButton,
              ],
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.fromLTRB(28, 14, 28, 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Flexible(child: titleBlock),
              const SizedBox(width: 16),
              reminderButton,
            ],
          ),
        );
      },
    );
  }
}