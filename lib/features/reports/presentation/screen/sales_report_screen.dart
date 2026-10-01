import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cashier_app_v2/core/constants/app_colors.dart';
import 'package:cashier_app_v2/di.dart';

import 'package:cashier_app_v2/features/reports/data/models/sales_invoice_row.dart';
import 'package:cashier_app_v2/features/reports/data/models/top_product.dart';

import 'package:cashier_app_v2/features/reports/domain/entities/sales_invoice.dart';
import 'package:cashier_app_v2/features/reports/domain/entities/top_product.dart'
as domain;

import '../bloc/sales_report_bloc.dart';
import '../bloc/sales_report_event.dart';
import '../bloc/sales_report_state.dart';

import '../widgets/report_stat_card.dart';
import '../widgets/sales_filters_bar.dart';
import '../widgets/sales_report_header.dart';
import '../widgets/sales_table.dart';
import '../widgets/top_products_chart.dart';

class SalesReportScreen extends StatelessWidget {
  const SalesReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SalesReportBloc>(),
      child: const _SalesReportView(),
    );
  }
}

class _SalesReportView extends StatefulWidget {
  const _SalesReportView();

  @override
  State<_SalesReportView> createState() => _SalesReportViewState();
}

class _SalesReportViewState extends State<_SalesReportView> {
  final searchController = TextEditingController();

  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();

  static const paymentFilters = [
    'آجل',
    'محفظه',
    'فيزا',
    'كاش',
    'الكل',
  ];

  String selectedPaymentFilter = 'الكل';

  String selectedCashier = 'كل الكاشيرين';

  int? selectedCashierId;

  int currentPage = 1;

  static const pageSize = 5;

  @override
  void initState() {
    super.initState();

    searchController.addListener(_onSearchChanged);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      context.read<SalesReportBloc>().add(
        const LoadSalesCashiers(),
      );

      _loadReport();
    });
  }

  void _loadReport() {
    context.read<SalesReportBloc>().add(
      LoadSalesReport(
        from: fromDate,
        to: toDate,
        paymentMethod: _paymentMethodValue,
        cashierId: selectedCashierId,
        search: searchController.text.trim(),
      ),
    );
  }

  String? get _paymentMethodValue {
    switch (selectedPaymentFilter) {
      case 'كاش':
        return 'cash';
      case'محفظه':
        return 'wallet';
      case 'فيزا':
        return 'visa';
      case 'آجل':
        return 'credit';
      default:
        return null;
    }
  }

  void _onSearchChanged() {
    currentPage = 1;
    _loadReport();
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  Future<void> _pickDate({
    required bool isFrom,
  }) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isFrom ? fromDate : toDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked == null || !mounted) return;

    setState(() {
      if (isFrom) {
        fromDate = picked;

        if (toDate.isBefore(fromDate)) {
          toDate = fromDate;
        }
      } else {
        toDate = picked;

        if (toDate.isBefore(fromDate)) {
          fromDate = toDate;
        }
      }

      currentPage = 1;
    });

    _loadReport();
  }

  void _onPaymentChanged(String value) {
    setState(() {
      selectedPaymentFilter = value;
      currentPage = 1;
    });

    _loadReport();
  }

  void _onCashierChanged(String value) {
    final state = context.read<SalesReportBloc>().state;

    int? cashierId;

    if (value != 'كل الكاشيرين') {
      for (final cashier in state.cashiers) {
        if (cashier.name == value) {
          cashierId = cashier.id;
          break;
        }
      }
    }

    setState(() {
      selectedCashier = value;
      selectedCashierId = cashierId;
      currentPage = 1;
    });

    _loadReport();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: BlocBuilder<SalesReportBloc, SalesReportState>(
            builder: (context, state) {
              final report = state.report;

              final invoices = report?.invoices ?? [];

              final totalPages = invoices.isEmpty
                  ? 1
                  : (invoices.length / pageSize).ceil();

              final safeCurrentPage = currentPage > totalPages
                  ? totalPages
                  : currentPage;

              if (safeCurrentPage != currentPage) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (!mounted) return;

                  setState(() {
                    currentPage = safeCurrentPage;
                  });
                });
              }

              final start =
                  (safeCurrentPage - 1) * pageSize;

              final end = (start + pageSize)
                  .clamp(0, invoices.length);

              final pageInvoices = start >= invoices.length
                  ? <SalesInvoice>[]
                  : invoices.sublist(start, end);

              final rows = pageInvoices
                  .map(_mapInvoice)
                  .toList();

              final topProducts = (report?.topProducts ?? [])
                  .map(_mapTopProduct)
                  .toList();

              return LayoutBuilder(
                builder: (context, constraints) {
                  final compact = constraints.maxWidth < 800;

                  return SingleChildScrollView(
                    padding: EdgeInsets.only(
                      bottom: 24,
                      left: compact ? 12 : 28,
                      right: compact ? 12 : 28,
                    ),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.stretch,
                      children: [
                        SalesReportHeader(
                          fromDate: fromDate,
                          toDate: toDate,
                          onExportExcel: () {},
                          onExportPdf: () {},
                          onPickFromDate: () =>
                              _pickDate(isFrom: true),
                          onPickToDate: () =>
                              _pickDate(isFrom: false),
                        ),

                        const SizedBox(height: 8),

                        _buildStats(
                          report,
                          compact,
                        ),

                        const SizedBox(height: 20),

                        SalesFiltersBar(
                          paymentFilters: paymentFilters,
                          selectedPaymentFilter:
                          selectedPaymentFilter,
                          onPaymentFilterChanged:
                          _onPaymentChanged,
                          cashiers: [
                            'كل الكاشيرين',
                            ...state.cashiers.map(
                                  (cashier) => cashier.name,
                            ),
                          ],
                          selectedCashier: selectedCashier,
                          onCashierChanged:
                          _onCashierChanged,
                          searchController:
                          searchController,
                          onSearch: (_) {
                            currentPage = 1;
                          },
                        ),

                        const SizedBox(height: 16),

                        if (state.status ==
                            SalesReportStatus.failure)
                          _buildError(state),

                        if (state.status ==
                            SalesReportStatus.loading)
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 30,
                            ),
                            child: Center(
                              child:
                              CircularProgressIndicator(),
                            ),
                          ),

                        if (state.status !=
                            SalesReportStatus.loading)
                          SalesTable(
                            rows: rows,
                            currentPage: safeCurrentPage,
                            totalPages: totalPages,
                            totalCount: invoices.length,
                            pageSize: pageSize,
                            onPageChanged: (page) {
                              setState(() {
                                currentPage = page;
                              });
                            },
                          ),

                        const SizedBox(height: 20),

                        TopProductsChart(
                          products: topProducts,
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildStats(
      dynamic report,
      bool compact,
      ) {
    final average = report?.averageInvoice ?? 0.0;
    final invoiceCount = report?.invoiceCount ?? 0;
    final profit = report?.totalProfit ?? 0.0;
    final sales = report?.totalSales ?? 0.0;

    final cards = [
      ReportStatCard(
        title: 'متوسط الفاتورة',
        value: '${average.toStringAsFixed(2)} ج',
        icon: Icons.bar_chart_outlined,
      ),
      ReportStatCard(
        title: 'عدد الفواتير',
        value: '$invoiceCount',
        icon: Icons.receipt_long_outlined,
      ),
      ReportStatCard(
        title: 'صافي الربح',
        value: '${profit.toStringAsFixed(2)} ج',
        icon: Icons.attach_money,
      ),
      ReportStatCard(
        title: 'إجمالي المبيعات',
        value: '${sales.toStringAsFixed(2)} ج',
        icon: Icons.trending_up,
      ),
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

  Widget _buildError(
      SalesReportState state,
      ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.danger.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.danger.withValues(alpha: 0.35),
        ),
      ),
      child: Text(
        state.errorMessage ??
            'حدث خطأ أثناء تحميل التقرير',
        style: const TextStyle(
          color: AppColors.danger,
        ),
      ),
    );
  }

  SalesInvoiceRow _mapInvoice(
      SalesInvoice invoice,
      ) {
    return SalesInvoiceRow(
      invoiceNumber: invoice.invoiceNumber,
      date: invoice.createdAt,
      cashier: invoice.cashierName,
      itemsCount: invoice.itemsCount,
      total: invoice.netAmount,
      paymentMethod: _mapPaymentMethod(
        invoice.paymentMethod,
      ),
      status: _mapInvoiceStatus(
        invoice.status,
      ),
    );
  }

  PaymentMethod _mapPaymentMethod(
      String value,
      ) {
    switch (value.toLowerCase()) {
      case 'visa':
        return PaymentMethod.visa;

      case 'credit':
        return PaymentMethod.credit;
      case 'wallet':
        return PaymentMethod.wallet;
      case 'fawry':
        return PaymentMethod.fawry;
      case 'cash':
      default:
        return PaymentMethod.cash;
    }
  }

  InvoiceStatus _mapInvoiceStatus(
      String value,
      ) {
    switch (value.toLowerCase()) {
      case 'cancelled':
      case 'canceled':
        return InvoiceStatus.cancelled;

      case 'completed':
      default:
        return InvoiceStatus.completed;
    }
  }

  TopProduct _mapTopProduct(
      domain.TopProduct product,
      ) {
    return TopProduct(
      name: product.productName,
      value: product.quantity.toDouble(),
    );
  }
}
