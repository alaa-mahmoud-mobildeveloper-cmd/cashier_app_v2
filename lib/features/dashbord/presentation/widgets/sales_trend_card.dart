import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class SalesTrendCard extends StatelessWidget {
  final List<double> values;
  final List<String> labels;

  const SalesTrendCard({super.key, required this.values, required this.labels});

  @override
  Widget build(BuildContext context) {
    final maxY = (values.reduce((a, b) => a > b ? a : b) * 1.2).ceilToDouble();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'المبيعات آخر 7 أيام',
              style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 220,
              child: LineChart(
                LineChartData(
                  minY: 0,
                  maxY: maxY,
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: maxY / 4,
                    getDrawingHorizontalLine: (_) => FlLine(color: AppColors.textSecondary.withOpacity(0.15), strokeWidth: 1),
                  ),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: maxY / 4,
                        getTitlesWidget: (value, meta) => Text(
                          value.toInt().toString(),
                          style: const TextStyle(color: AppColors.textSecondary, fontSize: 11),
                        ),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        getTitlesWidget: (value, meta) {
                          final i = value.toInt();
                          if (i < 0 || i >= labels.length) return const SizedBox.shrink();
                          return Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(labels[i], style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
                          );
                        },
                      ),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      color: AppColors.gold,
                      barWidth: 3,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, bar, index) =>
                            FlDotCirclePainter(radius: 4, color: AppColors.gold, strokeWidth: 0),
                      ),
                      belowBarData: BarAreaData(show: true, color: AppColors.gold.withOpacity(0.08)),
                      spots: [for (int i = 0; i < values.length; i++) FlSpot(i.toDouble(), values[i])],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}