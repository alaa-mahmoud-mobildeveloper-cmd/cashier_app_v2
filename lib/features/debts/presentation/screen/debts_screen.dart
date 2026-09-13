import 'package:cashier_app_v2/features/debts/domain/entities/debt_invoice.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

import '../widgets/debt_filters.dart';
import '../widgets/debt_invoice_row.dart';
import '../widgets/debt_summary_card.dart';
import '../widgets/debts_header.dart';

class DebtsScreen extends StatefulWidget {
  const DebtsScreen({super.key});
  @override
  State<DebtsScreen> createState() => _DebtsScreenState();
}

class _DebtsScreenState extends State<DebtsScreen> {
  final searchController = TextEditingController();
  String selectedFilter = 'غير محصل';

  final invoices = [
    DebtInvoice(invoiceNumber: 'INV-0002', customerName: 'عبد الرحمن محمد', phone: '01012345678', date: DateTime(2026, 9, 3), total: 185, paid: 100, status: DebtStatus.partial),
    DebtInvoice(invoiceNumber: 'INV-0004', customerName: 'فاطمة علي', phone: '01098765432', date: DateTime(2026, 9, 2), total: 126, paid: 0, status: DebtStatus.unpaid),
  ];

  @override
  void dispose() { searchController.dispose(); super.dispose(); }

  List<DebtInvoice> get filteredInvoices {
    final query = searchController.text.trim().toLowerCase();
    return invoices.where((invoice) {
      final matchesQuery = query.isEmpty || invoice.customerName.toLowerCase().contains(query) || invoice.invoiceNumber.toLowerCase().contains(query);
      final matchesFilter = selectedFilter == 'الكل' || (selectedFilter == 'محصل' && invoice.status == DebtStatus.paid) || (selectedFilter == 'جزئي' && invoice.status == DebtStatus.partial) || (selectedFilter == 'غير محصل' && invoice.status == DebtStatus.unpaid);
      return matchesQuery && matchesFilter;
    }).toList();
  }

  double get total => invoices.fold(0, (sum, invoice) => sum + invoice.total);
  double get paid => invoices.fold(0, (sum, invoice) => sum + invoice.paid);
  double get remaining => total - paid;
  String money(double value) => '${value.toStringAsFixed(2)} ج';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: LayoutBuilder(builder: (_, constraints) {
            final compact = constraints.maxWidth < 800;
            return SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 24, left: compact ? 12 : 28, right: compact ? 12 : 28),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                DebtsHeader(outstanding: money(remaining)),
                const SizedBox(height: 16),
                _summary(compact),
                const SizedBox(height: 16),
                _filters(),
                const SizedBox(height: 10),
                _table(),
              ]),
            );
          }),
        ),
      ),
    );
  }

  Widget _summary(bool compact) {
    final cards = [
      DebtSummaryCard(title: 'إجمالي الآجل', amount: money(total), color: AppColors.gold, icon: Icons.receipt_long_outlined),
      DebtSummaryCard(title: 'تم تحصيله', amount: money(paid), color: AppColors.success, icon: Icons.check_circle_outline),
      DebtSummaryCard(title: 'المتبقي للتحصيل', amount: money(remaining), color: AppColors.danger, icon: Icons.schedule_outlined),
    ];
    return GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: compact ? 1 : 3,
        mainAxisSpacing: 12, crossAxisSpacing: 16,
        childAspectRatio: compact ? 4.3 : 2.8,
        children: cards);
  }

  Widget _filters() {
    return DebtFilters(
      controller: searchController,
      selected: selectedFilter,
      onSearch: (_) => setState(() {}),
      onSelected: (value) => setState(() => selectedFilter = value),
    );
  }

  Widget _table() {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 1120,
          child: Column(children: [
            _tableHeader(),
            if (filteredInvoices.isEmpty)
              const Padding(padding: EdgeInsets.all(32), child: Text('لا توجد فواتير مطابقة', style: TextStyle(color: AppColors.textSecondary)))
            else
              ...filteredInvoices.map((invoice) => DebtInvoiceRow(invoice: invoice, onView: () {})),
          ]),
        ),
      ),
    );
  }

  Widget _tableHeader() {
    const headers = ['رقم الفاتورة', 'التاريخ', 'العميل', 'الإجمالي', 'المدفوع', 'المتبقي', 'الحالة', ''];
    return Container(padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16), color: AppColors.surfaceLight, child: Row(children: headers.map((header) => Expanded(flex: header.isEmpty ? 2 : 2, child: Text(header, style: const TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600)))).toList()));
  }
}