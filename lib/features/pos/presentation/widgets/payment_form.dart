import 'package:cashier_app_v2/core/database/app_database.dart';
import 'package:cashier_app_v2/di.dart';
import 'package:flutter/material.dart';

typedef DeferredPaymentConfirm =
    void Function(int? customerId, String name, String phone, double amount);

class PaymentForm extends StatefulWidget {
  final String methodLabel;
  final DeferredPaymentConfirm onConfirm;

  const PaymentForm({
    super.key,
    required this.methodLabel,
    required this.onConfirm,
  });

  static Future<void> show(
    BuildContext context, {
    required String methodLabel,
    required DeferredPaymentConfirm onConfirm,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
        ),
        child: PaymentForm(methodLabel: methodLabel, onConfirm: onConfirm),
      ),
    );
  }

  @override
  State<PaymentForm> createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _amountController = TextEditingController();

  late final AppDatabase _database;
  List<Customer> _customers = const [];
  int? _selectedCustomerId;
  bool _loadingCustomers = true;
  bool _isCreatingCustomer = true;
  String? _loadError;

  @override
  void initState() {
    super.initState();
    _database = getIt<AppDatabase>();
    _loadCustomers();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _loadCustomers() async {
    try {
      final customers = await _database.select(_database.customers).get();
      customers.sort(
        (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
      );
      if (!mounted) return;
      setState(() {
        _customers = customers;
        _loadingCustomers = false;
        _isCreatingCustomer = customers.isEmpty;
        _selectedCustomerId = customers.isEmpty ? null : customers.first.id;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _loadingCustomers = false;
        _isCreatingCustomer = true;
        _loadError = 'تعذر تحميل حسابات العملاء السابقة';
      });
    }
  }

  Customer? get _selectedCustomer {
    for (final customer in _customers) {
      if (customer.id == _selectedCustomerId) return customer;
    }
    return null;
  }

  String _normalizePhone(String? value) =>
      (value ?? '').replaceAll(RegExp(r'\D'), '');

  String? _validateNewPhone(String? value) {
    final phone = value?.trim() ?? '';
    if (phone.isEmpty) return 'من فضلك أدخل رقم التليفون';
    final digits = _normalizePhone(phone);
    if (digits.length < 10) return 'رقم غير صحيح';

    final duplicate = _customers.any(
      (customer) => _normalizePhone(customer.phone) == digits,
    );
    if (duplicate) {
      return 'الرقم مسجل بالفعل؛ اختر حساب العميل السابق';
    }
    return null;
  }

  void _confirm() {
    if (_loadingCustomers || !_formKey.currentState!.validate()) return;

    final amount = double.parse(_amountController.text.trim());
    if (_isCreatingCustomer) {
      widget.onConfirm(
        null,
        _nameController.text.trim(),
        _phoneController.text.trim(),
        amount,
      );
    } else {
      final customer = _selectedCustomer;
      if (customer == null) return;
      widget.onConfirm(
        customer.id,
        customer.name,
        customer.phone ?? '',
        amount,
      );
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final selectedCustomer = _selectedCustomer;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'بيع آجل — ${widget.methodLabel}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: [
                  ChoiceChip(
                    label: const Text('حساب عميل سابق'),
                    selected: !_isCreatingCustomer,
                    onSelected: _loadingCustomers || _customers.isEmpty
                        ? null
                        : (_) => setState(() => _isCreatingCustomer = false),
                  ),
                  ChoiceChip(
                    label: const Text('إضافة حساب آجل جديد'),
                    selected: _isCreatingCustomer,
                    onSelected: (_) =>
                        setState(() => _isCreatingCustomer = true),
                  ),
                ],
              ),
              if (_loadingCustomers) ...[
                const LinearProgressIndicator(),
                const SizedBox(height: 8),
              ],
              if (_loadError != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    _loadError!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              if (!_loadingCustomers &&
                  !_isCreatingCustomer &&
                  _customers.isNotEmpty) ...[
                DropdownButtonFormField<int>(
                  initialValue: _selectedCustomerId,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'اختر حساب العميل السابق',
                  ),
                  items: _customers
                      .map(
                        (customer) => DropdownMenuItem<int>(
                          value: customer.id,
                          child: Text(
                            '${customer.name} • ${customer.phone ?? 'بدون رقم'} • عليه ${customer.totalDebt.toStringAsFixed(2)} ج',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                      .toList(growable: false),
                  onChanged: (id) => setState(() => _selectedCustomerId = id),
                  validator: (id) => id == null ? 'اختر حساب العميل' : null,
                ),
                if (selectedCustomer != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'الرصيد المستحق حاليًا: ${selectedCustomer.totalDebt.toStringAsFixed(2)} ج',
                    ),
                  ),
              ],
              if (!_loadingCustomers && _customers.isEmpty)
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text('لا توجد حسابات سابقة؛ أنشئ حسابًا جديدًا.'),
                ),
              if (_isCreatingCustomer) ...[
                TextFormField(
                  controller: _nameController,
                  onTapOutside: (_) {},
                  decoration: const InputDecoration(labelText: 'اسم العميل'),
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'من فضلك أدخل اسم العميل'
                      : null,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _phoneController,
                  onTapOutside: (_) {},
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(labelText: 'رقم التليفون'),
                  validator: _validateNewPhone,
                ),
              ],
              const SizedBox(height: 8),
              TextFormField(
                controller: _amountController,
                onTapOutside: (_) {},
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'المبلغ المدفوع الآن',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'من فضلك أدخل المبلغ المدفوع';
                  }
                  final amount = double.tryParse(value.trim());
                  if (amount == null || !amount.isFinite || amount < 0) {
                    return 'المبلغ غير صحيح';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadingCustomers ? null : _confirm,
                child: const Text('تأكيد البيع الآجل'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
