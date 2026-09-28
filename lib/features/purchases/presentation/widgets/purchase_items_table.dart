import 'package:flutter/material.dart';

import 'package:cashier_app_v2/core/constants/app_colors.dart';
import 'package:cashier_app_v2/core/utils/number_input.dart';
import 'package:cashier_app_v2/features/purchases/domian/entities/purchase_item_draft.dart';

class PurchaseItemsTable extends StatefulWidget {
  const PurchaseItemsTable({
    super.key,
    required this.items,
    required this.onQuantityChanged,
    required this.onPriceChanged,
    required this.onSalePriceChanged,
    required this.onRemove,
  });

  final List<PurchaseItemDraft> items;
  final void Function(int productId, double quantity) onQuantityChanged;
  final void Function(int productId, double price) onPriceChanged;
  final void Function(int productId, double price) onSalePriceChanged;
  final void Function(int productId) onRemove;

  @override
  State<PurchaseItemsTable> createState() => _PurchaseItemsTableState();
}

class _PurchaseItemsTableState extends State<PurchaseItemsTable> {
  static const double _tableWidth = 1500;

  static const TextStyle _secondaryTextStyle = TextStyle(
    color: AppColors.textSecondary,
    fontSize: 12,
  );

  late final ScrollController _horizontalController;

  @override
  void initState() {
    super.initState();
    _horizontalController = ScrollController();
  }

  @override
  void dispose() {
    _horizontalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return const _EmptyItemsPlaceholder();
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Scrollbar(
          controller: _horizontalController,
          thumbVisibility: true,
          trackVisibility: true,
          notificationPredicate: (notification) => notification.depth == 0,
          child: SingleChildScrollView(
            controller: _horizontalController,
            scrollDirection: Axis.horizontal,
            primary: false,
            child: SizedBox(
              width: _tableWidth,
              child: Column(
                children: [
                  _buildHeader(),
                  ...widget.items.map(_buildRow),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // Header Builder
  // ===========================================================================
  Widget _buildHeader() {
    return Container(
      height: 56,
      color: AppColors.surface,
      child: const Row(
        children: [
          _HeaderCell(title: 'الصنف', width: 220),
          _HeaderCell(title: 'الباركود', width: 140),
          _HeaderCell(title: 'الفئة', width: 150),
          _HeaderCell(title: 'وحدات/كرتونة', width: 110),
          _HeaderCell(title: 'المخزون', width: 150),
          _HeaderCell(title: 'عدد الكراتين', width: 120),
          _HeaderCell(title: 'سعر الكرتونة', width: 130),
          _HeaderCell(title: 'شراء الوحدة', width: 120),
          _HeaderCell(title: 'بيع الوحدة', width: 140),
          _HeaderCell(title: 'الإجمالي', width: 130),
          _HeaderCell(title: '', width: 80),
        ],
      ),
    );
  }

  // ===========================================================================
  // Row Builder
  // ===========================================================================
  Widget _buildRow(PurchaseItemDraft item) {
    final isLoss = item.unitProfit < 0;

    return Container(
      constraints: const BoxConstraints(minHeight: 90),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.divider,
            width: 0.7,
          ),
        ),
      ),
      child: Row(
        children: [
          _buildProductCell(item, isLoss),
          _buildBarcodeCell(item),
          _buildCategoryCell(item),
          _buildUnitsCell(item),
          _buildStockCell(item),
          _buildQuantityCell(item),
          _buildCartonPriceCell(item),
          _buildUnitPurchaseCell(item),
          _buildSalePriceCell(item, isLoss),
          _buildTotalCell(item),
          _buildRemoveCell(item),
        ],
      ),
    );
  }

  // ===========================================================================
  // Cells Builders
  // ===========================================================================
  Widget _buildProductCell(PurchaseItemDraft item, bool isLoss) {
    final hasWarning = item.barcode.isEmpty || item.priceChanged || isLoss;

    return _Cell(
      width: 220,
      child: Row(
        children: [
          if (hasWarning)
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Icon(
                Icons.warning_amber_rounded,
                color: AppColors.warning,
                size: 18,
              ),
            ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (item.priceChanged)
                  Text(
                    'السعر اتغيّر (كان ${item.lastCartonPrice.toStringAsFixed(2)})',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: _secondaryTextStyle.copyWith(
                      color: AppColors.warning,
                      fontSize: 11,
                    ),
                  ),
                if (isLoss)
                  Text(
                    'البيع أقل من الشراء',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: _secondaryTextStyle.copyWith(
                      color: AppColors.danger,
                      fontSize: 11,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarcodeCell(PurchaseItemDraft item) {
    return _Cell(
      width: 140,
      child: Text(
        item.barcode.isEmpty ? 'بدون باركود' : item.barcode,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: _secondaryTextStyle,
      ),
    );
  }

  Widget _buildCategoryCell(PurchaseItemDraft item) {
    return _Cell(
      width: 150,
      child: Text(
        '${item.category} · ${item.unit}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: _secondaryTextStyle,
      ),
    );
  }

  Widget _buildUnitsCell(PurchaseItemDraft item) {
    return _Cell(
      width: 110,
      alignment: Alignment.center,
      child: Text(
        '${item.unitsPerCarton}',
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildStockCell(PurchaseItemDraft item) {
    return _Cell(
      width: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${item.currentStock} ← ${item.stockAfter}',
            maxLines: 1,
          ),
          const SizedBox(height: 4),
          Text(
            item.hasFractionalUnits
                ? '+${item.totalUnits} وحدة (تقريب)'
                : '+${item.totalUnits} وحدة',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: _secondaryTextStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityCell(PurchaseItemDraft item) {
    return _Cell(
      width: 120,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        initialValue: formatCartons(item.cartonQuantity),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 11,
          ),
        ),
        onChanged: (value) {
          final quantity = parseDecimal(value);
          if (quantity != null && quantity > 0) {
            widget.onQuantityChanged(item.productId, quantity);
          }
        },
      ),
    );
  }

  Widget _buildCartonPriceCell(PurchaseItemDraft item) {
    return _Cell(
      width: 130,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        initialValue: item.cartonPurchasePrice.toStringAsFixed(2),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 11,
          ),
        ),
        onChanged: (value) {
          final price = parseDecimal(value);
          if (price != null && price >= 0) {
            widget.onPriceChanged(item.productId, price);
          }
        },
      ),
    );
  }

  Widget _buildUnitPurchaseCell(PurchaseItemDraft item) {
    return _Cell(
      width: 120,
      alignment: Alignment.center,
      child: Text(
        item.unitPurchasePrice.toStringAsFixed(2),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildSalePriceCell(PurchaseItemDraft item, bool isLoss) {
    if (!item.priceChanged) {
      return _Cell(
        width: 140,
        alignment: Alignment.center,
        child: Text(
          item.salePrice.toStringAsFixed(2),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isLoss ? AppColors.danger : null,
          ),
        ),
      );
    }

    return _Cell(
      width: 140,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            initialValue: item.salePrice.toStringAsFixed(2),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 7,
              ),
            ),
            onChanged: (value) {
              final price = parseDecimal(value);
              if (price != null && price >= 0) {
                widget.onSalePriceChanged(item.productId, price);
              }
            },
          ),
          const SizedBox(height: 4),
          Text(
            'مقترح ${item.suggestedSalePrice.toStringAsFixed(2)}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.warning,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalCell(PurchaseItemDraft item) {
    return _Cell(
      width: 130,
      alignment: Alignment.center,
      child: Text(
        item.total.toStringAsFixed(2),
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildRemoveCell(PurchaseItemDraft item) {
    return _Cell(
      width: 80,
      alignment: Alignment.center,
      child: IconButton(
        tooltip: 'حذف الصنف',
        icon: const Icon(
          Icons.delete_outline,
          color: AppColors.danger,
        ),
        onPressed: () => widget.onRemove(item.productId),
      ),
    );
  }
}

// =============================================================================
// Helper Widgets
// =============================================================================
class _Cell extends StatelessWidget {
  const _Cell({
    required this.width,
    required this.child,
    this.alignment = Alignment.centerLeft,
    this.padding = const EdgeInsets.symmetric(horizontal: 12),
  });

  final double width;
  final Widget child;
  final Alignment alignment;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      alignment: alignment,
      padding: padding,
      child: child,
    );
  }
}

class _HeaderCell extends StatelessWidget {
  const _HeaderCell({
    required this.title,
    required this.width,
  });

  final String title;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _EmptyItemsPlaceholder extends StatelessWidget {
  const _EmptyItemsPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: const Text(
        'لسه مفيش أصناف مضافة للفاتورة',
        style: TextStyle(color: AppColors.textHint),
      ),
    );
  }
}