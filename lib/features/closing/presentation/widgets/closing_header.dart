import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class ClosingHeader extends StatelessWidget {
  final DateTime date;
  final double todayNet;
  final int todayInvoices;
  final bool showStats;
  const ClosingHeader({
    super.key,
    required this.date,
    required this.todayNet,
    required this.todayInvoices, required this.showStats,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.border,
          ),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.menu_book_outlined,
            color: AppColors.gold,
            size: 26,
          ),

          const SizedBox(width: 12),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'قفلة اليوم',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 2),
              Text(
                _formatDate(date),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),

          const Spacer(),

          _HeaderValue(
            title: 'صافي اليوم',
            value: '${_formatMoney(todayNet)} ج',
            color: AppColors.success,
          ),

          const SizedBox(width: 32),

          _HeaderValue(
            title: 'فواتير اليوم',
            value: todayInvoices.toString(),
            color: AppColors.goldLight,
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر',
    ];

    return '${_arabicDay(date.weekday)}، '
        '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  String _arabicDay(int weekday) {
    const days = [
      'الاثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت',
      'الأحد',
    ];

    return days[weekday - 1];
  }

  String _formatMoney(double value) {
    if (value == value.roundToDouble()) {
      return value.toInt().toString();
    }

    return value.toStringAsFixed(2);
  }
}

class _HeaderValue extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _HeaderValue({
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}