import 'package:cashier_app_v2/features/dashbord/data/models/sales_category.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class SalesByCategoryCard extends StatelessWidget {
  final List<SalesCategory> categories;

  const SalesByCategoryCard({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCardTitle(),
            const SizedBox(height: 20),
            categories.isEmpty ? _buildEmptyState() : _buildChartContent(),
          ],
        ),
      ),
    );
  }

  /// عنوان الكارد الرئيسي
  Widget _buildCardTitle() {
    return const Text(
      'توزيع المبيعات حسب القسم',
      style: TextStyle(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
    );
  }

  /// محتوى الرسم البياني الدائري ومفاتيح الأقسام
  Widget _buildChartContent() {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PieChart(_buildPieChartData()),
        ),
        const SizedBox(height: 18),
        _buildLegendWrap(),
      ],
    );
  }

  /// إعدادات بيانات الـ Pie Chart
  PieChartData _buildPieChartData() {
    return PieChartData(
      sectionsSpace: 2,
      centerSpaceRadius: 55,
      sections: categories
          .map(
            (category) => PieChartSectionData(
          value: category.totalSales,
          color: category.color,
          radius: 45,
          showTitle: false,
        ),
      )
          .toList(),
    );
  }

  /// مفاتيح الألوان والأسماء (Legend) أسفل الرسم البياني
  Widget _buildLegendWrap() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 16,
      runSpacing: 8,
      children: categories
          .map(
            (category) => _LegendDot(
          name: category.name,
          color: category.color,
        ),
      )
          .toList(),
    );
  }

  /// حالة عدم وجود بيانات للأقسام
  Widget _buildEmptyState() {
    return const SizedBox(
      height: 200,
      child: Center(
        child: Text(
          'لا توجد مبيعات حسب الأقسام',
          style: TextStyle(
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

/// ودجت نقطة اللون واسم القسم الخاص بالمفتاح
class _LegendDot extends StatelessWidget {
  final String name;
  final Color color;

  const _LegendDot({
    required this.name,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          name,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
          ),
        ),
        const SizedBox(width: 6),
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}