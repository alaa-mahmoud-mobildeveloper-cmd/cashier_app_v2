import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/worker.dart';

class WorkerDetailsSummaryCards extends StatelessWidget {
  final Worker worker; // تأكد من وجود هذا السطر
  final bool isCompact;
  final double advancesTotal;
  final double productsTotal;

  const WorkerDetailsSummaryCards({
    super.key,
    required this.worker, // وتأكد من وجوده هنا
    required this.isCompact,
    required this.advancesTotal,
    required this.productsTotal,
  });

  @override
  Widget build(BuildContext context) {
    final cards = [
      _summaryCard('الراتب الشهري', '${worker.salary} ج', AppColors.gold),
      _summaryCard(
        'إجمالي السلف',
        '${advancesTotal.toStringAsFixed(2)} ج',
        AppColors.danger,
      ),
      _summaryCard(
        'إجمالي الأخذ',
        '${productsTotal.toStringAsFixed(2)} ج',
        AppColors.gold,
      ),
      _summaryCard(
        'المستحق له',
        '${(worker.salary - advancesTotal - productsTotal).toStringAsFixed(2)} ج',
        AppColors.success,
      ),
    ];

    if (isCompact) {
      return GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 2.2,
        children: cards,
      );
    }

    return Row(
      children: cards
          .map(
            (card) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: card,
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _summaryCard(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
