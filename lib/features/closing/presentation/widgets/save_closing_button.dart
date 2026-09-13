import 'package:flutter/material.dart';

class SaveClosingButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const SaveClosingButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: isLoading ? null : onPressed,
        icon: isLoading
            ? const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        )
            : const Icon(Icons.save_outlined),
        label: Text(
          isLoading ? 'جاري الحفظ...' : 'حفظ وإغلاق القفلة',
        ),
      ),
    );
  }
}