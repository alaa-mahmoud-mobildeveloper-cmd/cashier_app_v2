import 'package:cashier_app_v2/features/closing/data/model/payment_balance_model.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class PaymentBalanceCard extends StatelessWidget {
  final PaymentBalanceModel balance;
  final VoidCallback onChanged;

  const PaymentBalanceCard({
    super.key,
    required this.balance, required this.onChanged,
  });

  double get difference => balance.actualBalance - balance.expectedBalance;

  bool get hasSurplus => difference > 0.01;
  bool get hasShortage => difference < -0.01;
  bool get isBalanced => difference.abs() <= 0.01;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(context),

            const SizedBox(height: 16),

            _MoneyInputField(
              label: 'رصيد أول',
              value: balance.openingBalance,
              onChanged: (value) {
                balance.openingBalance = value;
                onChanged();
              },
            ),

            const SizedBox(height: 14),

            _buildSystemMovement(context),

            const SizedBox(height: 14),

            _buildValueRow(
              context,
              title: 'المفروض',
              value: balance.expectedBalance,
              color: balance.color,
            ),

            const SizedBox(height: 14),

            _MoneyInputField(
              label: 'الفعلي',
              value: balance.actualBalance,
              onChanged: (value) {
                balance.actualBalance = value;
                onChanged();
              },
            ),

            const SizedBox(height: 14),

            const Divider(),

            const SizedBox(height: 6),

            _buildDifferenceStatus(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: balance.color.withValues(alpha: .10),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            balance.icon,
            color: balance.color,
            size: 22,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            balance.title,
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: balance.color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSystemMovement(BuildContext context) {
    return _buildValueRow(
      context,
      title: 'حركة السيستم',
      value: balance.systemMovement,
      color: AppColors.success,
    );
  }

  Widget _buildValueRow(
      BuildContext context, {
        required String title,
        required double value,
        required Color color,
      }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          '${_formatMoney(value)} ج',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildDifferenceStatus(BuildContext context) {
    final Color statusColor;
    final String statusText;
    final String valueText;

    if (isBalanced) {
      statusColor = AppColors.success;
      statusText = 'الرصيد مطابق';
      valueText = '0 ج';
    } else if (hasSurplus) {
      statusColor = AppColors.success;
      statusText = 'زيادة';
      valueText = '+${_formatMoney(difference)} ج';
    } else {
      statusColor = AppColors.danger;
      statusText = 'عجز';
      valueText = '-${_formatMoney(difference.abs())} ج';
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              hasSurplus
                  ? Icons.trending_up
                  : (hasShortage ? Icons.trending_down : Icons.check_circle_outline),
              color: statusColor,
              size: 18,
            ),
            const SizedBox(width: 6),
            Text(
              statusText,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: statusColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Text(
          valueText,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: statusColor,
            fontWeight: FontWeight.bold,
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

/// ويدجت مستقلة لإدارة حقل الإدخال بـ Controller خاص بها لتجنب فقدان التركيز
class _MoneyInputField extends StatefulWidget {
  final String label;
  final double value;
  final ValueChanged<double> onChanged;

  const _MoneyInputField({
    required this.label, required this.value, required this.onChanged,
  });

  @override
  State<_MoneyInputField> createState() => _MoneyInputFieldState();
}

class _MoneyInputFieldState extends State<_MoneyInputField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _formatMoney(widget.value));
  }

  @override
  void didUpdateWidget(covariant _MoneyInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // تحديث النص فقط إذا تغيرت القيمة من الخارج ولم يكن الحقل مكتوباً حالياً
    if (widget.value != double.tryParse(_controller.text)) {
      _controller.text = _formatMoney(widget.value);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatMoney(double value) {
    if (value == value.roundToDouble()) {
      return value.toInt().toString();
    }
    return value.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _controller,
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
            ),
            textAlign: TextAlign.center,
            onChanged: (text) {
              widget.onChanged(double.tryParse(text) ?? 0);
            },
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 62,
          child: Text(
            widget.label,
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}