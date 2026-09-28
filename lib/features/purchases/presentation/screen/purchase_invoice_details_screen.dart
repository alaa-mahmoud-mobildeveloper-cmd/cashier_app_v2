import 'package:cashier_app_v2/features/purchases/domian/entities/details_invoice.dart';
import 'package:cashier_app_v2/features/purchases/presentation/bloc/purchase_bloc/purchase_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cashier_app_v2/core/constants/app_colors.dart';
import 'package:cashier_app_v2/di.dart';

import '../bloc/purchase_bloc/purchase_bloc.dart';
import '../bloc/purchase_bloc/purchase_event.dart';

class PurchaseInvoiceDetailsScreen extends StatelessWidget {
  const PurchaseInvoiceDetailsScreen({
    super.key,
    required this.invoiceId,
  });

  final int invoiceId;

  @override
  Widget build(BuildContext context) {
    final hasBloc = context.read<PurchaseBloc?>() != null;

    if (hasBloc) {
      return _PurchaseInvoiceDetailsView(invoiceId: invoiceId);
    }

    return BlocProvider(
      create: (_) => getIt<PurchaseBloc>()
        ..add(
          LoadPurchaseInvoiceDetailsEvent(invoiceId),
        ),
      child: _PurchaseInvoiceDetailsView(invoiceId: invoiceId),
    );
  }
}

class _PurchaseInvoiceDetailsView extends StatefulWidget {
  const _PurchaseInvoiceDetailsView({
    required this.invoiceId,
  });

  final int invoiceId;

  @override
  State<_PurchaseInvoiceDetailsView> createState() =>
      _PurchaseInvoiceDetailsViewState();
}

class _PurchaseInvoiceDetailsViewState
    extends State<_PurchaseInvoiceDetailsView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PurchaseBloc>().add(
        LoadPurchaseInvoiceDetailsEvent(widget.invoiceId),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: _buildAppBar(),
        body: BlocConsumer<PurchaseBloc, PurchaseState>(
          listener: (context, state) {
            if (state.status == PurchaseStatus.failure &&
                state.invoiceDetails != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.errorMessage ?? 'حدث خطأ أثناء التحصيل',
                  ),
                  backgroundColor: AppColors.danger,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state.status == PurchaseStatus.loading &&
                state.invoiceDetails == null) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.gold,
                ),
              );
            }

            if (state.status == PurchaseStatus.failure &&
                state.invoiceDetails == null) {
              return _buildErrorState(state.errorMessage);
            }

            final invoice = state.invoiceDetails;

            if (invoice == null) {
              return _buildEmptyState();
            }

            return _buildContent(invoice);
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('تفاصيل فاتورة المشتريات'),
      actions: [
        IconButton(
          tooltip: 'طباعة',
          onPressed: () {},
          icon: const Icon(Icons.print_outlined),
        ),
        IconButton(
          tooltip: 'المزيد',
          onPressed: () {},
          icon: const Icon(Icons.more_vert_rounded),
        ),
      ],
    );
  }

  Widget _buildContent(
      PurchaseInvoiceDetails invoice,
      ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 850;

        return SingleChildScrollView(
          padding: EdgeInsets.all(isMobile ? 16 : 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildInvoiceHeader(invoice, isMobile),
              const SizedBox(height: 16),
              _buildSummary(invoice, isMobile),
              const SizedBox(height: 16),
              if (invoice.isCredit) ...[
                _buildCreditCard(invoice, isMobile),
                const SizedBox(height: 16),
              ],
              _buildItemsCard(invoice, isMobile),
              const SizedBox(height: 16),
              _buildBottomSummary(invoice, isMobile),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInvoiceHeader(
      PurchaseInvoiceDetails invoice,
      bool isMobile,
      ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: isMobile
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _invoiceTitle(invoice),
          const SizedBox(height: 18),
          _headerInfoGrid(invoice),
        ],
      )
          : Row(
        children: [
          Expanded(
            child: _invoiceTitle(invoice),
          ),
          _headerInfoGrid(invoice),
        ],
      ),
    );
  }

  Widget _invoiceTitle(PurchaseInvoiceDetails invoice) {
    return Row(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.goldSurface,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(
            Icons.receipt_long_rounded,
            color: AppColors.gold,
            size: 25,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                invoice.invoiceNumber,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                invoice.supplierName,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        _statusBadge(invoice),
      ],
    );
  }

  Widget _headerInfoGrid(PurchaseInvoiceDetails invoice) {
    return Wrap(
      spacing: 28,
      runSpacing: 12,
      children: [
        _headerInfo(
          Icons.calendar_today_outlined,
          'التاريخ',
          _formatDate(invoice.createdAt),
        ),
        _headerInfo(
          Icons.access_time_rounded,
          'الوقت',
          _formatTime(invoice.createdAt),
        ),
        _headerInfo(
          Icons.person_outline_rounded,
          'المورد',
          invoice.supplierName,
        ),
      ],
    );
  }

  Widget _headerInfo(
      IconData icon,
      String title,
      String value,
      ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: AppColors.textSecondary,
          size: 18,
        ),
        const SizedBox(width: 7),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: AppColors.textHint,
                fontSize: 10,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _statusBadge(PurchaseInvoiceDetails invoice) {
    final Color color;
    final IconData icon;

    if (invoice.isFullyPaid) {
      color = AppColors.success;
      icon = Icons.check_circle_outline_rounded;
    } else if (invoice.paidAmount > 0) {
      color = AppColors.gold;
      icon = Icons.payments_outlined;
    } else {
      color = AppColors.warning;
      icon = Icons.schedule_rounded;
    }

    final title = invoice.isFullyPaid
        ? 'تم التحصيل'
        : invoice.paidAmount > 0
        ? 'دفع جزئي'
        : 'آجلة';

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color,
            size: 16,
          ),
          const SizedBox(width: 5),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummary(
      PurchaseInvoiceDetails invoice,
      bool isMobile,
      ) {
    final items = [
      _SummaryItem(
        'الإجمالي',
        _money(invoice.total),
        Icons.calculate_outlined,
      ),
      _SummaryItem(
        'الخصم',
        _money(invoice.discount),
        Icons.discount_outlined,
      ),
      _SummaryItem(
        'الضريبة',
        _money(invoice.tax),
        Icons.percent_rounded,
      ),
      _SummaryItem(
        'الصافي',
        _money(invoice.netTotal),
        Icons.account_balance_wallet_outlined,
        color: AppColors.gold,
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isMobile ? 2 : 4,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: isMobile ? 2.1 : 3,
        ),
        itemBuilder: (_, index) {
          final item = items[index];

          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.divider),
            ),
            child: Row(
              children: [
                Icon(
                  item.icon,
                  color: item.color,
                  size: 20,
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          color: AppColors.textHint,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '${item.value} ج',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: item.color,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCreditCard(
      PurchaseInvoiceDetails invoice,
      bool isMobile,
      ) {
    final canCollect = invoice.remainingAmount > 0.01;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: invoice.isFullyPaid
              ? AppColors.success
              : AppColors.goldDark,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: invoice.isFullyPaid
                      ? AppColors.success.withValues(alpha: 0.12)
                      : AppColors.goldSurface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  invoice.isFullyPaid
                      ? Icons.check_circle_outline_rounded
                      : Icons.account_balance_wallet_outlined,
                  color: invoice.isFullyPaid
                      ? AppColors.success
                      : AppColors.gold,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'حساب المورد',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      invoice.isFullyPaid
                          ? 'تم تحصيل قيمة الفاتورة بالكامل'
                          : 'متابعة المدفوع والمتبقي وموعد التحصيل',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton.icon(
                onPressed: canCollect
                    ? () => _showCollectPaymentDialog(invoice)
                    : null,
                icon: const Icon(
                  Icons.payments_outlined,
                  size: 18,
                ),
                label: Text(
                  invoice.isFullyPaid ? 'تم التحصيل' : 'تحصيل',
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Divider(color: AppColors.divider),
          const SizedBox(height: 14),
          if (isMobile)
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _creditAmount(
                        'قيمة الفاتورة',
                        invoice.netTotal,
                        AppColors.textPrimary,
                      ),
                    ),
                    Expanded(
                      child: _creditAmount(
                        'المدفوع',
                        invoice.paidAmount,
                        AppColors.success,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _creditAmount(
                        'المتبقي',
                        invoice.remainingAmount,
                        AppColors.danger,
                      ),
                    ),
                    if (invoice.dueDate != null)
                      Expanded(
                        child: _creditAmount(
                          'موعد التحصيل',
                          0,
                          AppColors.warning,
                          valueText: _formatDate(invoice.dueDate!),
                        ),
                      ),
                  ],
                ),
              ],
            )
          else
            Row(
              children: [
                Expanded(
                  child: _creditAmount(
                    'قيمة الفاتورة',
                    invoice.netTotal,
                    AppColors.textPrimary,
                  ),
                ),
                Expanded(
                  child: _creditAmount(
                    'المدفوع',
                    invoice.paidAmount,
                    AppColors.success,
                  ),
                ),
                Expanded(
                  child: _creditAmount(
                    'المتبقي',
                    invoice.remainingAmount,
                    AppColors.danger,
                  ),
                ),
                if (invoice.dueDate != null)
                  Expanded(
                    child: _creditAmount(
                      'موعد التحصيل',
                      0,
                      AppColors.warning,
                      valueText: _formatDate(invoice.dueDate!),
                    ),
                  ),
              ],
            ),
          if (invoice.payments.isNotEmpty) ...[
            const SizedBox(height: 18),
            _buildPaymentsHistory(invoice),
          ],
        ],
      ),
    );
  }

  Widget _creditAmount(
      String title,
      double amount,
      Color color, {
        String? valueText,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          valueText ?? '${_money(amount)} ج',
          style: TextStyle(
            color: color,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentsHistory(
      PurchaseInvoiceDetails invoice,
      ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'سجل التحصيل',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ...invoice.payments.map(
                (payment) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  const Icon(
                    Icons.payments_outlined,
                    color: AppColors.success,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _formatDate(payment.createdAt),
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  Text(
                    '${_money(payment.amount)} ج',
                    style: const TextStyle(
                      color: AppColors.success,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showCollectPaymentDialog(
      PurchaseInvoiceDetails invoice,
      ) async {
    final controller = TextEditingController(
      text: _money(invoice.remainingAmount),
    );

    final amount = await showDialog<double>(
      context: context,
      builder: (dialogContext) {
        String? errorText;

        return StatefulBuilder(
          builder: (context, setState) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: AlertDialog(
                backgroundColor: AppColors.card,
                title: const Text(
                  'تحصيل من المورد',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                  ),
                ),
                content: SizedBox(
                  width: 380,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _dialogInfoRow(
                        'المتبقي',
                        '${_money(invoice.remainingAmount)} ج',
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: controller,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                        ),
                        decoration: InputDecoration(
                          labelText: 'مبلغ التحصيل',
                          suffixText: 'ج',
                          errorText: errorText,
                        ),
                        onChanged: (_) {
                          if (errorText != null) {
                            setState(() {
                              errorText = null;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(dialogContext);
                    },
                    child: const Text('إلغاء'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      final value = double.tryParse(
                        controller.text.trim(),
                      );

                      if (value == null || value <= 0) {
                        setState(() {
                          errorText =
                          'أدخل مبلغًا صحيحًا';
                        });
                        return;
                      }

                      if (value >
                          invoice.remainingAmount + 0.01) {
                        setState(() {
                          errorText =
                          'المبلغ أكبر من المتبقي';
                        });
                        return;
                      }

                      Navigator.pop(dialogContext, value);
                    },
                    icon: const Icon(
                      Icons.check_rounded,
                      size: 18,
                    ),
                    label: const Text('تحصيل'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );

    controller.dispose();

    if (!mounted || amount == null) {
      return;
    }

    context.read<PurchaseBloc>().add(
      CollectPurchasePaymentEvent(
        invoiceId: invoice.id,
        amount: amount,
        paymentMethod: 'cash',
      ),
    );
  }

  Widget _dialogInfoRow(
      String title,
      String value,
      ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textSecondary,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.gold,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsCard(
      PurchaseInvoiceDetails invoice,
      bool isMobile,
      ) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                const Icon(
                  Icons.inventory_2_outlined,
                  color: AppColors.gold,
                ),
                const SizedBox(width: 9),
                const Text(
                  'أصناف الفاتورة',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  '${invoice.items.length} أصناف',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: AppColors.divider,
            height: 1,
          ),
          if (isMobile)
            ...invoice.items.map(_buildMobileItem)
          else
            _buildDesktopItemsTable(invoice),
        ],
      ),
    );
  }

  Widget _buildDesktopItemsTable(
      PurchaseInvoiceDetails invoice,
      ) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor:
        const WidgetStatePropertyAll(AppColors.surface),
        columnSpacing: 28,
        columns: const [
          DataColumn(label: Text('الصنف')),
          DataColumn(label: Text('الكرتونة')),
          DataColumn(label: Text('الوحدات')),
          DataColumn(label: Text('سعر الكرتونة')),
          DataColumn(label: Text('سعر الوحدة')),
          DataColumn(label: Text('سعر البيع')),
          DataColumn(label: Text('الإجمالي')),
        ],
        rows: invoice.items.map((item) {
          return DataRow(
            cells: [
              DataCell(
                SizedBox(
                  width: 150,
                  child: Text(
                    item.productName,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              DataCell(
                Text(_number(item.cartonQuantity)),
              ),
              DataCell(
                Text(_number(item.units)),
              ),
              DataCell(
                Text('${_money(item.purchasePrice)} ج'),
              ),
              DataCell(
                Text('${_money(item.unitPurchasePrice)} ج'),
              ),
              DataCell(
                Text('${_money(item.salePrice)} ج'),
              ),
              DataCell(
                Text(
                  '${_money(item.total)} ج',
                  style: const TextStyle(
                    color: AppColors.gold,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMobileItem(
      PurchaseInvoiceItem item,
      ) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.productName,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (item.barcode.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        item.barcode,
                        style: const TextStyle(
                          color: AppColors.textHint,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Text(
                '${_money(item.total)} ج',
                style: const TextStyle(
                  color: AppColors.gold,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _mobileItemInfo(
                  'الكرتونة',
                  _number(item.cartonQuantity),
                ),
              ),
              Expanded(
                child: _mobileItemInfo(
                  'الوحدات',
                  _number(item.units),
                ),
              ),
              Expanded(
                child: _mobileItemInfo(
                  'سعر الكرتونة',
                  '${_money(item.purchasePrice)} ج',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _mobileItemInfo(
                  'سعر الوحدة',
                  '${_money(item.unitPurchasePrice)} ج',
                ),
              ),
              Expanded(
                child: _mobileItemInfo(
                  'سعر البيع',
                  '${_money(item.salePrice)} ج',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _mobileItemInfo(
      String title,
      String value,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.textHint,
            fontSize: 10,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSummary(
      PurchaseInvoiceDetails invoice,
      bool isMobile,
      ) {
    final summary = Column(
      children: [
        _summaryLine(
          'الإجمالي',
          invoice.total,
        ),
        _summaryLine(
          'الخصم',
          -invoice.discount,
        ),
        _summaryLine(
          'الضريبة',
          invoice.tax,
        ),
        const Divider(color: AppColors.divider),
        _summaryLine(
          'الصافي',
          invoice.netTotal,
          valueColor: AppColors.gold,
          large: true,
        ),
      ],
    );

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: isMobile
          ? summary
          : Row(
        children: [
          const Spacer(),
          SizedBox(
            width: 300,
            child: summary,
          ),
        ],
      ),
    );
  }

  Widget _summaryLine(
      String title,
      double value, {
        Color valueColor = AppColors.textPrimary,
        bool large = false,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: large
                  ? AppColors.textPrimary
                  : AppColors.textSecondary,
              fontSize: large ? 15 : 13,
              fontWeight:
              large ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const Spacer(),
          Text(
            '${_money(value)} ج',
            style: TextStyle(
              color: valueColor,
              fontSize: large ? 19 : 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Text(
        'الفاتورة غير موجودة',
        style: TextStyle(
          color: AppColors.textSecondary,
        ),
      ),
    );
  }

  Widget _buildErrorState(String? message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: AppColors.danger,
              size: 50,
            ),
            const SizedBox(height: 12),
            const Text(
              'حدث خطأ أثناء تحميل الفاتورة',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (message != null) ...[
              const SizedBox(height: 8),
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
      ),
    );
  }

  String _formatDate(DateTime dateTime) {
    return '${dateTime.day.toString().padLeft(2, '0')}/'
        '${dateTime.month.toString().padLeft(2, '0')}/'
        '${dateTime.year}';
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour % 12 == 0
        ? 12
        : dateTime.hour % 12;

    final minute =
    dateTime.minute.toString().padLeft(2, '0');

    final period = dateTime.hour >= 12 ? 'م' : 'ص';

    return '$hour:$minute $period';
  }

  String _number(double value) {
    if (value == value.roundToDouble()) {
      return value.toInt().toString();
    }

    return value.toString();
  }

  String _money(double value) {
    return value
        .toStringAsFixed(2)
        .replaceAll(RegExp(r'\.00$'), '');
  }
}

class _SummaryItem {
  const _SummaryItem(
      this.title,
      this.value,
      this.icon, {
        this.color = AppColors.textPrimary,
      });

  final String title;
  final String value;
  final IconData icon;
  final Color color;
}