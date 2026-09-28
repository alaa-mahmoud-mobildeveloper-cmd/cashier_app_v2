import 'package:cashier_app_v2/features/purchases/presentation/screen/purchases_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cashier_app_v2/core/constants/app_colors.dart';
import 'package:cashier_app_v2/di.dart';
import 'package:cashier_app_v2/features/purchases/domian/entities/purchase_invoice.dart';
import 'package:cashier_app_v2/features/purchases/presentation/bloc/purchase_bloc/purchase_bloc.dart';
import 'package:cashier_app_v2/features/purchases/presentation/bloc/purchase_bloc/purchase_event.dart';
import 'package:cashier_app_v2/features/purchases/presentation/bloc/purchase_bloc/purchase_state.dart';
import 'package:cashier_app_v2/features/purchases/presentation/screen/purchase_invoice_details_screen.dart';

class PurchaseInvoicesScreen extends StatelessWidget {
  const PurchaseInvoicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
      getIt<PurchaseBloc>()..add(const LoadPurchaseInvoicesEvent()),
      child: const _PurchaseInvoicesContent(),
    );
  }
}

class _PurchaseInvoicesContent extends StatefulWidget {
  const _PurchaseInvoicesContent();

  @override
  State<_PurchaseInvoicesContent> createState() =>
      _PurchaseInvoicesContentState();
}

class _PurchaseInvoicesContentState
    extends State<_PurchaseInvoicesContent> {
  final TextEditingController _searchController = TextEditingController();

  String _paymentFilter = 'الكل';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_onSearchChanged)
      ..dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Payment Helpers
  // ---------------------------------------------------------------------------

  String _paymentMethodLabel(String paymentMethod) {
    switch (paymentMethod.trim().toLowerCase()) {
      case 'cash':
      case 'نقد':
      case 'نقدي':
        return 'نقدي';

      case 'credit':
      case 'آجل':
      case 'اجل':
        return 'آجل';

      default:
        return paymentMethod;
    }
  }

  bool _isCashPayment(String paymentMethod) {
    final value = paymentMethod.trim().toLowerCase();
    return value == 'cash' || value == 'نقد' || value == 'نقدي';
  }

  // ---------------------------------------------------------------------------
  // Filtering
  // ---------------------------------------------------------------------------

  List<PurchaseInvoice> _filteredInvoices(
      List<PurchaseInvoice> invoices,
      ) {
    final query = _searchController.text.trim().toLowerCase();

    return invoices.where((invoice) {
      final matchesSearch =
          query.isEmpty ||
              invoice.invoiceNumber.toLowerCase().contains(query) ||
              invoice.supplier.toLowerCase().contains(query);

      final matchesPayment =
          _paymentFilter == 'الكل' ||
              _paymentMethodLabel(invoice.paymentMethod) == _paymentFilter;

      return matchesSearch && matchesPayment;
    }).toList();
  }

  // ---------------------------------------------------------------------------
  // Navigation
  // ---------------------------------------------------------------------------

  void _openDetails(PurchaseInvoice invoice) {
    final purchaseBloc = context.read<PurchaseBloc>();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: purchaseBloc,
          child: PurchaseInvoiceDetailsScreen(
            invoiceId: invoice.id,
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Formatting
  // ---------------------------------------------------------------------------

  String _formatDateTime(DateTime dateTime) {
    final date =
        '${dateTime.day.toString().padLeft(2, '0')}/'
        '${dateTime.month.toString().padLeft(2, '0')}/'
        '${dateTime.year}';

    final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'م' : 'ص';

    return '$date - $hour:$minute $period';
  }

  String _formatMoney(double value) {
    return value
        .toStringAsFixed(2)
        .replaceAll(RegExp(r'\.00$'), '');
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: BlocBuilder<PurchaseBloc, PurchaseState>(
            builder: (context, state) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  final isMobile = constraints.maxWidth < 750;
                  final invoices = _filteredInvoices(state.invoices);

                  return CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: _buildHeader(isMobile),
                      ),
                      SliverToBoxAdapter(
                        child: _buildStats(isMobile, state.invoices),
                      ),
                      SliverToBoxAdapter(
                        child: _buildFilters(isMobile),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.fromLTRB(
                          isMobile ? 16 : 24,
                          0,
                          isMobile ? 16 : 24,
                          24,
                        ),
                        sliver: _buildInvoicesContent(
                          state,
                          invoices,
                          isMobile,
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Content & States
  // ---------------------------------------------------------------------------

  Widget _buildInvoicesContent(
      PurchaseState state,
      List<PurchaseInvoice> invoices,
      bool isMobile,
      ) {
    if (state.status == PurchaseStatus.loading) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.only(top: 80),
          child: Center(
            child: CircularProgressIndicator(
              color: AppColors.gold,
            ),
          ),
        ),
      );
    }

    if (state.status == PurchaseStatus.failure) {
      return SliverToBoxAdapter(
        child: _buildErrorState(state.errorMessage),
      );
    }

    if (invoices.isEmpty) {
      return SliverToBoxAdapter(
        child: _buildEmptyState(),
      );
    }

    return SliverList.separated(
      itemCount: invoices.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return _buildInvoiceCard(invoices[index], isMobile);
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Header
  // ---------------------------------------------------------------------------

  Widget _buildHeader(bool isMobile) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        isMobile ? 16 : 24,
        20,
        isMobile ? 16 : 24,
        20,
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.goldSurface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: AppColors.goldDark,
              ),
            ),
            child: const Icon(
              Icons.receipt_long_rounded,
              color: AppColors.gold,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'فواتير المشتريات',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 4),
                Text(
                  'عرض ومتابعة جميع فواتير التوريد',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          if (!isMobile)
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PurchasesScreen()),
                );
              },
              icon: const Icon(Icons.add_rounded),
              label: const Text('فاتورة جديدة'),
            ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Stats
  // ---------------------------------------------------------------------------

  Widget _buildStats(bool isMobile, List<PurchaseInvoice> invoices) {
    final totalInvoices = invoices.length;

    final totalPurchases = invoices.fold<double>(
      0,
          (sum, invoice) => sum + invoice.netTotal,
    );

    final cashTotal = invoices
        .where((invoice) => _isCashPayment(invoice.paymentMethod))
        .fold<double>(
      0,
          (sum, invoice) => sum + invoice.netTotal,
    );

    final creditTotal = invoices
        .where((invoice) => !_isCashPayment(invoice.paymentMethod))
        .fold<double>(
      0,
          (sum, invoice) => sum + invoice.netTotal,
    );

    final stats = [
      _StatItem(
        title: 'عدد الفواتير',
        value: '$totalInvoices',
        icon: Icons.receipt_long_rounded,
        color: AppColors.gold,
      ),
      _StatItem(
        title: 'إجمالي المشتريات',
        value: '${_formatMoney(totalPurchases)} ج',
        icon: Icons.shopping_cart_rounded,
        color: AppColors.success,
      ),
      _StatItem(
        title: 'نقدي',
        value: '${_formatMoney(cashTotal)} ج',
        icon: Icons.payments_rounded,
        color: AppColors.goldLight,
      ),
      _StatItem(
        title: 'آجل',
        value: '${_formatMoney(creditTotal)} ج',
        icon: Icons.schedule_rounded,
        color: AppColors.warning,
      ),
    ];

    return Padding(
      padding: EdgeInsets.fromLTRB(
        isMobile ? 16 : 24,
        0,
        isMobile ? 16 : 24,
        20,
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: stats.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isMobile ? 2 : 4,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: isMobile ? 1.7 : 2.2,
        ),
        itemBuilder: (_, index) {
          return _buildStatCard(stats[index]);
        },
      ),
    );
  }

  Widget _buildStatCard(_StatItem item) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: item.color.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              item.icon,
              color: item.color,
              size: 21,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  item.value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Filters
  // ---------------------------------------------------------------------------

  Widget _buildFilters(bool isMobile) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        isMobile ? 16 : 24,
        0,
        isMobile ? 16 : 24,
        16,
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.border,
          ),
        ),
        child: isMobile
            ? Column(
          children: [
            _buildSearchField(),
            const SizedBox(height: 10),
            _buildPaymentDropdown(),
          ],
        )
            : Row(
          children: [
            Expanded(
              child: _buildSearchField(),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 180,
              child: _buildPaymentDropdown(),
            ),
            const SizedBox(width: 12),
            _buildFilterButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      decoration: const InputDecoration(
        hintText: 'ابحث برقم الفاتورة أو المورد...',
        prefixIcon: Icon(Icons.search_rounded),
      ),
    );
  }

  Widget _buildPaymentDropdown() {
    return DropdownButtonFormField<String>(
      initialValue: _paymentFilter,
      decoration: const InputDecoration(
        labelText: 'طريقة الدفع',
      ),
      dropdownColor: AppColors.surfaceLight,
      items: const [
        DropdownMenuItem(
          value: 'الكل',
          child: Text('الكل'),
        ),
        DropdownMenuItem(
          value: 'نقدي',
          child: Text('نقدي'),
        ),
        DropdownMenuItem(
          value: 'آجل',
          child: Text('آجل'),
        ),
      ],
      onChanged: (value) {
        if (value == null) return;
        setState(() {
          _paymentFilter = value;
        });
      },
    );
  }

  Widget _buildFilterButton() {
    return IconButton(
      onPressed: () {},
      tooltip: 'الفلاتر',
      icon: const Icon(Icons.tune_rounded),
    );
  }

  // ---------------------------------------------------------------------------
  // Invoice Card
  // ---------------------------------------------------------------------------

  Widget _buildInvoiceCard(PurchaseInvoice invoice, bool isMobile) {
    final isCash = invoice.isCash;
    final isFullyPaid = invoice.isFullyPaid;
    final isPartiallyPaid = invoice.isPartiallyPaid;
    final isCredit = invoice.isCredit;

    return InkWell(
      onTap: () => _openDetails(invoice),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: EdgeInsets.all(isMobile ? 14 : 18),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.border,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppColors.goldSurface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.receipt_long_rounded,
                    color: AppColors.gold,
                    size: 21,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        invoice.invoiceNumber,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        invoice.supplier,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildPaymentBadge(invoice),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(
              color: AppColors.divider,
            ),
            const SizedBox(height: 14),
            isMobile
                ? _buildMobileInvoiceInfo(invoice)
                : _buildDesktopInvoiceInfo(invoice),
            if (isCredit && !isCash && !isFullyPaid) ...[
              const SizedBox(height: 14),
              _buildCreditInfo(
                invoice,
                isPartiallyPaid: isPartiallyPaid,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCreditInfo(
      PurchaseInvoice invoice, {
        required bool isPartiallyPaid,
      }) {
    if (isPartiallyPaid) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: AppColors.warning.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.warning.withValues(alpha: 0.20),
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.payments_outlined,
              color: AppColors.warning,
              size: 18,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'المدفوع: ${_formatMoney(invoice.paidAmount)} ج'
                    '  •  '
                    'المتبقي: ${_formatMoney(invoice.remainingAmount)} ج',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.warning.withValues(alpha: 0.20),
        ),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: AppColors.warning,
            size: 18,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'فاتورة آجلة — افتح التفاصيل لتحصيل المبلغ ومعرفة موعد التحصيل.',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Info Layouts
  // ---------------------------------------------------------------------------

  Widget _buildDesktopInvoiceInfo(PurchaseInvoice invoice) {
    return Row(
      children: [
        Expanded(
          child: _infoItem(
            'التاريخ',
            _formatDateTime(invoice.createdAt),
            Icons.calendar_today_rounded,
          ),
        ),
        Expanded(
          child: _infoItem(
            'الأصناف',
            '${invoice.itemsCount} صنف',
            Icons.inventory_2_outlined,
          ),
        ),
        Expanded(
          child: _infoItem(
            'الإجمالي',
            '${_formatMoney(invoice.total)} ج',
            Icons.calculate_outlined,
          ),
        ),
        Expanded(
          child: _infoItem(
            'الخصم',
            '${_formatMoney(invoice.discount)} ج',
            Icons.discount_outlined,
          ),
        ),
        Expanded(
          child: _infoItem(
            'الصافي',
            '${_formatMoney(invoice.netTotal)} ج',
            Icons.account_balance_wallet_outlined,
            valueColor: AppColors.gold,
          ),
        ),
        const SizedBox(width: 16),
        OutlinedButton.icon(
          onPressed: () => _openDetails(invoice),
          icon: const Icon(
            Icons.arrow_back_rounded,
            size: 18,
          ),
          label: const Text('التفاصيل'),
        ),
      ],
    );
  }

  Widget _buildMobileInvoiceInfo(PurchaseInvoice invoice) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _infoItem(
                'التاريخ',
                _formatDateTime(invoice.createdAt),
                Icons.calendar_today_rounded,
              ),
            ),
            Expanded(
              child: _infoItem(
                'الأصناف',
                '${invoice.itemsCount} صنف',
                Icons.inventory_2_outlined,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: _infoItem(
                'الإجمالي',
                '${_formatMoney(invoice.total)} ج',
                Icons.calculate_outlined,
              ),
            ),
            Expanded(
              child: _infoItem(
                'الخصم',
                '${_formatMoney(invoice.discount)} ج',
                Icons.discount_outlined,
              ),
            ),
            Expanded(
              child: _infoItem(
                'الصافي',
                '${_formatMoney(invoice.netTotal)} ج',
                Icons.account_balance_wallet_outlined,
                valueColor: AppColors.gold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => _openDetails(invoice),
            icon: const Icon(
              Icons.arrow_back_rounded,
              size: 18,
            ),
            label: const Text('عرض تفاصيل الفاتورة'),
          ),
        ),
      ],
    );
  }

  Widget _infoItem(
      String title,
      String value,
      IconData icon, {
        Color valueColor = AppColors.textPrimary,
      }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 17,
          color: AppColors.textSecondary,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.textHint,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: valueColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentBadge(PurchaseInvoice invoice) {
    String label;
    Color color;

    if (invoice.isCash || invoice.isFullyPaid) {
      label = 'تم التحصيل';
      color = AppColors.success;
    } else if (invoice.isPartiallyPaid) {
      label = 'دفع جزئي';
      color = AppColors.warning;
    } else {
      label = 'آجلة';
      color = AppColors.danger;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withValues(alpha: 0.25),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Empty & Error States
  // ---------------------------------------------------------------------------

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 70,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.receipt_long_outlined,
            color: AppColors.textHint,
            size: 54,
          ),
          SizedBox(height: 14),
          Text(
            'لا توجد فواتير',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'لم يتم العثور على فواتير مطابقة للبحث',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String? message) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 50,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: AppColors.danger,
            size: 48,
          ),
          const SizedBox(height: 12),
          const Text(
            'حدث خطأ أثناء تحميل الفواتير',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: 6),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _StatItem {
  const _StatItem({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color color;
}