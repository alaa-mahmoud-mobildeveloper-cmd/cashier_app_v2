import 'package:cashier_app_v2/features/inventory/domain/entities/product_items_entit.dart';
import 'package:cashier_app_v2/features/inventory/presentation/uitl/category_icon.dart';
import 'package:flutter/material.dart';

import 'product_table_columns.dart';
import 'status_badge.dart';
import 'package:cashier_app_v2/core/constants/app_colors.dart';

class ProductTableRow extends StatelessWidget {
  final ProductItem item;
  final VoidCallback? onEdit;
  final VoidCallback? onPrint;
  final VoidCallback? onTrend;

  const ProductTableRow({
    super.key,
    required this.item,
    this.onEdit,
    this.onPrint,
    this.onTrend,
  });

  // نفس مصدر الأعمدة اللي بيستخدمه الـ Header، عشان يفضلوا متطابقين دايمًا.
  static final _flexes = ProductTableColumns.flexes;

  Widget _cell(Widget child, int flex) {
    return Expanded(
      flex: flex,
      child: Center(child: child),
    );
  }

  Widget _actionButton({
    required VoidCallback? onPressed,
    required IconData icon,
    Color? foregroundColor,
    Color? backgroundColor,
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, size: 16),
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 30, minHeight: 30),
      style: IconButton.styleFrom(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profit = item.profit;
    final marginColor = profit < 0
        ? AppColors.danger
        : (profit == 0 ? AppColors.textSecondary : AppColors.success);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          // الصورة
          _cell(
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.goldSurface,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(categoryIcon(item.category), color: AppColors.gold, size: 18),
            ),
            _flexes[0],
          ),
          // اسم الصنف
          _cell(
            Text(
              item.name,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            _flexes[1],
          ),
          // الباركود
          _cell(
            Text(
              item.barcode,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
            ),
            _flexes[2],
          ),
          // الفئة
          _cell(
            Text(
              item.category,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
            ),
            _flexes[3],
          ),
          // سعر البيع
          _cell(
            Text(
              '${item.sellPrice.toStringAsFixed(0)} ج',
              style: const TextStyle(
                color: AppColors.gold,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            _flexes[4],
          ),
          // سعر شراء الوحدة (محسوب تلقائيًا من الكرتونة)
          _cell(
            Text(
              item.unitCost.toStringAsFixed(2),
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
            ),
            _flexes[5],
          ),
          // هامش الربح
          _cell(
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${item.profitMarginPercent.toStringAsFixed(1)}%',
                  style: TextStyle(
                    color: marginColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${profit.toStringAsFixed(2)} ج',
                  style: TextStyle(color: marginColor, fontSize: 11),
                ),
              ],
            ),
            _flexes[6],
          ),
          // كرتونة
          _cell(
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${item.unitsPerCarton} وحدة',
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 11),
                ),
                const SizedBox(height: 2),
                Text(
                  '${item.cartonPrice.toStringAsFixed(0)} ج',
                  style: const TextStyle(color: AppColors.textPrimary, fontSize: 13),
                ),
              ],
            ),
            _flexes[7],
          ),
          // الكمية
          _cell(
            Text(
              '${item.quantity}',
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            _flexes[8],
          ),
          // الحالة
          _cell(StatusBadge(status: item.status), _flexes[9]),
          // إجراءات
          _cell(
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 10,
              children: [
                _actionButton(onPressed: onPrint, icon: Icons.print_outlined),
                _actionButton(onPressed: onEdit, icon: Icons.edit_outlined),
                _actionButton(
                  onPressed: onTrend,
                  icon: Icons.show_chart,
                  foregroundColor: AppColors.gold,
                  backgroundColor: AppColors.goldSurface,
                ),
              ],
            ),
            _flexes[10],
          ),
        ],
      ),
    );
  }
}