import 'package:cashier_app_v2/core/constants/app_colors.dart';
import 'package:cashier_app_v2/core/utils/number_input.dart';
import 'package:cashier_app_v2/features/purchases/domian/entities/purchase_item_draft.dart';
import 'package:flutter/material.dart';

import 'purchase_item_details.dart';

/// كارت عنصر شراء واحد لنسخة الموبايل.
class PurchaseItemCard extends StatelessWidget {
  const PurchaseItemCard({
    super.key,
    required this.item,
    required this.onQuantityChanged,
    required this.onPriceChanged,
    required this.onSalePriceChanged,
    required this.onRemove,
  });

  final PurchaseItemDraft item;
  final void Function(double quantity) onQuantityChanged;
  final void Function(double price) onPriceChanged;
  final void Function(double price) onSalePriceChanged;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  item.productName,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              if (item.barcode.isEmpty || item.priceChanged)
                const Padding(
                  padding: EdgeInsets.only(left: 6),
                  child: Icon(
                    Icons.warning_amber_rounded,
                    color: AppColors.warning,
                    size: 18,
                  ),
                ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: AppColors.danger),
                onPressed: onRemove,
              ),
            ],
          ),
          PurchaseItemDetails(item: item),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  key: ValueKey('qty-${item.productId}'),
                  initialValue: formatCartons(item.cartonQuantity),
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(labelText: 'عدد الكراتين'),
                  onChanged: (value) =>
                      onQuantityChanged(parseDecimal(value) ?? 0),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  key: ValueKey('price-${item.productId}'),
                  initialValue: item.cartonPurchasePrice.toStringAsFixed(2),
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(labelText: 'سعر الكرتونة'),
                  onChanged: (value) =>
                      onPriceChanged(parseDecimal(value) ?? 0),
                ),
              ),
            ],
          ),

          // يظهر لما سعر الكرتونة يتغيّر عن آخر سعر مسجّل
          if (item.priceChanged) ...[
            const SizedBox(height: 10),
            TextFormField(
              key: ValueKey('sale-${item.productId}'),
              initialValue: item.salePrice.toStringAsFixed(2),
              keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'سعر بيع الوحدة (السعر اتغيّر)',
                helperText:
                'كان ${item.originalSalePrice.toStringAsFixed(2)} · '
                    'المقترح بنفس الربح ${item.suggestedSalePrice.toStringAsFixed(2)}',
              ),
              onChanged: (value) =>
                  onSalePriceChanged(parseDecimal(value) ?? 0),
            ),
          ],

          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'الإجمالي: ${item.total.toStringAsFixed(2)}',
              style: const TextStyle(
                color: AppColors.gold,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}