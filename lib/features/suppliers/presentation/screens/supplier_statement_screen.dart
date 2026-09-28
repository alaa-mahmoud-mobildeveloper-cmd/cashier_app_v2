import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cashier_app_v2/core/constants/app_colors.dart';
import 'package:cashier_app_v2/di.dart';
import 'package:cashier_app_v2/features/suppliers/domain/entities/supplier_transaction.dart';
import 'package:cashier_app_v2/features/suppliers/domain/entities/supplier_ui.dart';
import 'package:cashier_app_v2/features/suppliers/presentation/bloc/supplier_statement_bloc/supplier_statement_bloc.dart';
import 'package:cashier_app_v2/features/suppliers/presentation/bloc/supplier_statement_bloc/supplier_statement_event.dart';
import 'package:cashier_app_v2/features/suppliers/presentation/bloc/supplier_statement_bloc/supplier_statement_state.dart';
import 'package:cashier_app_v2/features/suppliers/presentation/widgets/supplier_debt_summary.dart';
import 'package:cashier_app_v2/features/suppliers/presentation/widgets/supplier_transaction_tile.dart';

class SupplierStatementScreen extends StatelessWidget {
  final SupplierUi supplier;

  const SupplierStatementScreen({
    super.key,
    required this.supplier,
  });

  int? get supplierId => int.tryParse(supplier.id);

  @override
  Widget build(BuildContext context) {
    final id = supplierId;

    if (id == null) {
      return const Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: Center(
            child: Text(
              'رقم المورد غير صالح',
              style: TextStyle(
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ),
      );
    }

    return BlocProvider(
      create: (_) => getIt<SupplierStatementBloc>()
        ..add(
          WatchSupplierStatementEvent(id),
        ),
      child: _SupplierStatementView(
        supplier: supplier,
        supplierId: id,
      ),
    );
  }
}

class _SupplierStatementView extends StatelessWidget {
  final SupplierUi supplier;
  final int supplierId;

  const _SupplierStatementView({
    required this.supplier,
    required this.supplierId,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(supplier.name),
        ),
        body: BlocConsumer<SupplierStatementBloc, SupplierStatementState>(
          listener: (context, state) {
            if (state.status == SupplierStatementStatus.failure &&
                state.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage!),
                  backgroundColor: AppColors.danger,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state.status == SupplierStatementStatus.loading &&
                state.transactions.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.gold,
                ),
              );
            }

            if (state.status == SupplierStatementStatus.failure &&
                state.transactions.isEmpty) {
              return _ErrorView(
                message:
                state.errorMessage ?? 'حدث خطأ أثناء تحميل كشف الحساب',
                onRetry: () {
                  context.read<SupplierStatementBloc>().add(
                    WatchSupplierStatementEvent(supplierId),
                  );
                },
              );
            }

            return RefreshIndicator(
              color: AppColors.gold,
              backgroundColor: AppColors.surface,
              onRefresh: () async {
                context.read<SupplierStatementBloc>().add(
                  WatchSupplierStatementEvent(supplierId),
                );
              },
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        SupplierDebtSummary(
                          totalAmount: state.totalAmount,
                          totalCollected: state.totalCollected,
                          totalDue: state.totalDue,
                        ),
                        const SizedBox(height: 18),
                        const Text(
                          'عمليات توريد البضاعة',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 10),
                      ]),
                    ),
                  ),
                  if (state.transactions.isEmpty)
                    const SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverToBoxAdapter(
                        child: _EmptyTransactions(),
                      ),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (context, index) {
                            final transaction = state.transactions[index];

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: SupplierTransactionTile(
                                transaction: transaction,
                                onCollect: transaction.dueAmount > 0.01
                                    ? () => _collect(
                                  context,
                                  transaction,
                                )
                                    : null,
                              ),
                            );
                          },
                          childCount: state.transactions.length,
                        ),
                      ),
                    ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 16),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _collect(
      BuildContext context,
      SupplierTransaction transaction,
      ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return _CollectSheet(
          transaction: transaction,
          onSubmit: ({
            required double amount,
            required String paymentMethod,
            String? note,
          }) {
            context.read<SupplierStatementBloc>().add(
              CollectPurchasePaymentEvent(
                purchaseId: transaction.purchaseId,
                amount: amount,
                paymentMethod: paymentMethod,
                note: note,
              ),
            );
          },
        );
      },
    );
  }
}

class _CollectSheet extends StatefulWidget {
  final SupplierTransaction transaction;

  final void Function({
  required double amount,
  required String paymentMethod,
  String? note,
  }) onSubmit;

  const _CollectSheet({
    required this.transaction,
    required this.onSubmit,
  });

  @override
  State<_CollectSheet> createState() => _CollectSheetState();
}

class _CollectSheetState extends State<_CollectSheet> {
  late final TextEditingController _amountController;
  late final TextEditingController _noteController;

  String _paymentMethod = 'cash';

  @override
  void initState() {
    super.initState();

    _amountController = TextEditingController(
      text: widget.transaction.dueAmount.toStringAsFixed(2),
    );

    _noteController = TextEditingController();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _submit() {
    final amount = double.tryParse(
      _amountController.text.trim().replaceAll(',', '.'),
    );

    if (amount == null || amount <= 0) {
      _showError('أدخل مبلغ تحصيل صحيح');
      return;
    }

    if (amount > widget.transaction.dueAmount + 0.01) {
      _showError(
        'المبلغ أكبر من المتبقي '
            '${widget.transaction.dueAmount.toStringAsFixed(2)} ج.م',
      );
      return;
    }

    widget.onSubmit(
      amount: amount,
      paymentMethod: _paymentMethod,
      note: _noteController.text.trim().isEmpty
          ? null
          : _noteController.text.trim(),
    );

    Navigator.pop(context);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.danger,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
            border: Border(
              top: BorderSide(
                color: AppColors.border,
              ),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(
            20,
            12,
            20,
            20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: AppColors.borderLight,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const Text(
                'تسجيل تحصيل',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'الفاتورة: ${widget.transaction.invoiceNumber}',
                style: const TextStyle(
                  color: AppColors.textHint,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'المتبقي: '
                    '${widget.transaction.dueAmount.toStringAsFixed(2)} ج.م',
                style: const TextStyle(
                  color: AppColors.gold,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _amountController,
                autofocus: true,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                style: const TextStyle(
                  color: AppColors.textPrimary,
                ),
                decoration: const InputDecoration(
                  labelText: 'المبلغ المحصّل',
                  prefixIcon: Icon(
                    Icons.payments_outlined,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _paymentMethod,
                dropdownColor: AppColors.surface,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                ),
                decoration: const InputDecoration(
                  labelText: 'طريقة الدفع',
                  prefixIcon: Icon(
                    Icons.account_balance_wallet_outlined,
                  ),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'cash',
                    child: Text('نقدي'),
                  ),
                  DropdownMenuItem(
                    value: 'visa',
                    child: Text('فيزا'),
                  ),
                  DropdownMenuItem(
                    value: 'fawry',
                    child: Text('فوري'),
                  ),
                ],
                onChanged: (value) {
                  if (value == null) return;

                  setState(() {
                    _paymentMethod = value;
                  });
                },
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _noteController,
                maxLines: 2,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                ),
                decoration: const InputDecoration(
                  labelText: 'ملاحظة',
                  prefixIcon: Icon(
                    Icons.notes_outlined,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('إلغاء'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: _submit,
                      child: const Text('تأكيد التحصيل'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyTransactions extends StatelessWidget {
  const _EmptyTransactions();

  @override
  Widget build(BuildContext context) {
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
      child: const Column(
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 48,
            color: AppColors.textHint,
          ),
          SizedBox(height: 12),
          Text(
            'لا توجد عمليات توريد لهذا المورد',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
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
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('إعادة المحاولة'),
            ),
          ],
        ),
      ),
    );
  }
}