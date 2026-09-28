import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cashier_app_v2/core/constants/app_colors.dart';
import 'package:cashier_app_v2/core/database/app_database.dart';
import 'package:cashier_app_v2/di.dart';
import 'package:cashier_app_v2/features/suppliers/domain/entities/supplier_ui.dart';
import 'package:cashier_app_v2/features/suppliers/presentation/bloc/suppliers_bloc.dart';
import 'package:cashier_app_v2/features/suppliers/presentation/bloc/suppliers_event.dart';
import 'package:cashier_app_v2/features/suppliers/presentation/bloc/suppliers_state.dart';
import 'package:cashier_app_v2/features/suppliers/presentation/screens/supplier_statement_screen.dart';
import 'package:cashier_app_v2/features/suppliers/presentation/widgets/supplier_card.dart';
import 'package:cashier_app_v2/features/suppliers/presentation/widgets/supplier_empty_state.dart';
import 'package:cashier_app_v2/features/suppliers/presentation/widgets/supplier_form_sheet.dart';
import 'package:cashier_app_v2/features/suppliers/presentation/widgets/supplier_search_field.dart';

enum SupplierPaymentFilter {
  all,
  unpaid,
  partial,
  paid,
}

class SuppliersScreen extends StatefulWidget {
  const SuppliersScreen({super.key});

  @override
  State<SuppliersScreen> createState() => _SuppliersScreenState();
}

class _SuppliersScreenState extends State<SuppliersScreen> {
  final TextEditingController _searchController = TextEditingController();

  String _query = '';
  SupplierPaymentFilter _paymentFilter = SupplierPaymentFilter.all;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<SupplierUi> _filteredSuppliers(List<SupplierUi> suppliers) {
    final query = _query.trim().toLowerCase();

    return suppliers.where((supplier) {
      final matchesSearch = query.isEmpty ||
          supplier.name.toLowerCase().contains(query) ||
          (supplier.phone?.toLowerCase().contains(query) ?? false);

      if (!matchesSearch) return false;

      return _matchesPaymentFilter(supplier);
    }).toList();
  }

  bool _matchesPaymentFilter(SupplierUi supplier) {
    final collected = supplier.totalCollected;
    final due = supplier.totalDue;

    switch (_paymentFilter) {
      case SupplierPaymentFilter.all:
        return true;
      case SupplierPaymentFilter.unpaid:
        return collected <= 0.01 && due > 0.01;
      case SupplierPaymentFilter.partial:
        return collected > 0.01 && due > 0.01;
      case SupplierPaymentFilter.paid:
        return due <= 0.01;
    }
  }

  String _filterLabel() {
    switch (_paymentFilter) {
      case SupplierPaymentFilter.all:
        return 'الكل';
      case SupplierPaymentFilter.unpaid:
        return 'لم يتم التحصيل';
      case SupplierPaymentFilter.partial:
        return 'تحصيل جزئي';
      case SupplierPaymentFilter.paid:
        return 'تم التحصيل بالكامل';
    }
  }

  SupplierUi _toUiSupplier(
      Supplier supplier, {
        SupplierUi? currentUi,
      }) {
    return SupplierUi(
      id: supplier.id.toString(),
      name: supplier.name,
      phone: supplier.phone,
      address: supplier.address,
      productsCount: currentUi?.productsCount ?? 0,
      totalDue: currentUi?.totalDue ?? 0,
      totalCollected: currentUi?.totalCollected ?? 0,
    );
  }

  void _openForm(
      BuildContext blocContext, {
        Supplier? supplier,
        SupplierUi? uiSupplier,
      }) {
    final supplierForForm = uiSupplier ??
        (supplier == null ? null : _toUiSupplier(supplier));

    SupplierFormSheet.show(
      context,
      supplier: supplierForForm,
      onSubmit: (result) {
        final bloc = blocContext.read<SuppliersBloc>();

        final name = result.name.trim();
        final phone = result.phone?.trim();
        final address = result.address?.trim();

        if (name.isEmpty) return;

        if (supplier == null) {
          bloc.add(
            AddSupplierEvent(
              name: name,
              phone: phone,
              address: address,
            ),
          );
        } else {
          bloc.add(
            UpdateSupplierEvent(
              Supplier(
                id: supplier.id,
                name: name,
                phone: phone,
                address: address,
                createdAt: supplier.createdAt,
              ),
            ),
          );
        }
      },
    );
  }

  void _confirmDelete(
      BuildContext blocContext,
      Supplier supplier,
      ) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.border),
          ),
          title: const Text('حذف المورد'),
          content: Text('هل تريد حذف "${supplier.name}"؟'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                blocContext.read<SuppliersBloc>().add(
                  DeleteSupplierEvent(supplier.id),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: AppColors.danger,
              ),
              child: const Text('حذف'),
            ),
          ],
        );
      },
    );
  }

  void _openDetails(SupplierUi supplierUi) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SupplierStatementScreen(
          supplier: supplierUi,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SuppliersBloc>()..add(const WatchSuppliersEvent()),
      child: Builder(
        builder: (blocContext) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              backgroundColor: AppColors.background,
              appBar: AppBar(
                title: const Text('الموردين'),
              ),
              body: BlocConsumer<SuppliersBloc, SuppliersState>(
                listener: (context, state) {
                  if (state.status == SuppliersStatus.failure &&
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
                  final List<SupplierUi> uiSuppliers = state.suppliers
                      .map(_toUiSupplier)
                      .toList();

                  final filteredList = _filteredSuppliers(uiSuppliers);



                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                        child: SupplierSearchField(
                          controller: _searchController,
                          onChanged: (value) {
                            setState(() {
                              _query = value;
                            });
                          },
                        ),
                      ),
                      _buildPaymentFilter(),
                      Expanded(
                        child: _buildContent(
                          context,
                          blocContext,
                          state,
                          filteredList,
                        ),
                      ),
                    ],
                  );
                },
              ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () => _openForm(blocContext),
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.black,
                icon: const Icon(Icons.add),
                label: const Text(
                  'إضافة مورد',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPaymentFilter() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: Row(
        children: [
          const Icon(
            Icons.filter_list,
            size: 18,
            color: AppColors.textHint,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: DropdownButtonFormField<SupplierPaymentFilter>(
              value: _paymentFilter,
              dropdownColor: AppColors.surface,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: const InputDecoration(
                labelText: 'حالة التحصيل',
                prefixIcon: Icon(Icons.payments_outlined),
              ),
              items: const [
                DropdownMenuItem(
                  value: SupplierPaymentFilter.all,
                  child: Text('الكل'),
                ),
                DropdownMenuItem(
                  value: SupplierPaymentFilter.unpaid,
                  child: Text('لم يتم التحصيل'),
                ),
                DropdownMenuItem(
                  value: SupplierPaymentFilter.partial,
                  child: Text('تحصيل جزئي'),
                ),
                DropdownMenuItem(
                  value: SupplierPaymentFilter.paid,
                  child: Text('تم التحصيل بالكامل'),
                ),
              ],
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  _paymentFilter = value;
                });
              },
            ),
          ),
          if (_paymentFilter != SupplierPaymentFilter.all) ...[
            const SizedBox(width: 10),
            Text(
              _filterLabel(),
              style: const TextStyle(
                color: AppColors.gold,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildContent(
      BuildContext context,
      BuildContext blocContext,
      SuppliersState state,
      List<SupplierUi> suppliers,
      ) {
    if (state.status == SuppliersStatus.loading && state.suppliers.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.gold),
      );
    }

    if (state.status == SuppliersStatus.failure && state.suppliers.isEmpty) {
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
                state.errorMessage ?? 'حدث خطأ أثناء تحميل الموردين',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  blocContext.read<SuppliersBloc>().add(
                    const WatchSuppliersEvent(),
                  );
                },
                child: const Text('إعادة المحاولة'),
              ),
            ],
          ),
        ),
      );
    }

    if (suppliers.isEmpty) {
      return const SupplierEmptyState();
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
      itemCount: suppliers.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final uiSupplier = suppliers[index];

        final rawSupplier = state.suppliers.firstWhere(
              (item) => item.id.toString() == uiSupplier.id,
          orElse: () => Supplier(
            id: int.parse(uiSupplier.id),
            name: uiSupplier.name,
            phone: uiSupplier.phone,
            address: uiSupplier.address,
            createdAt: DateTime.now(),
          ),
        );

        return SupplierCard(
          supplier: uiSupplier,
          onTap: () => _openDetails(uiSupplier),
          onEdit: () => _openForm(
            blocContext,
            supplier: rawSupplier,
            uiSupplier: uiSupplier,
          ),
          onDelete: () => _confirmDelete(
            blocContext,
            rawSupplier,
          ),
        );
      },
    );
  }
}