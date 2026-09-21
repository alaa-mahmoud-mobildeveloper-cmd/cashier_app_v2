import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String? deltaLabel;
  final bool isPositive;
  final IconData icon;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    this.deltaLabel,
    this.isPositive = true,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final trendColor = isPositive ? AppColors.success : AppColors.danger;

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(trendColor),
            const SizedBox(height: 8),
            _buildTitle(),
            const SizedBox(height: 2),
            _buildValue(),
          ],
        ),
      ),
    );
  }

  /// رأس البطاقة (الأيقونة ومؤشر التغيير Delta)
  Widget _buildHeader(Color trendColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.gold.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: AppColors.gold,
            size: 16,
          ),
        ),
        if (deltaLabel != null) _buildDeltaBadge(trendColor),
      ],
    );
  }

  /// شارة نسبة التغيير (Delta Badge)
  Widget _buildDeltaBadge(Color trendColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: trendColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isPositive ? Icons.arrow_drop_up : Icons.arrow_drop_down,
            color: trendColor,
            size: 14,
          ),
          Text(
            deltaLabel!,
            style: TextStyle(
              color: trendColor,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  /// عنوان البطاقة
  Widget _buildTitle() {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.textSecondary,
        fontSize: 12,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  /// قيمة البطاقة الرئيسية
  Widget _buildValue() {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        value,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
      ),
    );
  }
}