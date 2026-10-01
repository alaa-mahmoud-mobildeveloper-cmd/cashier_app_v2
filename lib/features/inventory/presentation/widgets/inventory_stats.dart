import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class InventoryStats extends StatelessWidget {
  final int productsCount;
  final double stockValue;
  final double expectedProfit;
  final int outOfStockCount;
  final int lowStockCount;

  const InventoryStats({
    super.key,
    required this.productsCount,
    required this.stockValue,
    required this.expectedProfit,
    required this.outOfStockCount,
    required this.lowStockCount,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final crossAxisCount = width >= 1200
            ? 5
            : width >= 800
            ? 3
            : 2;

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: width >= 800 ? 1.8 : 1.5,
          children: [
            _StatCard(
              title: 'عدد المنتجات',
              value: '$productsCount',
              icon: Icons.inventory_2_outlined,
              iconColor: AppColors.gold,
            ),
            _StatCard(
              title: 'قيمة المخزون',
              value: '${stockValue.toStringAsFixed(2)} ج',
              icon: Icons.account_balance_wallet_outlined,
              iconColor: AppColors.gold,
            ),
            _StatCard(
              title: 'هامش الربح المتوقع',
              value: '${expectedProfit.toStringAsFixed(2)} ج',
              icon: Icons.trending_up_rounded,
              iconColor: AppColors.success,
            ),
            _StatCard(
              title: 'نفذت',
              value: '$outOfStockCount',
              icon: Icons.remove_shopping_cart_outlined,
              iconColor: AppColors.danger,
            ),
            _StatCard(
              title: 'قربت تخلص',
              value: '$lowStockCount',
              icon: Icons.warning_amber_rounded,
              iconColor: AppColors.warning,
            ),
          ],
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 21,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}