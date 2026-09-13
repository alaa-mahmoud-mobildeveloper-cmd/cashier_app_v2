import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/models/product_table_columns.dart';

class ProductsTableHeader extends StatelessWidget {
  const ProductsTableHeader({super.key});

  // نسب التوزيع للأعمدة لتتجاوب مع الشاشة وتتطابق مع الصفوف
  static const _flexes = [1, 3, 2, 2, 2, 2, 2, 2, 2, 2];

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
    const headers = [
      'الصورة',
      'اسم الصنف',
      'الباركود',
      'الفئة',
      'سعر البيع',
      'التكلفة/وحدة',
      'كرتونة',
      'الكمية',
      'الحالة',
      'إجراءات',
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: List.generate(
          headers.length,
              (i) => _cell(headers[i], _flexes[i]),
        ),
      ),
    );
  }
}