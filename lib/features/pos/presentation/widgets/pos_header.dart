import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class PosHeader extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final ValueChanged<String> onSearch;
  final ValueChanged<String>? onBarcodeScanned; // بيتنفذ لما السكانر يبعت Enter
  final VoidCallback? onReturn;

  const PosHeader({
    super.key,
    required this.controller,
    required this.onSearch,
    this.focusNode,
    this.onBarcodeScanned,
    this.onReturn,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              autofocus: true,
              onChanged: onSearch,
              onSubmitted: (value) {
                final code = value.trim();

                if (code.isEmpty) {
                  focusNode?.requestFocus();
                  return;
                }

                onBarcodeScanned?.call(code);

                controller.clear();
                onSearch('');

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (focusNode != null && !focusNode!.hasFocus) {
                    focusNode!.requestFocus();
                  }
                });
              },
              textInputAction: TextInputAction.search,
              decoration: const InputDecoration(
                hintText: 'ابحث بالاسم أو امسح الباركود',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton.icon(
            onPressed: onReturn,
            icon: const Icon(Icons.refresh),
            label: const Text('إرجاع'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.danger,
            ),
          ),
        ],
      ),
    );
  }
}