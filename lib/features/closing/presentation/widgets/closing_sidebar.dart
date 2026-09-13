import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class ClosingSidebar extends StatelessWidget {
  final VoidCallback? onHistoryPressed;

  const ClosingSidebar({
    super.key,
    this.onHistoryPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          left: BorderSide(
            color: AppColors.border,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 18),
            child: Text(
              'القفلات السابقة',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),

          const Divider(),

          Expanded(
            child: Center(
              child: Text(
                'لا توجد قفلات محفوظة',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textHint,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}