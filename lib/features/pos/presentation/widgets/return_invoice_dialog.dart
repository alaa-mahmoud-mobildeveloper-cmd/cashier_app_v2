import 'package:flutter/material.dart';
import 'package:cashier_app_v2/core/database/app_database.dart';
import '../../../../core/constants/app_colors.dart';

class ReturnInvoiceDialog extends StatelessWidget {
  final List<Invoice> invoices; // استقبال قائمة الفواتير من نوع Drift Invoice
  final ValueChanged<int> onInvoiceSelected;

  const ReturnInvoiceDialog({
    super.key,
    required this.invoices,
    required this.onInvoiceSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 380),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'اختر الفاتورة للإرجاع',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: AppColors.textSecondary),
                  ),
                ],
              ),
              const Divider(height: 16),
              if (invoices.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                    child: Text(
                      'لا توجد فواتير سابقة متاحة للإرجاع',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ),
                )
              else
                ...invoices.map((invoice) {
                  final isReturned = invoice.status == 'returned';

                  return Card(
                    color: AppColors.card,
                    margin: const EdgeInsets.only(bottom: 8),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: AppColors.border),
                    ),
                    child: ListTile(
                      title: Text(
                        'فاتورة: ${invoice.invoiceNumber}',
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'الإجمالي: ${invoice.netAmount.toStringAsFixed(2)} ج | ${isReturned ? "مُرجعة" : "مكتملة"}',
                        style: TextStyle(
                          color: isReturned ? AppColors.danger : AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                      trailing: isReturned
                          ? const Text(
                        'مُرجعة مسبقاً',
                        style: TextStyle(color: AppColors.danger, fontSize: 11, fontWeight: FontWeight.bold),
                      )
                          : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.danger,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                          minimumSize: const Size(60, 32),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          onInvoiceSelected(invoice.id);
                        },
                        child: const Text('إرجاع'),
                      ),
                    ),
                  );
                }),
            ],
          ),
        ),
      ),
    );
  }
}