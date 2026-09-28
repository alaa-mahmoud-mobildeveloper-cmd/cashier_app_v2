import 'package:flutter/material.dart';

import 'package:cashier_app_v2/core/constants/app_colors.dart';
import 'package:cashier_app_v2/features/suppliers/domain/entities/supplier_transaction.dart';

class SupplierTransactionTile extends StatelessWidget {
  final SupplierTransaction transaction;
  final VoidCallback? onCollect;

  const SupplierTransactionTile({
    super.key,
    required this.transaction,
    this.onCollect,
  });

  String _formatDate(DateTime d) {
    return '${d.day.toString().padLeft(2, '0')}/'
        '${d.month.toString().padLeft(2, '0')}/'
        '${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    final isSettled = transaction.isPaid;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(
                Icons.local_shipping_outlined,
                size: 16,
                color: AppColors.textHint,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'فاتورة توريد: ${transaction.invoiceNumber}',
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              _StatusBadge(
                transaction: transaction,
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            _formatDate(transaction.date),
            style: const TextStyle(
              color: AppColors.textHint,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _AmountBlock(
                label: 'الإجمالي',
                value: transaction.totalAmount,
                color: AppColors.textPrimary,
              ),
              _AmountBlock(
                label: 'محصّل',
                value: transaction.collectedAmount,
                color: AppColors.success,
              ),
              _AmountBlock(
                label: 'الأجل',
                value: transaction.dueAmount,
                color: isSettled
                    ? AppColors.textHint
                    : AppColors.danger,
              ),
            ],
          ),
          if (!isSettled && onCollect != null) ...[
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: onCollect,
                icon: const Icon(
                  Icons.payments_outlined,
                  size: 16,
                ),
                label: const Text('تسجيل تحصيل'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _AmountBlock extends StatelessWidget {
  final String label;
  final double value;
  final Color color;

  const _AmountBlock({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textHint,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            '${value.toStringAsFixed(2)} ج.م',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final SupplierTransaction transaction;

  const _StatusBadge({
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    final isPaid = transaction.isPaid;
    final isPartial = transaction.isPartial;

    final color = isPaid
        ? AppColors.success
        : isPartial
        ? AppColors.gold
        : AppColors.warning;

    final backgroundColor = isPaid
        ? AppColors.successSurface
        : const Color(0x26F0B429);

    final label = isPaid
        ? 'مسدد'
        : isPartial
        ? 'جزئي'
        : 'عليه أجل';

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}