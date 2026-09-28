import 'package:flutter/material.dart';
import 'package:cashier_app_v2/core/constants/app_colors.dart';

class SupplierSearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const SupplierSearchField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: const TextStyle(color: AppColors.textPrimary),
      decoration: const InputDecoration(
        hintText: 'ابحث بالاسم أو رقم الهاتف...',
        prefixIcon: Icon(Icons.search, color: AppColors.textHint),
      ),
    );
  }
}
