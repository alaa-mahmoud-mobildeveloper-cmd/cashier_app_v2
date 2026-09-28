import 'package:cashier_app_v2/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

/// لوحة ملخص فاتورة الشراء: الإجمالي، الخصم، الضريبة، الصافي، وطريقة
/// الدفع، وزرار الحفظ.
class PurchaseSummaryPanel extends StatelessWidget {
  const PurchaseSummaryPanel({
    super.key,
    required this.total,
    required this.discount,
    required this.tax,
    required this.netTotal,
    required this.paymentMethod,
    required this.onDiscountChanged,
    required this.onTaxChanged,
    required this.onPaymentMethodChanged,
    required this.onSave,
    required this.isSaving,
    required this.canSave,
  });

  final double total;
  final double discount;
  final double tax;
  final double netTotal;
  final String paymentMethod;
  final ValueChanged<double> onDiscountChanged;
  final ValueChanged<double> onTaxChanged;
  final ValueChanged<String> onPaymentMethodChanged;
  final VoidCallback onSave;
  final bool isSaving;
  final bool canSave;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'ملخص الفاتورة',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          _SummaryRow(label: 'الإجمالي', value: total),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: discount.toStringAsFixed(2),
                  decoration: const InputDecoration(labelText: 'الخصم'),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  onChanged: (v) => onDiscountChanged(double.tryParse(v) ?? 0),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  initialValue: tax.toStringAsFixed(2),
                  decoration: const InputDecoration(labelText: 'الضريبة'),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  onChanged: (v) => onTaxChanged(double.tryParse(v) ?? 0),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: paymentMethod,
            decoration: const InputDecoration(labelText: 'طريقة الدفع'),
            dropdownColor: AppColors.surfaceLight,
            items: const [
              DropdownMenuItem(value: 'cash', child: Text('كاش')),
              DropdownMenuItem(value: 'credit', child: Text('آجل')),
            ],
            onChanged: (value) {
              if (value != null) onPaymentMethodChanged(value);
            },
          ),
          const Divider(height: 24, color: AppColors.divider),
          _SummaryRow(label: 'الصافي', value: netTotal, emphasize: true),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: canSave && !isSaving ? onSave : null,
            child: isSaving
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.black,
                    ),
                  )
                : const Text('حفظ الفاتورة'),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.emphasize = false,
  });

  final String label;
  final double value;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textSecondary)),
        Text(
          value.toStringAsFixed(2),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: emphasize ? 18 : 14,
            color: emphasize ? AppColors.gold : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
