import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/worker.dart';

class WorkerDetailsHeader extends StatelessWidget {
  final Worker worker;
  final bool showBackButton;

  const WorkerDetailsHeader({
    super.key,
    required this.worker,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if (showBackButton) ...[
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.textSecondary,
                  size: 18,
                ),
                tooltip: 'رجوع',
              ),
              const SizedBox(width: 8),
            ],
            Text(
              worker.name,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '${worker.role} — باركود: ${worker.barcode ?? '—'}',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
          ],
        ),
        CircleAvatar(
          backgroundColor: AppColors.gold,
          child: Text(
            worker.name.isNotEmpty ? worker.name.substring(0, 1) : 'ع',
            style: const TextStyle(
              color: AppColors.background,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
