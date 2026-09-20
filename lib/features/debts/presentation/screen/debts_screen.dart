import 'package:cashier_app_v2/di.dart';
import 'package:cashier_app_v2/features/debts/domain/entities/debt_invoice.dart';
import 'package:cashier_app_v2/features/debts/presentation/bloc/debt_bloc.dart';
import 'package:cashier_app_v2/features/debts/presentation/bloc/debt_event.dart';
import 'package:cashier_app_v2/features/debts/presentation/bloc/debt_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../widgets/debt_invoice_row.dart';
import '../widgets/debt_summary_card.dart';
import '../widgets/debts_header.dart';

class DebtsScreen extends StatefulWidget {
  const DebtsScreen({super.key});

  @override
  State<DebtsScreen> createState() => _DebtsScreenState();
}

class _DebtsScreenState extends State<DebtsScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DebtBloc>()..add(const LoadDebts()),
      child: _DebtsView(
        searchController: searchController,
      ),
    );
  }
}

class _DebtsView extends StatelessWidget {
  final TextEditingController searchController;

  const _DebtsView({
    required this.searchController,
  });

  String money(double value) {
    return '${value.toStringAsFixed(2)} ج';
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: BlocConsumer<DebtBloc, DebtState>(
            listener: (context, state) {
              if (state is DebtError) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
              }
            },
            builder: (context, state) {
              if (state is DebtLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.gold,
                  ),
                );
              }

              if (state is DebtError) {
                return _errorState(context, state.message);
              }

              if (state is DebtLoaded) {
                return _content(context, state);
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Widget _content(
      BuildContext context,
      DebtLoaded state,
      ) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final compact = constraints.maxWidth < 800;

        return SingleChildScrollView(
          padding: EdgeInsets.only(
            top: 12,
            bottom: 24,
            left: compact ? 12 : 28,
            right: compact ? 12 : 28,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DebtsHeader(
                outstanding: money(state.creditRemaining),
              ),
              const SizedBox(height: 16),
              _summary(state, compact),
              const SizedBox(height: 16),
              _filters(context, state, compact),
              const SizedBox(height: 12),
              _table(context, state),
            ],
          ),
        );
      },
    );
  }

  Widget _summary(
      DebtLoaded state,
      bool compact,
      ) {
    final cards = [
      DebtSummaryCard(
        title: 'إجمالي الفواتير',
        amount: money(state.total),
        color: AppColors.gold,
        icon: Icons.receipt_long_outlined,
      ),
      DebtSummaryCard(
        title: 'إجمالي الآجل',
        amount: money(state.creditTotal),
        color: AppColors.warning,
        icon: Icons.schedule_outlined,
      ),
      DebtSummaryCard(
        title: 'تم تحصيله',
        amount: money(state.creditPaid),
        color: AppColors.success,
        icon: Icons.check_circle_outline,
      ),
      DebtSummaryCard(
        title: 'المتبقي',
        amount: money(state.creditRemaining),
        color: AppColors.danger,
        icon: Icons.account_balance_wallet_outlined,
      ),
    ];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: compact ? 1 : 4,
      mainAxisSpacing: 12,
      crossAxisSpacing: 16,
      childAspectRatio: compact ? 4.3 : 2.5,
      children: cards,
    );
  }

  Widget _filters(
      BuildContext context,
      DebtLoaded state,
      bool compact,
      ) {
    final bloc = context.read<DebtBloc>();

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        children: [
          TextField(
            controller: searchController,
            onChanged: (value) {
              bloc.add(SearchDebts(value));
            },
            style: const TextStyle(
              color: AppColors.textPrimary,
            ),
            decoration: InputDecoration(
              hintText: 'بحث برقم الفاتورة أو اسم العميل أو الهاتف',
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.textSecondary,
              ),
              suffixIcon: searchController.text.isNotEmpty
                  ? IconButton(
                onPressed: () {
                  searchController.clear();
                  bloc.add(const SearchDebts(''));
                },
                icon: const Icon(
                  Icons.clear,
                  color: AppColors.textSecondary,
                ),
              )
                  : null,
            ),
          ),
          const SizedBox(height: 14),
          if (compact)
            Column(
              children: [
                _paymentFilter(context, state),
                const SizedBox(height: 10),
                _statusFilter(context, state),
              ],
            )
          else
            Row(
              children: [
                Expanded(
                  child: _paymentFilter(context, state),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _statusFilter(context, state),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _paymentFilter(
      BuildContext context,
      DebtLoaded state,
      ) {
    return DropdownButtonFormField<String>(
      value: state.selectedPaymentFilter,
      decoration: const InputDecoration(
        labelText: 'وسيلة الدفع',
        prefixIcon: Icon(
          Icons.payments_outlined,
          color: AppColors.gold,
        ),
      ),
      dropdownColor: AppColors.surface,
      style: const TextStyle(
        color: AppColors.textPrimary,
      ),
      items: const [
        DropdownMenuItem(
          value: 'الكل',
          child: Text('كل وسائل الدفع'),
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

        context.read<DebtBloc>().add(
          FilterPaymentMethod(value),
        );
      },
    );
  }

  Widget _statusFilter(
      BuildContext context,
      DebtLoaded state,
      ) {
    return DropdownButtonFormField<String>(
      value: state.selectedStatusFilter,
      decoration: const InputDecoration(
        labelText: 'حالة الفاتورة',
        prefixIcon: Icon(
          Icons.filter_alt_outlined,
          color: AppColors.gold,
        ),
      ),
      dropdownColor: AppColors.surface,
      style: const TextStyle(
        color: AppColors.textPrimary,
      ),
      items: const [
        DropdownMenuItem(
          value: 'الكل',
          child: Text('كل الحالات'),
        ),
        DropdownMenuItem(
          value: 'محصل',
          child: Text('محصل'),
        ),
        DropdownMenuItem(
          value: 'جزئي',
          child: Text('جزئي'),
        ),
        DropdownMenuItem(
          value: 'غير محصل',
          child: Text('غير محصل'),
        ),
      ],
      onChanged: (value) {
        if (value == null) return;

        context.read<DebtBloc>().add(
          FilterDebtStatus(value),
        );
      },
    );
  }

  Widget _table(
      BuildContext context,
      DebtLoaded state,
      ) {
    const double tableMinWidth = 1150;

    final invoices = state.filteredInvoices;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final actualWidth = constraints.maxWidth > tableMinWidth
              ? constraints.maxWidth
              : tableMinWidth;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: actualWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _tableHeader(),
                  if (invoices.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(32),
                      child: Center(
                        child: Text(
                          'لا توجد فواتير مطابقة',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    )
                  else
                    ...invoices.map(
                          (invoice) => DebtInvoiceRow(
                        invoice: invoice,
                        onView: () {
                          _showDebtActions(
                            context,
                            invoice,
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _tableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 16,
      ),
      color: AppColors.surfaceLight,
      child: const Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              'رقم الفاتورة',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: 120,
            child: Text(
              'التاريخ',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'العميل',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: 100,
            child: Text(
              'وسيلة الدفع',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: 100,
            child: Text(
              'الإجمالي',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: 100,
            child: Text(
              'المدفوع',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: 100,
            child: Text(
              'المتبقي',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: 110,
            child: Text(
              'الحالة',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: 70,
            child: Text(''),
          ),
        ],
      ),
    );
  }

  Widget _errorState(
      BuildContext context,
      String message,
      ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
              color: AppColors.danger,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<DebtBloc>().add(
                  const LoadDebts(),
                );
              },
              child: const Text('إعادة المحاولة'),
            ),
          ],
        ),
      ),
    );
  }

  void _showDebtActions(
      BuildContext context,
      DebtInvoice invoice,
      ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      builder: (_) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    invoice.invoiceNumber,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    invoice.customerName,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'وسيلة الدفع: ${_paymentMethodText(invoice.paymentMethod)}',
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (invoice.isCredit && !invoice.isCash)
                    ListTile(
                      leading: const Icon(
                        Icons.payments_outlined,
                        color: AppColors.success,
                      ),
                      title: const Text(
                        'تحصيل دفعة',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      subtitle: Text(
                        'المتبقي: ${money(invoice.remaining)}',
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        _showPaymentDialog(
                          context,
                          invoice,
                        );
                      },
                    )
                  else
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                      child: Text(
                        'لا توجد إجراءات متاحة لهذه الفاتورة',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showPaymentDialog(
      BuildContext context,
      DebtInvoice invoice,
      ) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            backgroundColor: AppColors.surface,
            title: const Text(
              'تحصيل دفعة',
              style: TextStyle(
                color: AppColors.textPrimary,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'المتبقي: ${money(invoice.remaining)}',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: controller,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  autofocus: true,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'المبلغ',
                    hintText: 'أدخل مبلغ التحصيل',
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  controller.dispose();
                  Navigator.pop(dialogContext);
                },
                child: const Text('إلغاء'),
              ),
              ElevatedButton(
                onPressed: () {
                  final amount = double.tryParse(
                    controller.text.trim(),
                  );

                  if (amount == null || amount <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'أدخل مبلغًا صحيحًا',
                        ),
                      ),
                    );
                    return;
                  }

                  if (amount > invoice.remaining + 0.01) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'المبلغ أكبر من المتبقي',
                        ),
                      ),
                    );
                    return;
                  }

                  context.read<DebtBloc>().add(
                    PayDebtEvent(
                      invoiceId: invoice.id,
                      amount: amount,
                    ),
                  );

                  controller.dispose();
                  Navigator.pop(dialogContext);
                },
                child: const Text('تحصيل'),
              ),
            ],
          ),
        );
      },
    );
  }

  String _paymentMethodText(String method) {
    switch (method) {
      case 'credit':
        return 'آجل';
      case 'cash':
        return 'نقدي';
      default:
        return method;
    }
  }
}