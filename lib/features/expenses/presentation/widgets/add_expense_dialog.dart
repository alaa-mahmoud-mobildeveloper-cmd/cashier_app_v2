import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../payment_accounts/domain/payment_account.dart';
import '../../domain/entities/expense.dart';

class AddExpenseDialog extends StatefulWidget {
  final Expense? expense;
  final List<PaymentAccountInfo> accounts;

  const AddExpenseDialog({super.key, this.expense, this.accounts = const []});

  @override
  State<AddExpenseDialog> createState() => _AddExpenseDialogState();
}

class _AddExpenseDialogState extends State<AddExpenseDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _amountController;
  late String _selectedCategory;
  late ExpenseStatus _selectedStatus;
  late String _selectedPaymentMethod;
  int? _selectedAccountId;

  static const _categories = [
    'إيجار',
    'رواتب',
    'مرافق',
    'مشتريات',
    'نقل',
    'أخرى',
  ];

  @override
  void initState() {
    super.initState();
    final e = widget.expense;
    _titleController = TextEditingController(text: e?.title ?? '');
    _descriptionController = TextEditingController(text: e?.description ?? '');
    _amountController = TextEditingController(
      text: e == null ? '' : e.amount.toString(),
    );
    _selectedCategory = e?.category ?? _categories.first;
    _selectedStatus = e?.status ?? ExpenseStatus.paid;
    _selectedPaymentMethod = e?.paymentAccountId != null
        ? 'account'
        : (e?.paymentMethod ?? 'cash');
    _selectedAccountId = e?.paymentAccountId;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final amount = double.tryParse(_amountController.text.trim());
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('أدخل مبلغًا صحيحًا أكبر من صفر')),
      );
      return;
    }
    if (_selectedStatus == ExpenseStatus.paid &&
        _selectedPaymentMethod == 'account' &&
        _selectedAccountId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('اختر الحساب الإلكتروني')));
      return;
    }
    Navigator.pop(
      context,
      Expense(
        id: widget.expense?.id,
        title: _titleController.text.trim(),
        category: _selectedCategory,
        description: _descriptionController.text.trim(),
        date: widget.expense?.date ?? DateTime.now(),
        amount: amount,
        status: _selectedStatus,
        paymentMethod: _selectedPaymentMethod == 'account'
            ? widget.accounts.firstWhere((a) => a.id == _selectedAccountId).type
            : _selectedPaymentMethod,
        paymentAccountId: _selectedPaymentMethod == 'account'
            ? _selectedAccountId
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.expense == null ? 'إضافة مصروف' : 'تعديل المصروف'),
      content: SizedBox(
        width: 460,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _titleController,
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? 'أدخل اسم المصروف' : null,
                  decoration: const InputDecoration(
                    labelText: 'اسم المصروف',
                    prefixIcon: Icon(Icons.receipt_long_outlined),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: _selectedCategory,
                  decoration: const InputDecoration(
                    labelText: 'التصنيف',
                    prefixIcon: Icon(Icons.category_outlined),
                  ),
                  items: _categories
                      .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                      .toList(),
                  onChanged: (v) => setState(() => _selectedCategory = v!),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _amountController,
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? 'أدخل المبلغ' : null,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'المبلغ',
                    suffixText: 'ج',
                    prefixIcon: Icon(Icons.payments_outlined),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<ExpenseStatus>(
                  initialValue: _selectedStatus,
                  decoration: const InputDecoration(
                    labelText: 'الحالة',
                    prefixIcon: Icon(Icons.flag_outlined),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: ExpenseStatus.paid,
                      child: Text('مدفوع الآن'),
                    ),
                    DropdownMenuItem(
                      value: ExpenseStatus.pending,
                      child: Text('آجل / غير مدفوع'),
                    ),
                  ],
                  onChanged: (v) => setState(() {
                    _selectedStatus = v!;
                    if (v == ExpenseStatus.pending) {
                      _selectedPaymentMethod = 'credit';
                      _selectedAccountId = null;
                    }
                  }),
                ),
                if (_selectedStatus == ExpenseStatus.paid) ...[
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: _selectedPaymentMethod == 'account'
                        ? 'account'
                        : 'cash',
                    decoration: const InputDecoration(
                      labelText: 'طريقة الدفع',
                      prefixIcon: Icon(Icons.account_balance_wallet_outlined),
                    ),
                    items: [
                      const DropdownMenuItem(
                        value: 'cash',
                        child: Text('نقدي'),
                      ),
                      if (widget.accounts.isNotEmpty)
                        const DropdownMenuItem(
                          value: 'account',
                          child: Text('حساب إلكتروني'),
                        ),
                    ],
                    onChanged: (v) => setState(() {
                      _selectedPaymentMethod = v!;
                      if (v != 'account') _selectedAccountId = null;
                    }),
                  ),
                  if (_selectedPaymentMethod == 'account') ...[
                    const SizedBox(height: 8),
                    DropdownButtonFormField<int>(
                      initialValue: _selectedAccountId,
                      decoration: const InputDecoration(
                        labelText: 'الحساب الإلكتروني',
                      ),
                      items: widget.accounts
                          .map(
                            (a) => DropdownMenuItem(
                              value: a.id,
                              child: Text(a.displayLabel),
                            ),
                          )
                          .toList(),
                      onChanged: (v) => setState(() => _selectedAccountId = v),
                    ),
                  ],
                ],
                const SizedBox(height: 12),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'الوصف (اختياري)',
                    prefixIcon: Icon(Icons.notes_outlined),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'إلغاء',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ),
        ElevatedButton(onPressed: _save, child: const Text('حفظ')),
      ],
    );
  }
}
