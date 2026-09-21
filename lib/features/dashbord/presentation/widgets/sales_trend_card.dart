import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class SalesTrendCard extends StatelessWidget {
  final List<double> values;
  final List<String> labels;

  const SalesTrendCard({
    super.key,
    required this.values,
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    if (values.isEmpty) {
      return const _EmptySalesCard();
    }

    final maxY = _calculateMaxY();
    final interval = maxY / 4;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCardTitle(),
            const SizedBox(height: 20),
            SizedBox(
              height: 220,
              child: LineChart(_buildLineChartData(maxY, interval)),
            ),
          ],
        ),
      ),
    );
  }

  /// حساب أعلى قيمة للمحور الرأسي لمنحنى المبيعات
  double _calculateMaxY() {
    final highestValue = values.reduce((a, b) => a > b ? a : b);
    return highestValue <= 0 ? 100 : (highestValue * 1.2).ceilToDouble();
  }

  /// عنوان الكارد الثابت
  Widget _buildCardTitle() {
    return const Text(
      'المبيعات آخر 7 أيام',
      style: TextStyle(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
    );
  }

  /// إعدادات بيانات الرسم البياني
  LineChartData _buildLineChartData(double maxY, double interval) {
    return LineChartData(
      minY: 0,
      maxY: maxY,
      gridData: _buildGridData(interval),
      borderData: FlBorderData(show: false),
      titlesData: _buildTitlesData(interval),
      lineBarsData: [_buildLineBarData()],
    );
  }

  /// إعدادات شبكة الخطوط الخلفية
  FlGridData _buildGridData(double interval) {
    return FlGridData(
      show: true,
      drawVerticalLine: false,
      horizontalInterval: interval,
      getDrawingHorizontalLine: (_) {
        return FlLine(
          color: AppColors.textSecondary.withValues(alpha: 0.15),
          strokeWidth: 1,
        );
      },
    );
  }

  /// إعدادات عناوين المحاور (الأفقية والراسية)
  FlTitlesData _buildTitlesData(double interval) {
    return FlTitlesData(
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 45,
          interval: interval,
          getTitlesWidget: (value, meta) {
            return Text(
              value.toInt().toString(),
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 11,
              ),
            );
          },
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 28,
          getTitlesWidget: (value, meta) {
            final index = value.toInt();
            if (index < 0 || index >= labels.length) {
              return const SizedBox.shrink();
            }
            return Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                labels[index],
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 11,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// إعدادات خط الرسم البياني والنقاط
  LineChartBarData _buildLineBarData() {
    return LineChartBarData(
      isCurved: true,
      color: AppColors.gold,
      barWidth: 3,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, bar, index) {
          return FlDotCirclePainter(
            radius: 4,
            color: AppColors.gold,
            strokeWidth: 0,
          );
        },
      ),
      belowBarData: BarAreaData(
        show: true,
        color: AppColors.gold.withValues(alpha: 0.08),
      ),
      spots: [
        for (int i = 0; i < values.length; i++)
          FlSpot(i.toDouble(), values[i]),
      ],
    );
  }
}

/// كلاس فرعي لحالة عدم وجود بيانات لتنظيم الكود أكثر
class _EmptySalesCard extends StatelessWidget {
  const _EmptySalesCard();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: SizedBox(
          height: 260,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'المبيعات آخر 7 أيام',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'لا توجد بيانات مبيعات',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}