import 'package:flutter/material.dart';
import 'package:cashier_app_v2/features/dashbord/data/models/low_stock_item.dart';
import '../../../../core/constants/app_colors.dart';

class LowStockTable extends StatelessWidget {
  final List<LowStockItem> items;

  const LowStockTable({
    super.key,
    required this.items,
  });

  static const double _tableMinWidth = 640.0;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeaderTitle(),
            const SizedBox(height: 16),
            _buildTableBody(),
          ],
        ),
      ),
    );
  }

  /// عنوان الجدول العلوي مع إجمالي عداد الأصناف
  Widget _buildHeaderTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: AppColors.gold,
              size: 18,
            ),
            SizedBox(width: 6),
            Text(
              'الأصناف اللي قربت تخلص',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: AppColors.gold.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '${items.length} صنف',
            style: const TextStyle(
              color: AppColors.gold,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  /// محتوى الجدول مع دعم التمرير الأفقي للشاشات الضيقة
  Widget _buildTableBody() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth < _tableMinWidth
            ? _tableMinWidth
            : constraints.maxWidth;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: width,
            child: Column(
              children: [
                _buildTableHeader(),
                if (items.isEmpty)
                  _buildEmptyState()
                else
                  ...items.map(_buildTableRow),
              ],
            ),
          ),
        );
      },
    );
  }

  /// رأس أعمدة الجدول
  Widget _buildTableHeader() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              'الحالة',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'الكمية المتبقية',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'اسم الصنف',
              textAlign: TextAlign.end,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// حالة عدم وجود أصناف قريبة النفاد
  Widget _buildEmptyState() {
    return const Padding(
      padding: EdgeInsets.all(24),
      child: Center(
        child: Text(
          'لا توجد أصناف قريبة النفاد',
          style: TextStyle(
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  /// بناء صف العنصر الفردي داخل الجدول
  Widget _buildTableRow(LowStockItem item) {
    final isCritical = item.quantity <= 2;
    final color = isCritical ? AppColors.danger : AppColors.gold;
    final label = isCritical ? 'حرج' : 'قرب يخلص';

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.white10,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 12,
      ),
      child: Row(
        children: [
          // عمود الحالة (Badge)
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  border: Border.all(
                    color: color.withValues(alpha: 0.5),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          // عمود الكمية المتبقية
          Expanded(
            flex: 2,
            child: Text(
              item.quantity.toString(),
              style: const TextStyle(
                color: AppColors.textPrimary,
              ),
            ),
          ),
          // عمود اسم الصنف
          Expanded(
            flex: 3,
            child: Text(
              item.name,
              textAlign: TextAlign.end,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}