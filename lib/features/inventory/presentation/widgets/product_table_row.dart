import 'package:cashier_app_v2/features/inventory/domain/entities/product_items_entit.dart';
import 'package:cashier_app_v2/features/inventory/presentation/uitl/category_icon.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import 'status_badge.dart';

class ProductCard extends StatelessWidget {
  final ProductItem item;
  final VoidCallback? onEdit;
  final VoidCallback? onPrint;
  final VoidCallback? onTrend;

  const ProductCard({
    super.key,
    required this.item,
    this.onEdit,
    this.onPrint,
    this.onTrend,
  });

  static const int _lowStockThreshold = 5;

  bool get _isLowStock => item.quantity <= _lowStockThreshold;

  Color get _profitColor {
    if (item.profit < 0) return AppColors.danger;
    if (item.profit == 0) return AppColors.textSecondary;
    return AppColors.success;
  }

  IconData get _profitIcon {
    if (item.profit < 0) return Icons.trending_down_rounded;
    if (item.profit == 0) return Icons.trending_flat_rounded;
    return Icons.trending_up_rounded;
  }

  Widget _actionButton({
    required VoidCallback? onPressed,
    required IconData icon,
    required String tooltip,
    bool filled = false,
  }) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: filled ? AppColors.gold : AppColors.background,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 38,
            height: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: filled
                  ? null
                  : Border.all(color: AppColors.border),
            ),
            child: Icon(
              icon,
              size: 18,
              color: filled
                  ? AppColors.background
                  : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoItem({
    required String label,
    required String value,
    Color? valueColor,
    IconData? icon,
    bool large = false,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 13,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 5),
              ],
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            value,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              color: valueColor ?? AppColors.textPrimary,
              fontSize: large ? 16 : 13.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _verticalDivider() {
    return Container(
      width: 1,
      height: 38,
      color: AppColors.border,
    );
  }

  Widget _sectionTitle({
    required String title,
    required IconData icon,
  }) {
    return Row(
      children: [
        Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            color: AppColors.gold.withOpacity(0.10),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Icon(
            icon,
            size: 14,
            color: AppColors.gold,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _stockBadge() {
    if (!_isLowStock) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.danger.withOpacity(0.12),
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
          color: AppColors.danger.withOpacity(0.20),
        ),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            size: 12,
            color: AppColors.danger,
          ),
          SizedBox(width: 4),
          Text(
            'مخزون منخفض',
            style: TextStyle(
              color: AppColors.danger,
              fontSize: 9.5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profit = item.profit;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.28),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onEdit,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // =========================================================
              // TOP ACCENT
              // =========================================================
              Container(
                height: 4,
                color: AppColors.gold,
              ),

              // =========================================================
              // HEADER
              // =========================================================
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  14,
                  14,
                  14,
                  13,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.gold.withOpacity(0.24),
                            AppColors.gold.withOpacity(0.06),
                          ],
                        ),
                        border: Border.all(
                          color: AppColors.gold.withOpacity(0.30),
                        ),
                      ),
                      child: Icon(
                        categoryIcon(item.category),
                        color: AppColors.gold,
                        size: 23,
                      ),
                    ),

                    const SizedBox(width: 12),

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
                              fontSize: 15.5,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Icon(
                                Icons.category_outlined,
                                size: 12,
                                color: AppColors.textSecondary,
                              ),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  item.category,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 11.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 8),

                    StatusBadge(
                      status: item.status,
                    ),
                  ],
                ),
              ),

              // =========================================================
              // PRICE + BARCODE
              // =========================================================
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [
                      AppColors.gold.withOpacity(0.16),
                      AppColors.gold.withOpacity(0.025),
                    ],
                  ),
                  border: Border(
                    top: BorderSide(
                      color: AppColors.border,
                    ),
                    bottom: BorderSide(
                      color: AppColors.border,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    // السعر
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'سعر البيع',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 10.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              item.sellPrice.toStringAsFixed(0),
                              style: const TextStyle(
                                color: AppColors.gold,
                                fontSize: 23,
                                height: 1,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 1),
                              child: Text(
                                'ج',
                                style: TextStyle(
                                  color: AppColors.gold,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const Spacer(),

                    // الباركود
                    Container(
                      constraints: const BoxConstraints(
                        maxWidth: 135,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.background.withOpacity(0.45),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.border,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.qr_code_2_rounded,
                            size: 15,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 5),
                          Flexible(
                            child: Text(
                              item.barcode,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 10.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // =========================================================
              // PRICES / PROFIT
              // =========================================================
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  14,
                  13,
                  14,
                  0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle(
                      title: 'التكلفة والربح',
                      icon: Icons.analytics_outlined,
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        _infoItem(
                          label: 'سعر الشراء / وحدة',
                          value:
                          '${item.unitCost.toStringAsFixed(2)} ج',
                          icon: Icons.shopping_cart_outlined,
                        ),

                        const SizedBox(width: 12),
                        _verticalDivider(),
                        const SizedBox(width: 12),

                        _infoItem(
                          label: 'ربح الوحدة',
                          value:
                          '${profit.toStringAsFixed(2)} ج',
                          valueColor: _profitColor,
                          icon: _profitIcon,
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: _profitColor.withOpacity(0.07),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _profitColor.withOpacity(0.12),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _profitIcon,
                            size: 14,
                            color: _profitColor,
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            'هامش الربح',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 10.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${item.profitMarginPercent.toStringAsFixed(1)}%',
                            style: TextStyle(
                              color: _profitColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // =========================================================
              // CARTON / STOCK
              // =========================================================
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  14,
                  14,
                  14,
                  0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle(
                      title: 'الكرتونة والمخزون',
                      icon: Icons.inventory_2_outlined,
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        _infoItem(
                          label: 'الكرتونة',
                          value:
                          '${item.unitsPerCarton} وحدة',
                          icon: Icons.inventory_2_outlined,
                        ),

                        const SizedBox(width: 12),
                        _verticalDivider(),
                        const SizedBox(width: 12),

                        _infoItem(
                          label: 'سعر الكرتونة',
                          value:
                          '${item.cartonPrice.toStringAsFixed(0)} ج',
                          icon: Icons.payments_outlined,
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: _isLowStock
                              ? AppColors.danger.withOpacity(0.30)
                              : AppColors.border,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              color: _isLowStock
                                  ? AppColors.danger.withOpacity(0.10)
                                  : AppColors.gold.withOpacity(0.10),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.layers_outlined,
                              size: 17,
                              color: _isLowStock
                                  ? AppColors.danger
                                  : AppColors.gold,
                            ),
                          ),

                          const SizedBox(width: 9),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'المخزون المتاح',
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${item.quantity} وحدة',
                                  style: TextStyle(
                                    color: _isLowStock
                                        ? AppColors.danger
                                        : AppColors.textPrimary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          if (item.cartonQuantity > 0) ...[
                            Container(
                              width: 1,
                              height: 30,
                              color: AppColors.border,
                            ),
                            const SizedBox(width: 10),
                            // Column(
                            //   crossAxisAlignment:
                            //   CrossAxisAlignment.end,
                            //   children: [15
                            //     const Text(
                            //       'الكرتونة',
                            //       style: TextStyle(
                            //         color: AppColors.textSecondary,
                            //         fontSize: 10,
                            //       ),
                            //     ),
                            //     const SizedBox(height: 2),
                            //     Text(
                            //       '${item.cartonQuantity}',
                            //       style: const TextStyle(
                            //         color: AppColors.textPrimary,
                            //         fontSize: 13,
                            //         fontWeight: FontWeight.w800,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],

                          const SizedBox(width: 8),

                          _stockBadge(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // =========================================================
              // ACTIONS
              // =========================================================
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: AppColors.border,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    _actionButton(
                      onPressed: onEdit,
                      icon: Icons.edit_outlined,
                      tooltip: 'تعديل المنتج',
                      filled: true,
                    ),

                    const SizedBox(width: 8),

                    _actionButton(
                      onPressed: onPrint,
                      icon: Icons.print_outlined,
                      tooltip: 'طباعة',
                    ),

                    const SizedBox(width: 8),

                    _actionButton(
                      onPressed: onTrend,
                      icon: Icons.show_chart_rounded,
                      tooltip: 'حركة المنتج',
                    ),

                    const Spacer(),

                    if (_isLowStock)
                      const Row(
                        children: [
                          Icon(
                            Icons.warning_amber_rounded,
                            size: 14,
                            color: AppColors.danger,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'يحتاج إعادة تخزين',
                            style: TextStyle(
                              color: AppColors.danger,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}