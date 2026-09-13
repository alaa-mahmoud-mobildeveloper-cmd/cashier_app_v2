import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/debt_invoice.dart';

class DebtInvoiceRow extends StatelessWidget {
  final DebtInvoice invoice;
  final VoidCallback onView;

  const DebtInvoiceRow({
    super.key,
    required this.invoice,
    required this.onView,
  });

  @override
  Widget build(BuildContext context) {
    // تنسيق التاريخ من DateTime إلى String
    final formattedDate = "${invoice.date.year}-${invoice.date.month.toString().padLeft(2, '0')}-${invoice.date.day.toString().padLeft(2, '0')}";

    // حساب المبلغ المتبقي
    final double remaining = invoice.total - invoice.paid;

    // تحديد النص واللون حسب حالة الفاتورة
    String statusText;
    Color statusColor;

    switch (invoice.status) {
      case DebtStatus.paid:
        statusText = 'محصل';
        statusColor = AppColors.success;
        break;
      case DebtStatus.partial:
        statusText = 'جزئي';
        statusColor = AppColors.gold;
        break;
      case DebtStatus.unpaid:
        statusText = 'غير محصل';
        statusColor = AppColors.danger;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border, width: 0.5)),
      ),
      child: Row(
        children: [
          // رقم الفاتورة
          SizedBox(
            width: 120,
            child: Text(
              invoice.invoiceNumber,
              style: const TextStyle(color: AppColors.gold, fontWeight: FontWeight.bold),
            ),
          ),
          // التاريخ
          SizedBox(
            width: 130,
            child: Text(
              formattedDate,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ),
          // العميل
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  invoice.customerName,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                ),
                if (invoice.phone.isNotEmpty)
                  Text(
                    invoice.phone,
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                  ),
              ],
            ),
          ),
          // الإجمالي
          SizedBox(
            width: 100,
            child: Text(
              '${invoice.total} ج',
              style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textPrimary),
            ),
          ),
          // المدفوع
          SizedBox(
            width: 100,
            child: Text(
              '${invoice.paid} ج',
              style: const TextStyle(color: AppColors.success),
            ),
          ),
          // المتبقي
          SizedBox(
            width: 100,
            child: Text(
              '$remaining ج',
              style: const TextStyle(color: AppColors.danger),
            ),
          ),
          // الحالة
          SizedBox(
            width: 110,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                statusText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // زر العرض
          SizedBox(
            width: 70,
            child: IconButton(
              icon: const Icon(Icons.visibility_outlined, color: AppColors.gold, size: 20),
              onPressed: onView,
              tooltip: 'التفاصيل',
            ),
          ),
        ],
      ),
    );
  }
}