import 'package:cashier_app_v2/features/closing/data/model/payment_balance_model.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

import 'payment_balance_card.dart';

class PaymentBalancesSection extends StatelessWidget {
  final List<PaymentBalanceModel> balances;
  final VoidCallback onChanged;

  const PaymentBalancesSection({
    super.key,
    required this.balances,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'أرصدة وسائل الدفع',
          textAlign: TextAlign.right,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),

        const SizedBox(height: 14),

        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            final crossAxisCount = width >= 1100
                ? 4
                : width >= 700
                ? 2
                : 1;

            final spacing = 16.0;

            final itemWidth =
                (width - ((crossAxisCount - 1) * spacing)) /
                    crossAxisCount;

            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: balances.map(
                    (balance) {
                  return SizedBox(
                    width: itemWidth,
                    child: PaymentBalanceCard(
                      balance: balance,
                      onChanged: onChanged,
                    ),
                  );
                },
              ).toList(),
            );
          },
        ),
      ],
    );
  }
}