import 'package:cashier_app_v2/core/constants/app_colors.dart';
import 'package:cashier_app_v2/features/inventory/data/models/product_item.dart';
import 'package:flutter/material.dart';
// أو المسار الصحيح لديك
import 'product_table_row.dart';
import 'products_table_header.dart';

class ProductsTable extends StatelessWidget {
  final List<ProductItem> items;
  final ValueChanged<ProductItem>? onEdit;

  const ProductsTable({super.key, required this.items, this.onEdit});

  // أقل عرض مسموح للجدول قبل ظهور شريط التمرير الأفقي على الشاشات الصغيرة
  static const double _tableMinWidth = 1000.0;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final actualWidth = constraints.maxWidth > _tableMinWidth
              ? constraints.maxWidth
              : _tableMinWidth;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: actualWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const ProductsTableHeader(),
                  if (items.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 48),
                      child: Center(
                        child: Text(
                          'لا توجد أصناف مطابقة',
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                      ),
                    )
                  else
                    ...items.map(
                          (item) => ProductTableRow(
                        item: item,
                        onEdit: () => onEdit?.call(item),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}