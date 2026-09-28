import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cashier_app_v2/core/constants/app_colors.dart';
import 'package:cashier_app_v2/di.dart';

import 'package:cashier_app_v2/features/purchases/domian/entities/product_search_result.dart';
import 'package:cashier_app_v2/features/purchases/domian/entities/purchase_item_draft.dart';
import 'package:cashier_app_v2/features/purchases/domian/entities/purchase_item_save.dart';
import 'package:cashier_app_v2/features/purchases/domian/entities/save_purchase_params.dart';

import 'package:cashier_app_v2/features/purchases/presentation/bloc/purchase_bloc/purchase_bloc.dart';
import 'package:cashier_app_v2/features/purchases/presentation/bloc/purchase_bloc/purchase_event.dart';
import 'package:cashier_app_v2/features/purchases/presentation/bloc/purchase_bloc/purchase_state.dart';

import 'package:cashier_app_v2/features/suppliers/presentation/bloc/suppliers_bloc.dart';
import 'package:cashier_app_v2/features/suppliers/presentation/bloc/suppliers_event.dart';
import 'package:cashier_app_v2/features/suppliers/presentation/bloc/suppliers_state.dart';

import '../widgets/product_search_section.dart';
import '../widgets/purchase_item_card.dart';
import '../widgets/purchase_items_table.dart';
import '../widgets/purchase_summary_panel.dart';
import '../widgets/supplier_selector.dart';

class PurchasesScreen extends StatefulWidget {
  const PurchasesScreen({super.key});

  @override
  State<PurchasesScreen> createState() => _PurchasesScreenState();
}

class _PurchasesScreenState extends State<PurchasesScreen> {
  static const double _desktopBreakpoint = 900;

  final List<PurchaseItemDraft> _items = [];

  int? _selectedSupplierId;
  double _discount = 0;
  double _tax = 0;
  String _paymentMethod = 'cash';
  DateTime? _dueDate;
  double _paidAmount = 0;

  double get _total => _items.fold(0, (sum, item) => sum + item.total);
  double get _netTotal => _total - _discount + _tax;

  double get _remainingAmount {
    final remaining = _netTotal - _paidAmount;
    return remaining <= 0 ? 0 : remaining;
  }

  bool get _isCredit => _paymentMethod == 'credit';
  bool get _hasPartialPayment => _isCredit && _paidAmount > 0;
  bool get _isFullyPaid => _netTotal > 0 && _paidAmount >= _netTotal;

  @override
  void initState() {
    super.initState();
    _initDefaultValues();
  }

  void _initDefaultValues() {
    _selectedSupplierId = null;
    _paymentMethod = 'credit';
    _discount = 0;
    _tax = 0;
    _paidAmount = 0;
    _dueDate = DateTime.now().add(const Duration(days: 30));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PurchaseBloc>(
          create: (_) => getIt<PurchaseBloc>(),
        ),
        BlocProvider<SuppliersBloc>(
          create: (_) => getIt<SuppliersBloc>()..add(const WatchSuppliersEvent()),
        ),
      ],
      child: BlocListener<PurchaseBloc, PurchaseState>(
        listener: _handleBlocListener,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('فاتورة شراء جديدة'),
            ),
            body: BlocBuilder<PurchaseBloc, PurchaseState>(
              builder: (blocContext, state) {
                final isSaving = state.status == PurchaseStatus.saving;

                return LayoutBuilder(
                  builder: (context, constraints) {
                    final isDesktop = constraints.maxWidth >= _desktopBreakpoint;

                    return isDesktop
                        ? _buildDesktopLayout(blocContext, isSaving)
                        : _buildMobileLayout(blocContext, isSaving);
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _handleBlocListener(BuildContext context, PurchaseState state) {
    if (!mounted) return;

    if (state.status == PurchaseStatus.success) {
      _clearInvoice();
      _showSnackBar(context, 'تم حفظ فاتورة الشراء بنجاح');
    }

    if (state.status == PurchaseStatus.failure) {
      _showSnackBar(
        context,
        state.errorMessage ?? 'حدث خطأ أثناء حفظ الفاتورة',
      );
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _addProduct(ProductSearchResult product) {
    if (!mounted) return;

    setState(() {
      final existingIndex = _items.indexWhere(
            (item) => item.productId == product.id,
      );

      if (existingIndex != -1) {
        _items[existingIndex].cartonQuantity += 1;
      } else {
        _items.add(PurchaseItemDraft.fromProduct(product));
      }

      _normalizePaidAmount();
    });
  }

  void _updateQuantity(int productId, double quantity) {
    if (quantity <= 0 || !mounted) return;

    setState(() {
      final index = _items.indexWhere((item) => item.productId == productId);
      if (index == -1) return;

      _items[index].cartonQuantity = quantity;
      _normalizePaidAmount();
    });
  }

  void _updatePrice(int productId, double price) {
    if (price < 0 || !mounted) return;

    setState(() {
      final index = _items.indexWhere((item) => item.productId == productId);
      if (index == -1) return;

      final item = _items[index];
      item.cartonPurchasePrice = price;

      if (item.priceChanged) {
        item.salePrice = item.suggestedSalePrice;
      }

      _normalizePaidAmount();
    });
  }

  void _updateSalePrice(int productId, double price) {
    if (price < 0 || !mounted) return;

    setState(() {
      final index = _items.indexWhere((item) => item.productId == productId);
      if (index == -1) return;

      _items[index].salePrice = price;
    });
  }

  void _removeItem(int productId) {
    if (!mounted) return;

    setState(() {
      _items.removeWhere((item) => item.productId == productId);
      _normalizePaidAmount();
    });
  }

  void _onPaymentMethodChanged(String? value) {
    if (value == null || value.isEmpty || !mounted) return;

    setState(() {
      _paymentMethod = value;

      if (_paymentMethod == 'cash') {
        _paidAmount = _netTotal > 0 ? _netTotal : 0;
        _dueDate = null;
      } else if (_paymentMethod == 'credit') {
        _paidAmount = 0;
        _dueDate ??= DateTime.now().add(const Duration(days: 30));
      }

      _normalizePaidAmount();
    });
  }

  void _onPaidAmountChanged(double value) {
    if (!_isCredit || value < 0 || !mounted) return;

    final maxAmount = _netTotal;
    setState(() {
      _paidAmount = value > maxAmount ? maxAmount : value;
      _normalizePaidAmount();
    });
  }

  Future<void> _showPaidAmountDialog() async {
    if (!_isCredit || !mounted) return;

    final value = await showDialog<double>(
      context: context,
      builder: (dialogContext) {
        return _PaidAmountDialog(
          initialAmount: _paidAmount,
          maxAmount: _netTotal,
        );
      },
    );

    if (!mounted || value == null) return;
    _onPaidAmountChanged(value);
  }

  void _normalizePaidAmount() {
    if (_netTotal <= 0) {
      _paidAmount = 0;
      return;
    }

    if (_paymentMethod == 'cash') {
      _paidAmount = _netTotal;
      return;
    }

    if (_paidAmount > _netTotal) {
      _paidAmount = _netTotal;
    }

    if (_paidAmount < 0) {
      _paidAmount = 0;
    }
  }

  Future<void> _selectDueDate() async {
    if (!_isCredit || !mounted) return;

    final now = DateTime.now();
    final initialDate = _dueDate ?? now.add(const Duration(days: 30));

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate.isBefore(now) ? now : initialDate,
      firstDate: now,
      lastDate: DateTime(now.year + 10, now.month, now.day),
      helpText: 'اختر موعد التحصيل',
      cancelText: 'إلغاء',
      confirmText: 'اختيار',
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
    );

    if (!mounted || selectedDate == null) return;

    setState(() {
      _dueDate = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
      );
    });
  }

  String _formatDueDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  void _save(BuildContext blocContext) {
    _normalizePaidAmount();

    if (_selectedSupplierId == null) {
      _showSnackBar(blocContext, 'من فضلك اختر المورد');
      return;
    }

    if (_items.isEmpty) {
      _showSnackBar(blocContext, 'من فضلك أضف صنفًا واحدًا على الأقل');
      return;
    }

    if (_netTotal <= 0) {
      _showSnackBar(blocContext, 'قيمة الفاتورة يجب أن تكون أكبر من صفر');
      return;
    }

    if (_isCredit && _dueDate == null) {
      _showSnackBar(blocContext, 'من فضلك اختر موعد التحصيل للفاتورة الآجلة');
      return;
    }

    if (_paidAmount > _netTotal) {
      _showSnackBar(blocContext, 'المبلغ المدفوع لا يمكن أن يتجاوز قيمة الفاتورة');
      return;
    }

    final purchaseItems = _items
        .map(
          (item) => PurchaseItemSave(
        productId: item.productId,
        quantity: item.totalUnits,
        cartonQuantity: item.cartonQuantity,
        unitsPerCarton: item.unitsPerCarton,
        purchasePrice: item.cartonPurchasePrice,
        salePrice: item.salePrice,
        total: item.total,
      ),
    )
        .toList();

    final params = SavePurchaseParams(
      supplierId: _selectedSupplierId!,
      invoiceNumber: _generateInvoiceNumber(),
      total: _total,
      discount: _discount,
      tax: _tax,
      netTotal: _netTotal,
      paymentMethod: _paymentMethod,
      items: purchaseItems,
      dueDate: _isCredit ? _dueDate : null,
      paidAmount: _isCredit ? _paidAmount : _netTotal,
    );

    blocContext.read<PurchaseBloc>().add(SavePurchaseEvent(params));
  }

  String _generateInvoiceNumber() {
    final now = DateTime.now();
    return 'PUR-${now.year}'
        '${now.month.toString().padLeft(2, '0')}'
        '${now.day.toString().padLeft(2, '0')}-'
        '${now.hour.toString().padLeft(2, '0')}'
        '${now.minute.toString().padLeft(2, '0')}'
        '${now.second.toString().padLeft(2, '0')}';
  }

  void _clearInvoice() {
    if (!mounted) return;

    setState(() {
      _items.clear();
      _selectedSupplierId = null;
      _discount = 0;
      _tax = 0;
      _paymentMethod = 'cash';
      _dueDate = null;
      _paidAmount = 0;
    });
  }

  Widget _buildDesktopLayout(BuildContext blocContext, bool isSaving) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildSupplierSelector(),
                const SizedBox(height: 16),
                _buildSearchField(),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: PurchaseItemsTable(
                      items: _items,
                      onQuantityChanged: _updateQuantity,
                      onPriceChanged: _updatePrice,
                      onSalePriceChanged: _updateSalePrice,
                      onRemove: _removeItem,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 1,
            child: _buildSummaryPanel(blocContext, isSaving),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext blocContext, bool isSaving) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildSupplierSelector(),
                const SizedBox(height: 12),
                _buildSearchField(),
                const SizedBox(height: 12),
                _buildMobileItemsList(),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: _buildSummaryPanel(blocContext, isSaving),
        ),
      ],
    );
  }

  Widget _buildSupplierSelector() {
    return BlocBuilder<SuppliersBloc, SuppliersState>(
      builder: (context, state) {
        if (state.status == SuppliersStatus.loading && state.suppliers.isEmpty) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: const Row(
              children: [
                SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.gold,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'جاري تحميل الموردين...',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ],
            ),
          );
        }

        if (state.status == SuppliersStatus.failure && state.suppliers.isEmpty) {
          return Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                const Icon(Icons.error_outline, color: AppColors.danger),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    state.errorMessage ?? 'حدث خطأ أثناء تحميل الموردين',
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.read<SuppliersBloc>().add(const WatchSuppliersEvent());
                  },
                  child: const Text('إعادة المحاولة'),
                ),
              ],
            ),
          );
        }

        final suppliers = state.suppliers
            .map(
              (supplier) => SupplierSummary(
            id: supplier.id,
            name: supplier.name,
          ),
        )
            .toList();

        if (suppliers.isEmpty) {
          return Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.local_shipping_outlined,
                  color: AppColors.textHint,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'لا يوجد موردون. أضف موردًا أولًا.',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ),
              ],
            ),
          );
        }

        final selectedExists = suppliers.any(
              (supplier) => supplier.id == _selectedSupplierId,
        );

        if (_selectedSupplierId == null || !selectedExists) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted || suppliers.isEmpty) return;

            final currentExists = suppliers.any(
                  (supplier) => supplier.id == _selectedSupplierId,
            );

            if (!currentExists) {
              setState(() {
                _selectedSupplierId = suppliers.first.id;
              });
            }
          });
        }

        return SupplierSelector(
          suppliers: suppliers,
          selectedSupplierId: selectedExists ? _selectedSupplierId : null,
          onChanged: (id) {
            if (!mounted) return;
            setState(() {
              _selectedSupplierId = id;
            });
          },
        );
      },
    );
  }

  Widget _buildSearchField() {
    return ProductSearchSection(
      onProductPicked: _addProduct,
    );
  }

  Widget _buildMobileItemsList() {
    if (_items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Center(
          child: Text(
            'لسه مفيش أصناف مضافة',
            style: TextStyle(color: AppColors.textHint),
          ),
        ),
      );
    }

    return Column(
      children: _items.map((item) {
        return PurchaseItemCard(
          key: ValueKey(item.productId),
          item: item,
          onQuantityChanged: (q) => _updateQuantity(item.productId, q),
          onPriceChanged: (p) => _updatePrice(item.productId, p),
          onRemove: () => _removeItem(item.productId),
          onSalePriceChanged: (sp) => _updateSalePrice(item.productId, sp),
        );
      }).toList(),
    );
  }

  Widget _buildSummaryPanel(BuildContext blocContext, bool isSaving) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PurchaseSummaryPanel(
          total: _total,
          discount: _discount,
          tax: _tax,
          netTotal: _netTotal,
          paymentMethod: _paymentMethod,
          onDiscountChanged: (value) {
            if (!mounted) return;
            setState(() {
              _discount = value;
              _normalizePaidAmount();
            });
          },
          onTaxChanged: (value) {
            if (!mounted) return;
            setState(() {
              _tax = value;
              _normalizePaidAmount();
            });
          },
          onPaymentMethodChanged: _onPaymentMethodChanged,
          onSave: () => _save(blocContext),
          isSaving: isSaving,
          canSave: _selectedSupplierId != null &&
              _items.isNotEmpty &&
              !isSaving,
        ),
        if (_isCredit) ...[
          const SizedBox(height: 12),
          _buildCreditPaymentCard(),
          const SizedBox(height: 12),
          _buildDueDateCard(),
        ],
      ],
    );
  }

  Widget _buildCreditPaymentCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.gold.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.payments_outlined,
                  size: 20,
                  color: AppColors.gold,
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'دفعة مقدمة',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _buildAmountRow(
            title: 'قيمة الفاتورة',
            amount: _netTotal,
          ),
          const SizedBox(height: 8),
          _buildAmountRow(
            title: 'المدفوع الآن',
            amount: _paidAmount,
            amountColor: AppColors.success,
          ),
          const SizedBox(height: 8),
          _buildAmountRow(
            title: 'المتبقي',
            amount: _remainingAmount,
            amountColor: _remainingAmount > 0
                ? AppColors.warning
                : AppColors.success,
          ),
          const SizedBox(height: 14),
          OutlinedButton.icon(
            onPressed: _netTotal > 0 ? _showPaidAmountDialog : null,
            icon: Icon(
              _hasPartialPayment
                  ? Icons.edit_rounded
                  : Icons.add_card_rounded,
            ),
            label: Text(
              _hasPartialPayment ? 'تعديل الدفعة' : 'إضافة دفعة مقدمة',
            ),
          ),
          if (_isFullyPaid) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    size: 18,
                    color: AppColors.success,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'تم دفع قيمة الفاتورة بالكامل',
                      style: TextStyle(
                        color: AppColors.success,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAmountRow({
    required String title,
    required double amount,
    Color? amountColor,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
        ),
        Text(
          '${amount.toStringAsFixed(2)} ج.م',
          style: TextStyle(
            color: amountColor ?? AppColors.textPrimary,
            fontWeight: FontWeight.w700,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _buildDueDateCard() {
    final hasDate = _dueDate != null;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.event_rounded,
                  size: 20,
                  color: AppColors.warning,
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'موعد التحصيل',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: _selectDueDate,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: AppColors.input,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_month_rounded,
                    size: 20,
                    color: AppColors.gold,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      hasDate ? _formatDueDate(_dueDate!) : 'اختر موعد التحصيل',
                      style: TextStyle(
                        color: hasDate
                            ? AppColors.textPrimary
                            : AppColors.textHint,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_drop_down_rounded,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _remainingAmount > 0
                ? 'المبلغ المتبقي ${_remainingAmount.toStringAsFixed(2)} ج.م سيتم تحصيله في الموعد المحدد.'
                : 'تم دفع قيمة الفاتورة بالكامل.',
            style: TextStyle(
              color: _remainingAmount > 0
                  ? AppColors.textHint
                  : AppColors.success,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

class _PaidAmountDialog extends StatefulWidget {
  const _PaidAmountDialog({
    required this.initialAmount,
    required this.maxAmount,
  });

  final double initialAmount;
  final double maxAmount;

  @override
  State<_PaidAmountDialog> createState() => _PaidAmountDialogState();
}

class _PaidAmountDialogState extends State<_PaidAmountDialog> {
  late final TextEditingController _controller;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.initialAmount > 0
          ? widget.initialAmount.toStringAsFixed(2)
          : '',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final amount = double.tryParse(_controller.text.trim());
    if (amount == null) return;

    Navigator.of(context).pop(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        title: const Text('دفعة مقدمة'),
        content: Form(
          key: _formKey,
          child: TextFormField(
            controller: _controller,
            autofocus: true,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: 'المبلغ المدفوع الآن',
              hintText: 'مثال: 500',
              suffixText: 'ج.م',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (value) {
              final amount = double.tryParse(value?.trim() ?? '');

              if (amount == null) {
                return 'أدخل مبلغًا صحيحًا';
              }
              if (amount < 0) {
                return 'المبلغ لا يمكن أن يكون سالبًا';
              }
              if (amount > widget.maxAmount) {
                return 'المبلغ أكبر من قيمة الفاتورة';
              }

              return null;
            },
            onFieldSubmitted: (_) => _submit(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: _submit,
            child: const Text('تأكيد'),
          ),
        ],
      ),
    );
  }
}