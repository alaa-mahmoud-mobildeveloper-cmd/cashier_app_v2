import 'package:cashier_app_v2/core/constants/app_colors.dart';
import 'package:cashier_app_v2/core/database/app_database.dart';
import 'package:cashier_app_v2/di.dart';
import 'package:cashier_app_v2/features/auth/domain/session_provider.dart';
import 'package:cashier_app_v2/features/payment_accounts/data/payment_account_repository.dart';
import 'package:cashier_app_v2/features/payment_accounts/domain/payment_account.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;

class PaymentAccountsScreen extends StatefulWidget {
  const PaymentAccountsScreen({super.key});

  @override
  State<PaymentAccountsScreen> createState() => _PaymentAccountsScreenState();
}

class _PaymentAccountsScreenState extends State<PaymentAccountsScreen> {
  late final PaymentAccountRepository _repository;
  late final Stream<List<PaymentAccountSummary>> _summaries;

  @override
  void initState() {
    super.initState();
    _repository = PaymentAccountRepository(getIt<AppDatabase>());
    _summaries = _repository.watchSummaries();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.account_balance_wallet_outlined,
                      color: AppColors.gold,
                      size: 28,
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'المحافظ والفيزا وفوري',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    FilledButton.icon(
                      onPressed: _addAccount,
                      icon: const Icon(Icons.add),
                      label: const Text('إضافة حساب'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'أدر حسابات المحافظ والفيزا وفوري، وتابع التحصيلات والحركات.',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: StreamBuilder<List<PaymentAccountSummary>>(
                    stream: _summaries,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'تعذر تحميل الحسابات: ${snapshot.error}',
                            style: const TextStyle(color: AppColors.danger),
                          ),
                        );
                      }
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.gold,
                          ),
                        );
                      }

                      final accounts = snapshot.data!;
                      if (accounts.isEmpty) {
                        return const Center(
                          child: Text(
                            'لا توجد حسابات بعد. أضف محفظة أو حساب فيزا أو فوري للبدء.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                        );
                      }

                      return ListView.separated(
                        itemCount: accounts.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, index) =>
                            _accountCard(accounts[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _accountCard(PaymentAccountSummary account) {
    final isWallet = account.type == PaymentAccountType.wallet.name;
    return Card(
      color: AppColors.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.goldSurface,
                  child: Icon(
                    isWallet
                        ? Icons.wallet_outlined
                        : account.type == PaymentAccountType.fawry.name
                        ? Icons.qr_code_2_outlined
                        : Icons.credit_card,
                    color: AppColors.gold,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        account.name,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        [
                          account.typeLabel,
                          if (account.provider?.isNotEmpty ?? false)
                            account.provider!,
                          if (account.reference?.isNotEmpty ?? false)
                            account.reference!,
                        ].join(' • '),
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'history') {
                      _showHistory(account);
                    } else {
                      _toggleAccount(account);
                    }
                  },
                  itemBuilder: (_) => [
                    const PopupMenuItem(
                      value: 'history',
                      child: Text('سجل الحركات'),
                    ),
                    PopupMenuItem(
                      value: 'toggle',
                      child: Text(
                        account.isActive ? 'إيقاف الحساب' : 'تفعيل الحساب',
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(height: 22, color: AppColors.divider),
            Row(
              children: [
                Expanded(
                  child: _summaryValue(
                    'الرصيد الحالي',
                    '${account.balance.toStringAsFixed(2)} ج',
                    AppColors.goldLight,
                  ),
                ),
                Expanded(
                  child: _summaryValue(
                    'عدد الحركات',
                    '${account.transactionCount}',
                    AppColors.textPrimary,
                  ),
                ),
                Text(
                  account.isActive ? 'نشط' : 'متوقف',
                  style: TextStyle(
                    color: account.isActive
                        ? AppColors.success
                        : AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: account.isActive
                        ? () => _adjustPaymentAccountBalance(
                            account,
                            isDeposit: true,
                          )
                        : null,
                    icon: const Icon(Icons.add_circle_outline),
                    label: const Text('إيداع'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: account.isActive
                        ? () => _adjustPaymentAccountBalance(
                            account,
                            isDeposit: false,
                          )
                        : null,
                    icon: const Icon(Icons.remove_circle_outline),
                    label: const Text('سحب'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryValue(String label, String value, Color valueColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(color: valueColor, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Future<void> _addAccount() async {
    final result = await showDialog<_AccountFormResult>(
      context: context,
      builder: (_) => const _AccountFormDialog(),
    );
    if (result == null) return;

    try {
      await _repository.addAccount(
        type: result.type,
        name: result.name,
        provider: result.provider,
        reference: result.reference,
        openingBalance: result.openingBalance,
        userId: getIt<SessionProvider>().currentUserId,
      );
      if (mounted) _showMessage('تمت إضافة الحساب');
    } catch (error) {
      if (mounted) _showMessage('تعذرت إضافة الحساب: $error', isError: true);
    }
  }

  Future<void> _adjustPaymentAccountBalance(
    PaymentAccountSummary account, {
    required bool isDeposit,
  }) async {
    final result = await showDialog<_BalanceAdjustmentResult>(
      context: context,
      builder: (_) => _BalanceAdjustmentDialog(
        accountName: account.name,
        currentBalance: account.balance,
        isDeposit: isDeposit,
      ),
    );
    if (result == null) return;

    try {
      final userId = getIt<SessionProvider>().currentUserId;
      if (isDeposit) {
        await _repository.recordDeposit(
          accountId: account.id,
          userId: userId,
          amount: result.amount,
          note: result.note,
        );
      } else {
        await _repository.recordWithdrawal(
          accountId: account.id,
          userId: userId,
          amount: result.amount,
          note: result.note,
        );
      }
      if (mounted) {
        _showMessage(isDeposit ? 'تم تسجيل الإيداع' : 'تم تسجيل السحب');
      }
    } catch (error) {
      if (mounted) {
        _showMessage('تعذر تسجيل الحركة: $error', isError: true);
      }
    }
  }

  Future<void> _toggleAccount(PaymentAccountSummary account) async {
    try {
      await _repository.setAccountActive(
        accountId: account.id,
        isActive: !account.isActive,
      );
      if (mounted) {
        _showMessage(account.isActive ? 'تم إيقاف الحساب' : 'تم تفعيل الحساب');
      }
    } catch (error) {
      if (mounted) _showMessage('تعذر تحديث الحساب: $error', isError: true);
    }
  }

  void _showHistory(PaymentAccountSummary account) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.72,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'حركات ${account.name}',
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: StreamBuilder<List<PaymentAccountEntry>>(
                      stream: _repository.watchEntries(account.id),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              'تعذر تحميل الحركات: ${snapshot.error}',
                            ),
                          );
                        }
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.gold,
                            ),
                          );
                        }
                        final entries = snapshot.data!;
                        if (entries.isEmpty) {
                          return const Center(
                            child: Text(
                              'لا توجد حركات مسجلة لهذا الحساب بعد.',
                              style: TextStyle(color: AppColors.textSecondary),
                            ),
                          );
                        }
                        return ListView.separated(
                          itemCount: entries.length,
                          separatorBuilder: (_, __) => const Divider(
                            color: AppColors.divider,
                            height: 1,
                          ),
                          itemBuilder: (_, index) {
                            final entry = entries[index];
                            final decreasesBalance = entry.decreasesBalance;
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Icon(
                                entry.kind == 'withdrawal'
                                    ? Icons.call_made_outlined
                                    : entry.isRefund
                                    ? Icons.undo_outlined
                                    : Icons.call_received_outlined,
                                color: decreasesBalance
                                    ? AppColors.danger
                                    : AppColors.success,
                              ),
                              title: Text(
                                entry.kindLabel,
                                style: const TextStyle(
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              subtitle: Text(
                                [
                                  if (entry.invoiceNumber?.isNotEmpty ?? false)
                                    'فاتورة ${entry.invoiceNumber}',
                                  DateFormat(
                                    'dd/MM/yyyy HH:mm',
                                  ).format(entry.createdAt),
                                  if (entry.note?.isNotEmpty ?? false)
                                    entry.note!,
                                ].join(' • '),
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 12,
                                ),
                              ),
                              trailing: Text(
                                '${decreasesBalance ? '-' : '+'}${entry.amount.toStringAsFixed(2)} ج',
                                style: TextStyle(
                                  color: decreasesBalance
                                      ? AppColors.danger
                                      : AppColors.success,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? AppColors.danger : AppColors.success,
        ),
      );
  }
}

class _AccountFormResult {
  final String type;
  final String name;
  final String? provider;
  final String? reference;
  final double openingBalance;

  const _AccountFormResult({
    required this.type,
    required this.name,
    required this.provider,
    required this.reference,
    required this.openingBalance,
  });
}

class _AccountFormDialog extends StatefulWidget {
  const _AccountFormDialog();

  @override
  State<_AccountFormDialog> createState() => _AccountFormDialogState();
}

class _AccountFormDialogState extends State<_AccountFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _providerController = TextEditingController();
  final _referenceController = TextEditingController();
  final _openingBalanceController = TextEditingController(text: '0');
  String _type = PaymentAccountType.wallet.name;

  @override
  void dispose() {
    _nameController.dispose();
    _providerController.dispose();
    _referenceController.dispose();
    _openingBalanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWallet = _type == PaymentAccountType.wallet.name;
    final isVisa = _type == PaymentAccountType.visa.name;
    final isFawry = _type == PaymentAccountType.fawry.name;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('إضافة حساب استلام'),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  initialValue: _type,
                  decoration: const InputDecoration(labelText: 'نوع الحساب'),
                  items: const [
                    DropdownMenuItem(
                      value: 'wallet',
                      child: Text('محفظة إلكترونية'),
                    ),
                    DropdownMenuItem(value: 'visa', child: Text('فيزا')),
                    DropdownMenuItem(value: 'fawry', child: Text('فوري')),
                  ],
                  onChanged: (value) {
                    if (value != null) setState(() => _type = value);
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _nameController,
                  maxLength: 80,
                  decoration: InputDecoration(
                    labelText: 'اسم الحساب',
                    hintText: isWallet
                        ? 'مثال: محفظة الفرع'
                        : isVisa
                        ? 'مثال: جهاز فيزا 1'
                        : 'مثال: حساب فوري الفرع',
                  ),
                  validator: (value) => value == null || value.trim().length < 2
                      ? 'اكتب اسمًا من حرفين على الأقل'
                      : null,
                ),
                TextFormField(
                  controller: _providerController,
                  decoration: InputDecoration(
                    labelText: isWallet
                        ? 'شركة المحفظة (اختياري)'
                        : isFawry
                        ? 'مزود فوري/الفرع (اختياري)'
                        : 'البنك/مزود الخدمة (اختياري)',
                  ),
                ),
                TextFormField(
                  controller: _referenceController,
                  decoration: InputDecoration(
                    labelText: isWallet
                        ? 'رقم هاتف المحفظة (اختياري)'
                        : isVisa
                        ? 'اسم جهاز نقاط البيع (اختياري)'
                        : 'معرّف التاجر أو الفرع (اختياري)',
                    helperText: isVisa
                        ? 'لا تدخل أي بيانات بطاقة مثل الرقم أو رمز CVV.'
                        : null,
                  ),
                  keyboardType: isWallet
                      ? TextInputType.phone
                      : TextInputType.text,
                  validator: (value) {
                    if (!isVisa) return null;
                    final digits = value?.replaceAll(RegExp(r'\D'), '') ?? '';
                    if (digits.length >= 13 && digits.length <= 19) {
                      return 'اكتب اسم الجهاز فقط، ولا تدخل رقم البطاقة';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _openingBalanceController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'الرصيد الموجود حاليًا في الحساب',
                    helperText: 'سيُسجل كرصيد افتتاحي في سجل الحركات',
                  ),
                  validator: (value) {
                    final amount = double.tryParse(value?.trim() ?? '');
                    if (amount == null || !amount.isFinite || amount < 0) {
                      return 'أدخل رصيدًا صحيحًا غير سالب';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          FilledButton(onPressed: _save, child: const Text('حفظ')),
        ],
      ),
    );
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(
      context,
      _AccountFormResult(
        type: _type,
        name: _nameController.text.trim(),
        provider: _providerController.text.trim(),
        reference: _referenceController.text.trim(),
        openingBalance: double.parse(_openingBalanceController.text.trim()),
      ),
    );
  }
}

class _BalanceAdjustmentResult {
  final double amount;
  final String? note;

  const _BalanceAdjustmentResult({required this.amount, required this.note});
}

class _BalanceAdjustmentDialog extends StatefulWidget {
  final String accountName;
  final double currentBalance;
  final bool isDeposit;

  const _BalanceAdjustmentDialog({
    required this.accountName,
    required this.currentBalance,
    required this.isDeposit,
  });

  @override
  State<_BalanceAdjustmentDialog> createState() =>
      _BalanceAdjustmentDialogState();
}

class _BalanceAdjustmentDialogState extends State<_BalanceAdjustmentDialog> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDeposit = widget.isDeposit;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(
          isDeposit
              ? 'إيداع في ${widget.accountName}'
              : 'سحب من ${widget.accountName}',
        ),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'الرصيد الحالي: ${widget.currentBalance.toStringAsFixed(2)} ج',
                style: const TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: isDeposit ? 'مبلغ الإيداع' : 'مبلغ السحب',
                ),
                validator: (value) {
                  final amount = double.tryParse(value?.trim() ?? '');
                  if (amount == null || !amount.isFinite || amount <= 0) {
                    return 'أدخل مبلغًا صحيحًا أكبر من صفر';
                  }
                  if (!isDeposit && amount > widget.currentBalance) {
                    return 'مبلغ السحب أكبر من الرصيد الحالي';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _noteController,
                maxLength: 120,
                decoration: const InputDecoration(
                  labelText: 'ملاحظة (اختياري)',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: _save,
            child: Text(isDeposit ? 'تأكيد الإيداع' : 'تأكيد السحب'),
          ),
        ],
      ),
    );
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(
      context,
      _BalanceAdjustmentResult(
        amount: double.parse(_amountController.text.trim()),
        note: _noteController.text.trim().isEmpty
            ? null
            : _noteController.text.trim(),
      ),
    );
  }
}
