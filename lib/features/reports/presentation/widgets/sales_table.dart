import 'package:cashier_app_v2/features/reports/data/models/sales_invoice_row.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

import 'status_badge.dart';
import 'table_pagination.dart';

class SalesTable extends StatelessWidget {
  final List<SalesInvoiceRow> rows;
  final int currentPage;
  final int totalPages;
  final int totalCount;
  final int pageSize;
  final ValueChanged<int> onPageChanged;

  const SalesTable({
    super.key,
    required this.rows,
    required this.currentPage,
    required this.totalPages,
    required this.totalCount,
    required this.pageSize,
    required this.onPageChanged,
  });

  // invoice, date, cashier, items, total, method, status
  static const _flexes = [2, 2, 2, 1, 2, 2, 2];
  static const double _tableMinWidth = 1000.0;

  Color _methodColor(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.cash:
        return AppColors.success;
      case PaymentMethod.visa:
        return const Color(0xFF4C8DFF);
      case PaymentMethod.credit:
        return AppColors.gold;
    }
  }

  String _methodLabel(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.cash:
        return 'كاش';
      case PaymentMethod.visa:
        return 'فيزا';
      case PaymentMethod.credit:
        return 'اجل';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final actualWidth = constraints.maxWidth > _tableMinWidth
                  ? constraints.maxWidth
                  : _tableMinWidth;

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: actualWidth,
                  child: Column(
                    children: [
                      _headerRow(),
                      if (rows.isEmpty)
                        const Padding(
                          padding: EdgeInsets.all(32),
                          child: Text('لا توجد فواتير مطابقة', style: TextStyle(color: AppColors.textSecondary)),
                        )
                      else
                        ...rows.map(_dataRow),
                    ],
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            child: TablePagination(
              currentPage: currentPage,
              totalPages: totalPages,
              totalCount: totalCount,
              pageSize: pageSize,
              onPageChanged: onPageChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerRow() {
    const headers = ['رقم الفاتورة', 'التاريخ', 'الكاشير', 'الأصناف', 'الإجمالي', 'طريقة الدفع', 'الحالة'];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      color: AppColors.surfaceLight,
      child: Row(
        children: List.generate(headers.length, (i) {
          return Expanded(
            flex: _flexes[i],
            child: Text(headers[i], style: const TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
          );
        }),
      ),
    );
  }

  Widget _dataRow(SalesInvoiceRow row) {
    final isCancelled = row.status == InvoiceStatus.cancelled;
    final statusColor = isCancelled ? AppColors.danger : AppColors.success;
    final statusLabel = isCancelled ? 'ملغاة' : 'مكتملة';
    final methodColor = _methodColor(row.paymentMethod);

    return Container(
      decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.white10))),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      child: Row(
        children: [
          Expanded(flex: _flexes[0], child: Text(row.invoiceNumber, style: const TextStyle(color: AppColors.gold, fontWeight: FontWeight.w600))),
          Expanded(flex: _flexes[1], child: Text(_formatDate(row.date), style: const TextStyle(color: AppColors.textPrimary))),
          Expanded(flex: _flexes[2], child: Text(row.cashier, style: const TextStyle(color: AppColors.textPrimary))),
          Expanded(flex: _flexes[3], child: Text('${row.itemsCount}', style: const TextStyle(color: AppColors.textSecondary))),
          Expanded(flex: _flexes[4], child: Text('${row.total.toStringAsFixed(0)} ج', style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600))),
          Expanded(flex: _flexes[5], child: StatusBadge(label: _methodLabel(row.paymentMethod), color: methodColor)),
          Expanded(flex: _flexes[6], child: StatusBadge(label: statusLabel, color: statusColor)),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
}