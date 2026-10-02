import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/database/app_database.dart';

class ClosingSidebar extends StatelessWidget {
  final List<DailyClosing> closings;
  final VoidCallback? onHistoryPressed;

  const ClosingSidebar({
    super.key,
    this.closings = const [],
    this.onHistoryPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(left: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 18),
            child: Text(
              'القفلات السابقة',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: AppColors.textSecondary),
            ),
          ),
          const Divider(),
          Expanded(
            child: closings.isEmpty
                ? Center(
                    child: Text(
                      'لا توجد قفلات محفوظة',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textHint,
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    itemCount: closings.length,
                    separatorBuilder: (_, __) =>
                        const Divider(height: 1, color: AppColors.border),
                    itemBuilder: (context, index) {
                      final closing = closings[index];
                      return ListTile(
                        dense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        leading: Icon(
                          closing.isClosed
                              ? Icons.lock_outline
                              : Icons.pending_outlined,
                          color: closing.isClosed
                              ? AppColors.success
                              : AppColors.gold,
                          size: 20,
                        ),
                        title: Text(
                          _formatDate(closing.date),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'المبيعات: ${_formatMoney(closing.totalSales)} ج',
                        ),
                        trailing: closing.isClosed
                            ? const Icon(
                                Icons.check_circle_outline,
                                color: AppColors.success,
                                size: 18,
                              )
                            : null,
                        onTap: onHistoryPressed,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) =>
      '${date.day.toString().padLeft(2, '0')}/'
      '${date.month.toString().padLeft(2, '0')}/${date.year}';

  String _formatMoney(double value) {
    if (value == value.roundToDouble()) {
      return value.toInt().toString();
    }
    return value.toStringAsFixed(2);
  }
}
