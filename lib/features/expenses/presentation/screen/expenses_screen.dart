import 'package:cashier_app_v2/core/database/app_database.dart' hide Expense;
import 'package:cashier_app_v2/features/expenses/data/repositories/expense_repository.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../di.dart';
import '../../domain/entities/expense.dart';
import '../widgets/add_expense_dialog.dart';
import '../widgets/expense_details_dialog.dart';
import '../widgets/expense_filters.dart';
import '../widgets/expense_row.dart';
import '../widgets/expense_summary_card.dart';
import '../widgets/expenses_header.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final TextEditingController _searchController = TextEditingController();
  late final ExpenseRepository _repository;
  late final Stream<List<Expense>> _expensesStream;
  String _selectedCategory = 'الكل';

  static const List<String> _categories = [
    'الكل',
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
    _repository = ExpenseRepository(getIt<AppDatabase>());
    _expensesStream = _repository.watchExpenses();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Expense> _filteredExpenses(List<Expense> expenses) {
    final query = _searchController.text.trim().toLowerCase();
    return expenses.where((expense) {
      final matchesCategory =
          _selectedCategory == 'الكل' || expense.category == _selectedCategory;
      final matchesQuery =
          query.isEmpty ||
          expense.title.toLowerCase().contains(query) ||
          expense.description.toLowerCase().contains(query);
      return matchesCategory && matchesQuery;
    }).toList();
  }

  double _totalExpenses(List<Expense> expenses) =>
      expenses.fold(0, (sum, expense) => sum + expense.amount);

  double _paidExpenses(List<Expense> expenses) => expenses
      .where((expense) => expense.status == ExpenseStatus.paid)
      .fold(0, (sum, expense) => sum + expense.amount);

  double _pendingExpenses(List<Expense> expenses) => expenses
      .where((expense) => expense.status == ExpenseStatus.pending)
      .fold(0, (sum, expense) => sum + expense.amount);

  String _formatMoney(double value) => '${value.toStringAsFixed(2)} ج';

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _addExpense() async {
    final expense = await showDialog<Expense>(
      context: context,
      builder: (_) => const AddExpenseDialog(),
    );
    if (expense == null || !mounted) return;

    try {
      await _repository.addExpense(expense);
      if (mounted) _showMessage('تم حفظ المصروف');
    } catch (error) {
      if (mounted) _showMessage('تعذر حفظ المصروف: $error');
    }
  }

  Future<void> _editExpense(Expense oldExpense) async {
    final updated = await showDialog<Expense>(
      context: context,
      builder: (_) => AddExpenseDialog(expense: oldExpense),
    );
    if (updated == null || !mounted) return;

    try {
      final affectedRows = await _repository.updateExpense(updated);
      if (mounted) {
        _showMessage(
          affectedRows == 0
              ? 'لم يتم العثور على المصروف لتعديله'
              : 'تم تعديل المصروف',
        );
      }
    } catch (error) {
      if (mounted) _showMessage('تعذر تعديل المصروف: $error');
    }
  }

  Future<void> _deleteExpense(Expense expense) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('حذف المصروف'),
        content: Text('هل تريد حذف ${expense.title}؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('حذف'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;
    final id = expense.id;
    if (id == null) {
      _showMessage('تعذر حذف المصروف لعدم وجود رقم تعريف');
      return;
    }

    try {
      final deletedRows = await _repository.deleteExpense(id);
      if (mounted) {
        _showMessage(
          deletedRows == 0 ? 'لم يتم العثور على المصروف' : 'تم حذف المصروف',
        );
      }
    } catch (error) {
      if (mounted) _showMessage('تعذر حذف المصروف: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: StreamBuilder<List<Expense>>(
            stream: _expensesStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('تعذر تحميل المصروفات: ${snapshot.error}'),
                );
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final expenses = snapshot.data!;
              return LayoutBuilder(
                builder: (_, constraints) {
                  final isCompact = constraints.maxWidth < 800;
                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: isCompact ? 12 : 28,
                      vertical: 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ExpensesHeader(onAdd: _addExpense),
                        const SizedBox(height: 16),
                        _buildSummarySection(expenses, isCompact),
                        const SizedBox(height: 16),
                        _buildFiltersSection(),
                        const SizedBox(height: 12),
                        _buildTableSection(expenses),
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

  Widget _buildSummarySection(List<Expense> expenses, bool isCompact) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: isCompact ? 1 : 3,
      childAspectRatio: isCompact ? 4.2 : 2.8,
      crossAxisSpacing: 16,
      mainAxisSpacing: 12,
      children: [
        ExpenseSummaryCard(
          title: 'إجمالي المصروفات',
          value: _formatMoney(_totalExpenses(expenses)),
          color: AppColors.gold,
          icon: Icons.account_balance_wallet_outlined,
        ),
        ExpenseSummaryCard(
          title: 'المصروفات المدفوعة',
          value: _formatMoney(_paidExpenses(expenses)),
          color: AppColors.success,
          icon: Icons.check_circle_outline,
        ),
        ExpenseSummaryCard(
          title: 'المصروفات المعلقة',
          value: _formatMoney(_pendingExpenses(expenses)),
          color: AppColors.danger,
          icon: Icons.pending_actions_outlined,
        ),
      ],
    );
  }

  Widget _buildFiltersSection() {
    return ExpenseFilters(
      controller: _searchController,
      selected: _selectedCategory,
      categories: _categories,
      onSearch: (_) => setState(() {}),
      onSelected: (value) => setState(() => _selectedCategory = value),
    );
  }

  Widget _buildTableSection(List<Expense> expenses) {
    final filtered = _filteredExpenses(expenses);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 1200,
          child: Column(
            children: [
              Container(
                color: AppColors.surfaceLight,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
                child: const Row(
                  children: [
                    Expanded(flex: 3, child: Text('المصروف')),
                    Expanded(flex: 2, child: Text('التصنيف')),
                    Expanded(flex: 2, child: Text('التاريخ')),
                    Expanded(flex: 2, child: Text('المبلغ')),
                    Expanded(flex: 2, child: Text('الحالة')),
                    SizedBox(width: 160, child: Text('الإجراءات')),
                  ],
                ),
              ),
              if (filtered.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(32),
                  child: Text(
                    'لا توجد مصروفات مطابقة',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                )
              else
                ...filtered.map(
                  (expense) => ExpenseRow(
                    expense: expense,
                    onView: () => showDialog<void>(
                      context: context,
                      builder: (_) => ExpenseDetailsDialog(expense: expense),
                    ),
                    onEdit: () => _editExpense(expense),
                    onDelete: () => _deleteExpense(expense),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
