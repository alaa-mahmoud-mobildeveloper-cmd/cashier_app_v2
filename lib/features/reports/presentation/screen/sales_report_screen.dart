import 'package:cashier_app_v2/features/reports/data/models/sales_invoice_row.dart';
import 'package:cashier_app_v2/features/reports/data/models/top_product.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

import '../widgets/report_stat_card.dart';
import '../widgets/sales_filters_bar.dart';
import '../widgets/sales_report_header.dart';
import '../widgets/sales_table.dart';
import '../widgets/top_products_chart.dart';

class SalesReportScreen extends StatefulWidget {
  const SalesReportScreen({super.key});

  @override
  State<SalesReportScreen> createState() => _SalesReportScreenState();
}

class _SalesReportScreenState extends State<SalesReportScreen> {
  final searchController = TextEditingController();

  DateTime fromDate = DateTime(2026, 9, 3);
  DateTime toDate = DateTime(2026, 9, 1);

  static const paymentFilters = ['آجل', 'فيزا', 'كاش', 'الكل'];
  String selectedPaymentFilter = 'الكل';

  static const cashierOptions = ['كل الكاشيرين', 'احمد', 'محمد', 'سارة'];
  String selectedCashier = 'كل الكاشيرين';

  int currentPage = 1;
  static const pageSize = 5;

  final invoices = [
    SalesInvoiceRow(invoiceNumber: 'INV-0087', date: DateTime(2026, 9, 3), cashier: 'احمد', itemsCount: 8, total: 450, paymentMethod: PaymentMethod.cash, status: InvoiceStatus.completed),
    SalesInvoiceRow(invoiceNumber: 'INV-0086', date: DateTime(2026, 9, 3), cashier: 'محمد', itemsCount: 3, total: 120, paymentMethod: PaymentMethod.visa, status: InvoiceStatus.completed),
    SalesInvoiceRow(invoiceNumber: 'INV-0085', date: DateTime(2026, 9, 3), cashier: 'احمد', itemsCount: 12, total: 780, paymentMethod: PaymentMethod.credit, status: InvoiceStatus.completed),
    SalesInvoiceRow(invoiceNumber: 'INV-0084', date: DateTime(2026, 9, 3), cashier: 'سارة', itemsCount: 2, total: 65, paymentMethod: PaymentMethod.cash, status: InvoiceStatus.cancelled),
    SalesInvoiceRow(invoiceNumber: 'INV-0083', date: DateTime(2026, 9, 3), cashier: 'محمد', itemsCount: 6, total: 320, paymentMethod: PaymentMethod.visa, status: InvoiceStatus.completed),
    SalesInvoiceRow(invoiceNumber: 'INV-0082', date: DateTime(2026, 9, 2), cashier: 'احمد', itemsCount: 5, total: 210, paymentMethod: PaymentMethod.cash, status: InvoiceStatus.completed),
    SalesInvoiceRow(invoiceNumber: 'INV-0081', date: DateTime(2026, 9, 2), cashier: 'سارة', itemsCount: 9, total: 540, paymentMethod: PaymentMethod.credit, status: InvoiceStatus.completed),
    SalesInvoiceRow(invoiceNumber: 'INV-0080', date: DateTime(2026, 9, 2), cashier: 'محمد', itemsCount: 4, total: 180, paymentMethod: PaymentMethod.visa, status: InvoiceStatus.completed),
    SalesInvoiceRow(invoiceNumber: 'INV-0079', date: DateTime(2026, 9, 2), cashier: 'احمد', itemsCount: 1, total: 40, paymentMethod: PaymentMethod.cash, status: InvoiceStatus.cancelled),
    SalesInvoiceRow(invoiceNumber: 'INV-0078', date: DateTime(2026, 9, 1), cashier: 'سارة', itemsCount: 7, total: 395, paymentMethod: PaymentMethod.credit, status: InvoiceStatus.completed),
  ];

  static final topProducts = [
    const TopProduct(name: 'زيت 1.5 لتر', value: 140),
    const TopProduct(name: 'سكر 1 كجم', value: 128),
    const TopProduct(name: 'ارز 5 كجم', value: 96),
    const TopProduct(name: 'شاي ليبتون', value: 60),
    const TopProduct(name: 'حليب 1 لتر', value: 55),
    const TopProduct(name: 'صابون اريال', value: 48),
    const TopProduct(name: 'ماء معدني', value: 40),
    const TopProduct(name: 'جبن رومي', value: 32),
    const TopProduct(name: 'لبنة 185 جم', value: 26),
    const TopProduct(name: 'زيت الزيتون', value: 20),
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<SalesInvoiceRow> get _filteredInvoices {
    final query = searchController.text.trim().toLowerCase();
    return invoices.where((invoice) {
      final matchesQuery = query.isEmpty ||
          invoice.invoiceNumber.toLowerCase().contains(query) ||
          invoice.cashier.toLowerCase().contains(query);

      final matchesPayment = selectedPaymentFilter == 'الكل' ||
          (selectedPaymentFilter == 'كاش' && invoice.paymentMethod == PaymentMethod.cash) ||
          (selectedPaymentFilter == 'فيزا' && invoice.paymentMethod == PaymentMethod.visa) ||
          (selectedPaymentFilter == 'آجل' && invoice.paymentMethod == PaymentMethod.credit);

      final matchesCashier = selectedCashier == 'كل الكاشيرين' || invoice.cashier == selectedCashier;

      return matchesQuery && matchesPayment && matchesCashier;
    }).toList();
  }

  List<SalesInvoiceRow> get _paginatedInvoices {
    final filtered = _filteredInvoices;
    final start = (currentPage - 1) * pageSize;
    if (start >= filtered.length) return [];
    final end = (start + pageSize).clamp(0, filtered.length);
    return filtered.sublist(start, end);
  }

  int get _totalPages {
    final count = _filteredInvoices.length;
    return count == 0 ? 1 : (count / pageSize).ceil();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: LayoutBuilder(builder: (context, constraints) {
            final compact = constraints.maxWidth < 800;
            return SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 24, left: compact ? 12 : 28, right: compact ? 12 : 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SalesReportHeader(
                    fromDate: fromDate,
                    toDate: toDate,
                    onExportExcel: () {},
                    onExportPdf: () {},
                    onPickFromDate: () => _pickDate(isFrom: true),
                    onPickToDate: () => _pickDate(isFrom: false),
                  ),
                  const SizedBox(height: 8),
                  _statsGrid(compact),
                  const SizedBox(height: 20),
                  SalesFiltersBar(
                    paymentFilters: paymentFilters,
                    selectedPaymentFilter: selectedPaymentFilter,
                    onPaymentFilterChanged: (value) => setState(() {
                      selectedPaymentFilter = value;
                      currentPage = 1;
                    }),
                    cashiers: cashierOptions,
                    selectedCashier: selectedCashier,
                    onCashierChanged: (value) => setState(() {
                      selectedCashier = value;
                      currentPage = 1;
                    }),
                    searchController: searchController,
                    onSearch: (_) => setState(() => currentPage = 1),
                  ),
                  const SizedBox(height: 16),
                  SalesTable(
                    rows: _paginatedInvoices,
                    currentPage: currentPage,
                    totalPages: _totalPages,
                    totalCount: _filteredInvoices.length,
                    pageSize: pageSize,
                    onPageChanged: (page) => setState(() => currentPage = page),
                  ),
                  const SizedBox(height: 20),
                  TopProductsChart(products: topProducts),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Future<void> _pickDate({required bool isFrom}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isFrom ? fromDate : toDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked == null) return;
    setState(() {
      if (isFrom) {
        fromDate = picked;
      } else {
        toDate = picked;
      }
    });
  }

  Widget _statsGrid(bool compact) {
    const cards = [
      ReportStatCard(title: 'متوسط الفاتورة', value: '78 ج', icon: Icons.bar_chart_outlined),
      ReportStatCard(title: 'عدد الفواتير', value: '87', icon: Icons.receipt_long_outlined),
      ReportStatCard(title: 'صافي الربح', value: '2,040 ج', icon: Icons.attach_money),
      ReportStatCard(title: 'إجمالي المبيعات', value: '6,800 ج', icon: Icons.trending_up),
    ];
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: compact ? 2 : 4,
      mainAxisSpacing: 14,
      crossAxisSpacing: 14,
      childAspectRatio: compact ? 1.4 : 1.3,
      children: cards,
    );
  }
}
