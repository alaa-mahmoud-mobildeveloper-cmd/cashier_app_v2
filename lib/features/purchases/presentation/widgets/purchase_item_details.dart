import 'package:cashier_app_v2/core/constants/app_colors.dart';
import 'package:cashier_app_v2/features/purchases/domian/entities/purchase_item_draft.dart';
import 'package:flutter/material.dart';

/// بيانات الصنف التفصيلية (باركود، فئة، أسعار، مخزون) لصف الفاتورة.
class PurchaseItemDetails extends StatelessWidget {
  const PurchaseItemDetails({
    super.key,
    required this.item,
    this.showName = false,
  });

  final PurchaseItemDraft item;

  /// الجدول بيعرض الاسم هنا، والكارت بيعرضه في صف العنوان.
  final bool showName;

  @override
  Widget build(BuildContext context) {
    const small = TextStyle(color: AppColors.textSecondary, fontSize: 11);
    final lossy = item.unitProfit < 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showName) ...[
          Text(item.productName),
          const SizedBox(height: 2),
        ],
        Text(
          '${item.barcode} · ${item.category} · ${item.unit}',
          style: small,
        ),
        Text(
          'الكرتونة ${item.unitsPerCarton} وحدة · '
              'شراء الوحدة ${item.unitPurchasePrice.toStringAsFixed(2)} · '
              'بيع ${item.salePrice.toStringAsFixed(2)}',
          style: small,
        ),
        Text(
          'المخزون ${item.currentStock} ← ${item.stockAfter} '
              '(+${item.totalUnits} وحدة)',
          style: small,
        ),
        if (item.priceChanged)
          Text(
            'السعر اتغيّر عن آخر مرة (${item.lastCartonPrice.toStringAsFixed(2)})',
            style: small.copyWith(color: AppColors.warning),
          ),
        if (lossy)
          Text(
            'تنبيه: سعر البيع أقل من سعر الشراء',
            style: small.copyWith(color: AppColors.danger),
          ),
      ],
    );
  }
}