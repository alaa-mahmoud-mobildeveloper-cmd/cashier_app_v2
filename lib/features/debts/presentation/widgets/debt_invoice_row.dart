import 'package:cashier_app_v2/features/debts/domain/entities/debt_invoice.dart';
import 'package:cashier_app_v2/features/debts/presentation/widgets/debt_status_badge.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';


class DebtInvoiceRow extends StatelessWidget {
  final DebtInvoice invoice;
  final VoidCallback? onView;
  const DebtInvoiceRow({super.key, required this.invoice, this.onView});

  String get date => '${invoice.date.year}-${invoice.date.month.toString().padLeft(2, '0')}-${invoice.date.day.toString().padLeft(2, '0')}';
  String money(double value) => '${value.toStringAsFixed(2)} ج';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: const BoxDecoration(border: Border(top: BorderSide(color: AppColors.divider))),
      child: Row(children: [
        Expanded(flex: 2, child: Text(invoice.invoiceNumber, style: const TextStyle(color: AppColors.gold, fontWeight: FontWeight.w600))),
        Expanded(flex: 2, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(date, style: const TextStyle(color: AppColors.textSecondary)), const SizedBox(height: 3), Text(invoice.phone, style: const TextStyle(color: AppColors.textHint, fontSize: 11))])),
        Expanded(flex: 3, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(invoice.customerName, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600)), Text(invoice.phone, style: const TextStyle(color: AppColors.textHint, fontSize: 11))])),
        Expanded(flex: 2, child: Text(money(invoice.total), style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600))),
        Expanded(flex: 2, child: Text(money(invoice.paid), style: const TextStyle(color: AppColors.success, fontWeight: FontWeight.w600))),
        Expanded(flex: 2, child: Text(money(invoice.remaining), style: const TextStyle(color: AppColors.danger, fontWeight: FontWeight.w600))),
        Expanded(flex: 2, child: DebtStatusBadge(status: invoice.status)),
        SizedBox(width: 72, child: OutlinedButton(onPressed: onView, child: const Text('عرض'))),
      ]),
    );
  }
}
