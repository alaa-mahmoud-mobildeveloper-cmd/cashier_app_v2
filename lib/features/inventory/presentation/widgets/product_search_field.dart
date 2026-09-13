import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class ProductSearchField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const ProductSearchField({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    // بيعتمد على inputDecorationTheme الجاهز في AppTheme (fillColor: input, الحدود..)
    // فبنبعت بس اللي مختلف عن الديفولت: الهنت والأيقونة ومحاذاة النص
    return TextField(
      onChanged: onChanged,
      textAlign: TextAlign.right,
      decoration: const InputDecoration(
        hintText: 'بحث بالاسم أو الباركود...',
        prefixIcon: Icon(Icons.search, color: AppColors.textSecondary, size: 20),
      ),
    );
  }
}
