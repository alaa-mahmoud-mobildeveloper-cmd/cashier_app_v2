import 'package:flutter/material.dart';

import 'package:cashier_app_v2/core/constants/app_colors.dart';
import 'product_table_columns.dart';

class ProductsTableHeader extends StatelessWidget {
  const ProductsTableHeader({super.key});

  Widget _cell(String text, int flex) {
    return Expanded(
      flex: flex,
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
        children: [
          for (final col in ProductTableColumns.columns) _cell(col.label, col.flex),
        ],
      ),
    );
  }
}