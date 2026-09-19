import 'package:cashier_app_v2/features/inventory/presentation/uitl/product_status_style.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/product_status.dart';


class StatusBadge extends StatelessWidget {
  final ProductStatus status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: status.surfaceColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: status.color.withOpacity(0.5)),
      ),
      child: Text(
        status.label,
        style: TextStyle(
          color: status.color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}