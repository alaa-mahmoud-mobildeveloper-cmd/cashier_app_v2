import 'package:flutter/material.dart';

class SaveClosingButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isClosed;

  const SaveClosingButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
    this.isClosed = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: isLoading || isClosed ? null : onPressed,
        icon: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Icon(isClosed ? Icons.lock_outline : Icons.save_outlined),
        label: Text(
          isLoading
              ? 'جاري الحفظ...'
              : isClosed
              ? 'تم إغلاق اليوم'
              : 'حفظ وإغلاق القفلة',
        ),
      ),
    );
  }
}
