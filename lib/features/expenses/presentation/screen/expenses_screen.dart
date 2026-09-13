import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
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

  final List<Expense> _expenses = [
    Expense(
      title: 'إيجار المحل',
      category: 'إيجار',
      description: 'إيجار شهر سبتمبر',
      date: DateTime(2026, 9, 1),
      amount: 3500,
    ),
    Expense(
      title: 'فاتورة الكهرباء',
      category: 'مرافق',
      description: 'استهلاك الكهرباء',
      date: DateTime(2026, 9, 5),
      amount: 850,
    ),
    Expense(
      title: 'شراء أكياس',
      category: 'مشتريات',
      description: 'أكياس بلاستيك وورقية',
      date: DateTime(2026, 9, 7),
      amount: 420,
      status: ExpenseStatus.pending,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  double get _totalExpenses => _expenses.fold(0, (sum, e) => sum + e.amount);

  double get _paidExpenses => _expenses
      .where((e) => e.status == ExpenseStatus.paid)
      .fold(0, (sum, e) => sum + e.amount);

  double get _pendingExpenses => _expenses
      .where((e) => e.status == ExpenseStatus.pending)
      .fold(0, (sum, e) => sum + e.amount);

  String _formatMoney(double value) => '${value.toStringAsFixed(2)} ج';

  List<Expense> get _filteredExpenses {
    final query = _searchController.text.trim().toLowerCase();
    return _expenses.where((expense) {
      final matchesCategory = _selectedCategory == 'الكل' || expense.category == _selectedCategory;
      final matchesQuery = query.isEmpty ||
          expense.title.toLowerCase().contains(query) ||
          expense.description.toLowerCase().contains(query);
      return matchesCategory && matchesQuery;
    }).toList();
  }

  Future<void> _addExpense() async {
    final expense = await showDialog<Expense>(
      context: context,
      builder: (_) => const AddExpenseDialog(),
    );
    if (expense != null && mounted) {
      setState(() => _expenses.add(expense));
    }
  }

  Future<void> _editExpense(Expense oldExpense) async {
    final updated = await showDialog<Expense>(
      context: context,
      builder: (_) => AddExpenseDialog(expense: oldExpense),
    );
    if (updated != null && mounted) {
      setState(() {
        final index = _expenses.indexOf(oldExpense);
        if (index >= 0) _expenses[index] = updated;
      });
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

    if (confirmed == true && mounted) {
      setState(() => _expenses.remove(expense));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: LayoutBuilder(
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
                    _buildSummarySection(isCompact),
                    const SizedBox(height: 16),
                    _buildFiltersSection(),
                    const SizedBox(height: 12),
                    _buildTableSection(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSummarySection(bool isCompact) {
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
          value: _formatMoney(_totalExpenses),
          color: AppColors.gold,
          icon: Icons.account_balance_wallet_outlined,
        ),
        ExpenseSummaryCard(
          title: 'المصروفات المدفوعة',
          value: _formatMoney(_paidExpenses),
          color: AppColors.success,
          icon: Icons.check_circle_outline,
        ),
        ExpenseSummaryCard(
          title: 'المصروفات المعلقة',
          value: _formatMoney(_pendingExpenses),
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

  Widget _buildTableSection() {
    final filtered = _filteredExpenses;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 1050,
          child: Column(
            children: [
              Container(
                color: AppColors.surfaceLight,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
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
                    onView: () => showDialog(
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