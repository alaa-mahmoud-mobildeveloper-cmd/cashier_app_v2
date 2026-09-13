import 'package:cashier_app_v2/features/dashbord/data/models/low_stock_item.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class LowStockTable extends StatelessWidget {
  final List<LowStockItem> items;

  const LowStockTable({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.warning_amber_rounded, color: AppColors.gold, size: 18),
                    SizedBox(width: 6),
                    Text('الأصناف اللي قربت تخلص', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 15)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: AppColors.gold.withOpacity(0.12), borderRadius: BorderRadius.circular(20)),
                  child: Text('${items.length} صنف', style: const TextStyle(color: AppColors.gold, fontWeight: FontWeight.w600, fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 640,
                child: Column(
                  children: [
                    _headerRow(),
                    for (final item in items) _dataRow(item),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerRow() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text('الحالة', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600))),
          Expanded(flex: 2, child: Text('الكمية المتبقية', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600))),
          Expanded(flex: 3, child: Text('اسم الصنف', textAlign: TextAlign.end, style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }

  Widget _dataRow(LowStockItem item) {
    final isCritical = item.status == StockStatus.critical;
    final color = isCritical ? AppColors.danger : AppColors.gold;
    final label = isCritical ? 'حرج' : 'قرب يخلص';

    return Container(
      decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.white10))),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: color.withOpacity(0.5)),
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
              ),
            ),
          ),
          Expanded(flex: 2, child: Text(item.remaining, style: const TextStyle(color: AppColors.textPrimary))),
          Expanded(flex: 3, child: Text(item.name, textAlign: TextAlign.end, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }
}
