import 'package:cashier_app_v2/features/inventory/domain/entities/product_items_entit.dart';
import 'package:cashier_app_v2/features/inventory/presentation/uitl/category_icon.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import 'status_badge.dart';

class ProductCard extends StatelessWidget {
  final ProductItem item;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ProductCard({
    super.key,
    required this.item,
    this.onEdit,
    this.onDelete,
  });

  bool get _isOutOfStock => item.quantity <= 0;

  bool get _isLowStock =>
      item.quantity > 0 && item.quantity <= 10;

  Color get _stockColor {
    if (_isOutOfStock) return AppColors.danger;
    if (_isLowStock) return AppColors.warning;
    return AppColors.success;
  }

  Color get _profitColor {
    if (item.profit < 0) return AppColors.danger;
    if (item.profit == 0) return AppColors.textSecondary;
    return AppColors.success;
  }

  String _formatNumber(double value) {
    return value % 1 == 0
        ? value.toStringAsFixed(0)
        : value.toStringAsFixed(2);
  }

  Widget _actionButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback? onPressed,
    Color? color,
  }) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.border,
              ),
            ),
            child: Icon(
              icon,
              size: 17,
              color: color ?? AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _metric({
    required String label,
    required String value,
    Color? valueColor,
    IconData? icon,
  }) {
    return Expanded(
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 15,
              color: AppColors.textSecondary,
            ),
            const SizedBox(width: 6),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: valueColor ?? AppColors.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      width: 1,
      height: 30,
      color: AppColors.border,
    );
  }

  Widget _stockStatus() {
    final label = _isOutOfStock
        ? 'نفد'
        : _isLowStock
        ? 'منخفض'
        : 'متوفر';

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: _stockColor.withOpacity(0.10),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: _stockColor,
          fontSize: 9.5,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onEdit,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: AppColors.border,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: AppColors.gold.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      categoryIcon(item.category),
                      color: AppColors.gold,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                item.category,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 10.5,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              width: 3,
                              height: 3,
                              decoration: const BoxDecoration(
                                color: AppColors.textSecondary,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                item.barcode,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 8),
                  StatusBadge(status: item.status),
                ],
              ),

              const SizedBox(height: 12),

              // Main values
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'سعر البيع',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.end,
                            children: [
                              Text(
                                item.sellPrice.toStringAsFixed(2),
                                style: const TextStyle(
                                  color: AppColors.gold,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const SizedBox(width: 3),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 2),
                                child: Text(
                                  'ج',
                                  style: TextStyle(
                                    color: AppColors.gold,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    _divider(),
                    const SizedBox(width: 10),

                    _metric(
                      label: 'المخزون',
                      value: '${item.quantity} وحدة',
                      valueColor: _stockColor,
                      icon: Icons.inventory_2_outlined,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Cost / Profit
              Row(
                children: [
                  _metric(
                    label: 'تكلفة الوحدة',
                    value: '${item.unitCost.toStringAsFixed(2)} ج',
                    icon: Icons.shopping_cart_outlined,
                  ),
                  const SizedBox(width: 10),
                  _divider(),
                  const SizedBox(width: 10),
                  _metric(
                    label: 'ربح الوحدة',
                    value: '${item.profit.toStringAsFixed(2)} ج',
                    valueColor: _profitColor,
                    icon: item.profit >= 0
                        ? Icons.trending_up_rounded
                        : Icons.trending_down_rounded,
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _profitColor.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '${item.profitMarginPercent.toStringAsFixed(0)}%',
                      style: TextStyle(
                        color: _profitColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Carton info
              Row(
                children: [
                  const Icon(
                    Icons.inventory_2_outlined,
                    size: 14,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '${item.unitsPerCarton} وحدة / كرتونة',
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 10.5,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 3,
                    height: 3,
                    decoration: const BoxDecoration(
                      color: AppColors.borderLight,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'الكرتونة ${item.cartonPrice.toStringAsFixed(2)} ج',
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 10.5,
                    ),
                  ),
                  if (item.cartonQuantity > 0) ...[
                    const Spacer(),
                    Text(
                      '${_formatNumber(item.cartonQuantity)} كرتونة',
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ],
              ),

              const SizedBox(height: 10),

              // Footer
              Row(
                children: [
                  _actionButton(
                    icon: Icons.edit_outlined,
                    tooltip: 'تعديل المنتج',
                    onPressed: onEdit,
                    color: AppColors.gold,
                  ),
                  const SizedBox(width: 6),
                  _actionButton(
                    icon: Icons.delete_outline_rounded,
                    tooltip: 'حذف المنتج',
                    onPressed: onDelete,
                    color: AppColors.danger,
                  ),

                  const Spacer(),

                  _stockStatus(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}