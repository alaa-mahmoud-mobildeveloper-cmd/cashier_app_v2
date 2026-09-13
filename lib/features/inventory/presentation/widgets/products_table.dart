import 'package:cashier_app_v2/features/inventory/data/models/product_item.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/models/product_table_columns.dart';
import 'product_table_row.dart';
import 'products_table_header.dart';

class ProductsTable extends StatelessWidget {
  final List<ProductItem> items;
  final ValueChanged<ProductItem>? onEdit;

  const ProductsTable({super.key, required this.items, this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // لو الشاشة أعرض من الجدول نفسه، منعملش scroll ونمد الجدول
          // ياخد العرض المتاح كامل. لو أضيق، الجدول بياخد عرضه الطبيعي
          // ويظهر شريط scroll أفقي.
          final tableWidth = ProductTableColumns.totalWidth;
          final availableWidth = constraints.maxWidth;
          final contentWidth = tableWidth > availableWidth ? tableWidth : availableWidth;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: contentWidth,
              child: Column(
                children: [
                  const ProductsTableHeader(),
                  if (items.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 48),
                      child: Text(
                        'لا توجد أصناف مطابقة',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return ProductTableRow(
                          item: item,
                          onEdit: () => onEdit?.call(item),
                        );
                      },
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
