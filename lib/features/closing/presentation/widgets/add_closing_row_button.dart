import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class AddClosingRowButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddClosingRowButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.add),
        label: const Text('إضافة سطر'),
      ),
    );
  }
}