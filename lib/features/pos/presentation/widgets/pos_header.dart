import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class PosHeader extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSearch;
  final VoidCallback? onReturn;
  final ValueChanged<String>? onSubmitted;

  const PosHeader({
    super.key,
    required this.controller,
    required this.onSearch,
    required this.onSubmitted,
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
              onChanged: onSearch,
              onSubmitted: onSubmitted, // تأكد من استقبالها لو حابب تفصلها، أو خليه يستدعي onSearch
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
