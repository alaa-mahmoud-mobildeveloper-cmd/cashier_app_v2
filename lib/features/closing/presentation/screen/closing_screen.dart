import 'package:cashier_app_v2/core/database/app_database.dart';
import 'package:cashier_app_v2/di.dart';
import 'package:cashier_app_v2/features/auth/domain/session_provider.dart';
import 'package:cashier_app_v2/features/closing/data/model/payment_balance_model.dart';
import 'package:cashier_app_v2/features/payment_accounts/data/payment_account_repository.dart';
import 'package:flutter/material.dart';
import 'package:drift/drift.dart' hide Column;

import '../../../../core/constants/app_breakpoints.dart';
import '../../../../core/constants/app_colors.dart';
import '../widgets/closing_header.dart';
import '../widgets/closing_notes_card.dart';
import '../widgets/closing_sidebar.dart';
import '../widgets/closing_summary_card.dart';
import '../widgets/payment_balances_section.dart';
import '../widgets/save_closing_button.dart';

class ClosingScreen extends StatefulWidget {
  const ClosingScreen({super.key});

  @override
  State<ClosingScreen> createState() => _ClosingScreenState();
}

class _ClosingScreenState extends State<ClosingScreen> {
  final _notesController = TextEditingController();
  final _database = getIt<AppDatabase>();
  late final List<PaymentBalanceModel> _balances = [];
  bool _loading = true;
  bool _saving = false;
  bool _closed = false;
  List<DailyClosing> _history = [];
  double _sales = 0, _creditPayments = 0, _expenses = 0, _cashMovement = 0;
  int _invoiceCount = 0;

  DateTime get _day =>
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime get _tomorrow => _day.add(const Duration(days: 1));

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final existing = await (_database.select(
        _database.dailyClosings,
      )..where((row) => row.date.equals(_day))).getSingleOrNull();
      _history = await (_database.select(
        _database.dailyClosings,
      )..orderBy([(row) => OrderingTerm.desc(row.date)])).get();
      final invoices =
          await (_database.select(_database.invoices)..where(
                (row) =>
                    row.createdAt.isBiggerOrEqualValue(_day) &
                    row.createdAt.isSmallerThanValue(_tomorrow),
              ))
              .get();
      final debtPayments =
          await (_database.select(_database.debtPayments)..where(
                (row) =>
                    row.createdAt.isBiggerOrEqualValue(_day) &
                    row.createdAt.isSmallerThanValue(_tomorrow),
              ))
              .get();
      final expenses =
          await (_database.select(_database.expenses)..where(
                (row) =>
                    row.expenseDate.isBiggerOrEqualValue(_day) &
                    row.expenseDate.isSmallerThanValue(_tomorrow),
              ))
              .get();
      final entries =
          await (_database.select(_database.paymentAccountTransactions)..where(
                (row) =>
                    row.createdAt.isBiggerOrEqualValue(_day) &
                    row.createdAt.isSmallerThanValue(_tomorrow),
              ))
              .get();
      final accounts = await PaymentAccountRepository(
        _database,
      ).getActiveAccounts(type: 'wallet');
      final allAccounts = [
        ...accounts,
        ...await PaymentAccountRepository(
          _database,
        ).getActiveAccounts(type: 'visa'),
        ...await PaymentAccountRepository(
          _database,
        ).getActiveAccounts(type: 'fawry'),
      ];
      _sales = invoices
          .where((i) => i.status != 'returned')
          .fold(0, (v, i) => v + i.netAmount);
      _invoiceCount = invoices.where((i) => i.status != 'returned').length;
      _creditPayments = debtPayments.fold(0, (v, p) => v + p.amount);
      _expenses = expenses
          .where((e) => e.status == 'paid')
          .fold(0, (v, e) => v + e.amount);
      _cashMovement = invoices
          .where((i) => i.status != 'returned' && i.paymentMethod == 'cash')
          .fold(0, (v, i) => v + i.paidAmount);
      _cashMovement += debtPayments
          .where((p) => p.paymentAccountId == null)
          .fold(0, (v, p) => v + p.amount);
      _cashMovement -= expenses
          .where((e) => e.status == 'paid' && e.paymentAccountId == null)
          .fold(0, (v, e) => v + e.amount);
      _balances
        ..clear()
        ..add(
          PaymentBalanceModel(
            title: 'الكاش',
            icon: Icons.payments_outlined,
            color: AppColors.success,
            systemMovement: _cashMovement,
          ),
        )
        ..addAll(
          allAccounts.map((account) {
            final movement = entries
                .where((e) => e.accountId == account.id)
                .fold<double>(
                  0,
                  (v, e) =>
                      v +
                      (e.kind == 'withdrawal' || e.kind == 'refund'
                          ? -e.amount
                          : e.amount),
                );
            return PaymentBalanceModel(
              title: account.displayLabel,
              subtitle: account.typeLabel,
              icon: Icons.account_balance_wallet_outlined,
              color: AppColors.gold,
              accountId: account.id,
              systemMovement: movement,
            );
          }),
        );
      if (existing != null) {
        _closed = existing.isClosed;
        _notesController.text = existing.note ?? '';
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _save() async {
    if (_closed) return;
    setState(() => _saving = true);
    try {
      final expected = _balances.fold(0.0, (v, b) => v + b.expectedBalance);
      final actual = _balances.fold(0.0, (v, b) => v + b.actualBalance);
      await _database
          .into(_database.dailyClosings)
          .insert(
            DailyClosingsCompanion.insert(
              date: _day,
              totalSales: Value(_sales),
              totalExpenses: Value(_expenses),
              cashBalance: Value(actual),
              posBalance: Value(
                _balances
                    .where((b) => b.title.contains('فيزا'))
                    .fold(0.0, (v, b) => v + b.actualBalance),
              ),
              walletBalance: Value(
                _balances
                    .where((b) => b.accountId != null)
                    .fold(0.0, (v, b) => v + b.actualBalance),
              ),
              expectedBalance: Value(expected),
              difference: Value(actual - expected),
              note: Value(
                _notesController.text.trim().isEmpty
                    ? null
                    : _notesController.text.trim(),
              ),
              userName: Value(getIt<SessionProvider>().currentFullName),
              isClosed: const Value(true),
            ),
          );
      if (mounted) {
        final history = await (_database.select(
          _database.dailyClosings,
        )..orderBy([(row) => OrderingTerm.desc(row.date)])).get();
        setState(() {
          _closed = true;
          _saving = false;
          _history = history;
        });
        _message('تم حفظ قفلة اليوم بنجاح');
      }
    } catch (error) {
      if (mounted) {
        setState(() => _saving = false);
        _message(
          error.toString().contains('UNIQUE')
              ? 'تم إغلاق هذا اليوم مسبقًا'
              : 'تعذر حفظ القفلة: $error',
        );
      }
    }
  }

  void _message(String text) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Center(child: CircularProgressIndicator());
    final expected = _balances.fold(0.0, (v, b) => v + b.expectedBalance);
    final actual = _balances.fold(0.0, (v, b) => v + b.actualBalance);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: LayoutBuilder(
          builder: (_, c) {
            final compact = c.maxWidth < AppBreakpoints.desktop;
            final content = SingleChildScrollView(
              padding: EdgeInsets.all(
                c.maxWidth < AppBreakpoints.mobile ? 12 : 28,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClosingHeader(
                    date: DateTime.now(),
                    todayNet: _sales - _expenses,
                    todayInvoices: _invoiceCount,
                    showStats: !compact,
                  ),
                  const SizedBox(height: 20),
                  PaymentBalancesSection(
                    balances: _balances,
                    onChanged: () => setState(() {}),
                  ),
                  const SizedBox(height: 20),
                  ClosingSummaryCard(
                    sales: _sales,
                    creditPayments: _creditPayments,
                    purchases: 0,
                    expenses: _expenses,
                    recharge: 0,
                    net: _sales - _expenses,
                    actualBalance: actual,
                    expectedBalance: expected,
                  ),
                  const SizedBox(height: 16),
                  ClosingNotesCard(controller: _notesController),
                  const SizedBox(height: 20),
                  SaveClosingButton(onPressed: _save, isLoading: _saving),
                ],
              ),
            );
            return compact
                ? content
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClosingSidebar(closings: _history),
                      Expanded(child: content),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
