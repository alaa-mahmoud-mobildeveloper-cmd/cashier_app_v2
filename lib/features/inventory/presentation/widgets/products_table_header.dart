import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/models/product_table_columns.dart';

class ProductsTableHeader extends StatelessWidget {
  const ProductsTableHeader({super.key});

  Widget _cell(String text, double width) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _cell('الصورة', ProductTableColumns.image as double),
          _cell('اسم الصنف', ProductTableColumns.name as double),
          _cell('الباركود', ProductTableColumns.barcode as double),
          _cell('الفئة', ProductTableColumns.category as double),
          _cell('سعر البيع', ProductTableColumns.sellPrice as double),
          _cell('التكلفة/وحدة', ProductTableColumns.unitCost as double),
          _cell('كرتونة', ProductTableColumns.carton as double),
          _cell('الكمية', ProductTableColumns.quantity as double),
          _cell('الحالة', ProductTableColumns.status as double),
          _cell('إجراءات', ProductTableColumns.actions as double),
        ],
      ),
    );
  }
}
