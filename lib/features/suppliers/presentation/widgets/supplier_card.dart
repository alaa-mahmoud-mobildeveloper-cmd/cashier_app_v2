import 'package:flutter/material.dart';
import 'package:cashier_app_v2/core/constants/app_colors.dart';
import 'package:cashier_app_v2/features/suppliers/domain/entities/supplier_ui.dart';

class SupplierCard extends StatelessWidget {
  final SupplierUi supplier;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const SupplierCard({
    super.key,
    required this.supplier,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  _Avatar(letter: supplier.name.characters.first),
                  const SizedBox(width: 12),
                  Expanded(child: _Info(supplier: supplier)),
                  _ActionsMenu(onEdit: onEdit, onDelete: onDelete),
                ],
              ),
              if (supplier.hasDue || supplier.totalCollected > 0) ...[
                const SizedBox(height: 12),
                _DebtRow(supplier: supplier),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String letter;
  const _Avatar({required this.letter});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      decoration: const BoxDecoration(
        color: AppColors.goldSurface,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        letter,
        style: const TextStyle(
          color: AppColors.gold,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}

class _Info extends StatelessWidget {
  final SupplierUi supplier;
  const _Info({required this.supplier});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          supplier.name,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            if (supplier.phone != null) ...[
              const Icon(Icons.phone, size: 13, color: AppColors.textHint),
              const SizedBox(width: 4),
              Text(
                supplier.phone!,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 10),
            ],
            const Icon(Icons.inventory_2_outlined,
                size: 13, color: AppColors.textHint),
            const SizedBox(width: 4),
            Text(
              '${supplier.productsCount} منتج',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// صف صغير بيوضح إجمالي الأجل (المتبقي) والمُحصّل من المورد ده
class _DebtRow extends StatelessWidget {
  final SupplierUi supplier;
  const _DebtRow({required this.supplier});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: _DebtStat(
              label: 'الأجل المتبقي',
              value: supplier.totalDue,
              color: supplier.hasDue ? AppColors.danger : AppColors.textHint,
            ),
          ),
          Container(width: 1, height: 26, color: AppColors.border),
          const SizedBox(width: 12),
          Expanded(
            child: _DebtStat(
              label: 'تم تحصيله',
              value: supplier.totalCollected,
              color: AppColors.success,
            ),
          ),
        ],
      ),
    );
  }
}

class _DebtStat extends StatelessWidget {
  final String label;
  final double value;
  final Color color;
  const _DebtStat({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: AppColors.textHint, fontSize: 11),
        ),
        const SizedBox(height: 2),
        Text(
          '${value.toStringAsFixed(0)} ج.م',
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

class _ActionsMenu extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  const _ActionsMenu({required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: AppColors.surfaceLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.border),
      ),
      icon: const Icon(Icons.more_vert, color: AppColors.textSecondary),
      onSelected: (value) {
        if (value == 'edit') onEdit();
        if (value == 'delete') onDelete();
      },
      itemBuilder: (context) => const [
        PopupMenuItem(
          value: 'edit',
          child: Row(
            children: [
              Icon(Icons.edit_outlined, size: 18, color: AppColors.textPrimary),
              SizedBox(width: 8),
              Text('تعديل'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              Icon(Icons.delete_outline, size: 18, color: AppColors.danger),
              SizedBox(width: 8),
              Text('حذف', style: TextStyle(color: AppColors.danger)),
            ],
          ),
        ),
      ],
    );
  }
}
