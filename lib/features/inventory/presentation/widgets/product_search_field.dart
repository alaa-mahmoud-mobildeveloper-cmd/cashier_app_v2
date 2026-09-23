import 'dart:async';

import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class ProductSearchField extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const ProductSearchField({
    super.key,
    required this.onChanged,
  });

  @override
  State<ProductSearchField> createState() => _ProductSearchFieldState();
}

class _ProductSearchFieldState extends State<ProductSearchField> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();

    _debounce = Timer(
      const Duration(milliseconds: 500),
          () {
        widget.onChanged(value.trim());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: _onSearchChanged,
      textAlign: TextAlign.right,
      decoration: const InputDecoration(
        hintText: 'بحث بالاسم أو الباركود...',
        prefixIcon: Icon(
          Icons.search,
          color: AppColors.textSecondary,
          size: 20,
        ),
      ),
    );
  }
}