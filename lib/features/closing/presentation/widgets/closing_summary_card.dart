import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class ClosingSummaryCard extends StatelessWidget {
  final double sales;
  final double creditPayments;
  final double purchases;
  final double expenses;
  final double recharge;
  final double net;

  /// إجمالي المبلغ الفعلي
  final double actualBalance;

  /// إجمالي المبلغ المفروض
  final double expectedBalance;

  const ClosingSummaryCard({
    super.key,
    required this.sales,
    required this.creditPayments,
    required this.purchases,
    required this.expenses,
    required this.recharge,
    required this.net,
    required this.actualBalance,
    required this.expectedBalance,
  });

  double get difference {
    return actualBalance - expectedBalance;
  }

  bool get hasSurplus {
    return difference > 0.01;
  }

  bool get hasShortage {
    return difference < -0.01;
  }

  bool get isBalanced {
    return difference.abs() <= 0.01;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView( // أضفنا التمرير الرأسي لمنع أي Overflow نهائياً
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'ملخص اليوم (من دفتر اليومية)',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: 20),

              _SummaryRow(
                title: 'المبيعات',
                value: sales,
              ),

              _SummaryRow(
                title: 'سداد آجل',
                value: creditPayments,
              ),

              _SummaryRow(
                title: 'المشتريات',
                value: purchases,
              ),

              _SummaryRow(
                title: 'المصروفات',
                value: expenses,
              ),

              _SummaryRow(
                title: 'الشحن',
                value: recharge,
              ),

              const SizedBox(height: 16), // استبدال الـ Spacer بمسافة ثابتة آمنة

              _buildBalanceStatus(context),

              const SizedBox(height: 18),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'صافي اليوم',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.goldLight,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${_formatMoney(net)} ج',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.success,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceStatus(BuildContext context) {
    final Color color;
    final Color backgroundColor;
    final IconData icon;
    final String title;
    final String value;

    if (isBalanced) {
      color = AppColors.success;
      backgroundColor = AppColors.successSurface;
      icon = Icons.check_circle_outline;
      title = 'الرصيد مطابق';
      value = '0 ج';
    } else if (hasSurplus) {
      color = AppColors.success;
      backgroundColor = AppColors.successSurface;
      icon = Icons.trending_up;
      title = 'زيادة';
      value = '+${_formatMoney(difference)} ج';
    } else {
      color = AppColors.danger;
      backgroundColor = AppColors.dangerSurface;
      icon = Icons.trending_down;
      title = 'عجز';
      value = '-${_formatMoney(difference.abs())} ج';
    }

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _BalanceAmount(
                title: 'الرصيد المتوقع',
                value: '${_formatMoney(expectedBalance)} ج',
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _BalanceAmount(
                title: 'الرصيد الفعلي',
                value: '${_formatMoney(actualBalance)} ج',
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),

        const SizedBox(height: 14),

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: color.withValues(alpha: 0.25),
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatMoney(double value) {
    if (value == value.roundToDouble()) {
      return value.toInt().toString();
    }

    return value.toStringAsFixed(2);
  }
}

class _BalanceAmount extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _BalanceAmount({
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.divider,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String title;
  final double value;

  const _SummaryRow({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.divider,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _formatMoney(value),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  String _formatMoney(double value) {
    if (value == value.roundToDouble()) {
      return value.toInt().toString();
    }

    return value.toStringAsFixed(2);
  }
}