import 'package:cashier_app_v2/core/constants/app_breakpoints.dart';
import 'package:cashier_app_v2/features/closing/data/model/payment_balance_model.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../widgets/add_closing_row_button.dart';
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
  final TextEditingController notesController = TextEditingController();
  late final List<PaymentBalanceModel> balances;

  @override
  void initState() {
    super.initState();
    balances = [
      PaymentBalanceModel(
        title: 'الكاش',
        icon: Icons.payments_outlined,
        color: AppColors.success,
        openingBalance: 500,
      ),
      PaymentBalanceModel(
        title: 'استبيالي',
        icon: Icons.phone_android_outlined,
        color: AppColors.goldLight,
      ),
      PaymentBalanceModel(
        title: 'ماي فوري',
        icon: Icons.wifi_outlined,
        color: AppColors.goldDark,
      ),
      PaymentBalanceModel(
        title: 'ماكينة شحن',
        icon: Icons.bolt,
        color: AppColors.warning,
      ),
    ];
  }

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            if (width < AppBreakpoints.mobile) {
              return _buildMobileLayout();
            }
            if (width < AppBreakpoints.desktop) {
              return _buildTabletLayout();
            }
            return _buildDesktopLayout();
          },
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        const ClosingSidebar(),
        Expanded(
          child: _buildMainContent(
            screenType: _ScreenType.desktop,
          ),
        ),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return _buildMainContent(
      screenType: _ScreenType.tablet,
    );
  }

  Widget _buildMobileLayout() {
    return _buildMainContent(
      screenType: _ScreenType.mobile,
    );
  }

  Widget _buildMainContent({
    required _ScreenType screenType,
  }) {
    final isMobile = screenType == _ScreenType.mobile;
    final isTablet = screenType == _ScreenType.tablet;
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile
                ? 12
                : isTablet
                ? 20
                : 32,
            vertical: isMobile ? 8 : 0,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(screenType: screenType),
                SizedBox(
                  height: isMobile
                      ? 18
                      : isTablet
                      ? 22
                      : 28,
                ),
                _buildPaymentBalances(),
                SizedBox(height: isMobile ? 14 : 18),
                _buildAddButton(isMobile: isMobile),
                SizedBox(
                  height: isMobile
                      ? 18
                      : isTablet
                      ? 20
                      : 24,
                ),
                _buildBottomSection(screenType: screenType),
                SizedBox(height: isMobile ? 18 : 24),
                _buildSaveButton(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader({
    required _ScreenType screenType,
  }) {
    return ClosingHeader(
      date: DateTime.now(),
      todayNet: 0,
      todayInvoices: 0,
      showStats: screenType != _ScreenType.mobile,
    );
  }

  Widget _buildPaymentBalances() {
    return PaymentBalancesSection(
      balances: balances,
      onChanged: () {
        setState(() {});
      },
    );
  }

  Widget _buildAddButton({
    required bool isMobile,
  }) {
    if (isMobile) {
      return SizedBox(
        width: double.infinity,
        child: AddClosingRowButton(
          onPressed: _addBalance,
        ),
      );
    }
    return Align(
      alignment: Alignment.centerRight,
      child: AddClosingRowButton(
        onPressed: _addBalance,
      ),
    );
  }

  Widget _buildBottomSection({
    required _ScreenType screenType,
  }) {
    if (screenType == _ScreenType.mobile) {
      return _buildMobileBottomSection();
    }
    if (screenType == _ScreenType.tablet) {
      return _buildTabletBottomSection();
    }
    return _buildDesktopBottomSection();
  }

  Widget _buildMobileBottomSection() {
    return Column(
      children: [
        SizedBox(
          height: 420,
          child: ClosingSummaryCard(
            sales: 0,
            creditPayments: 0,
            purchases: 0,
            expenses: 0,
            recharge: 0,
            net: 0,
            actualBalance: 0,
            expectedBalance: 0,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 340,
          child: ClosingNotesCard(
            controller: notesController,
          ),
        ),
      ],
    );
  }

  Widget _buildTabletBottomSection() {
    return Column(
      children: [
        SizedBox(
          height: 400,
          child: ClosingSummaryCard(
            sales: 0,
            creditPayments: 0,
            purchases: 0,
            expenses: 0,
            recharge: 0,
            net: 0,
            actualBalance: 0,
            expectedBalance: 0,
          ),
        ),
        const SizedBox(height: 18),
        SizedBox(
          height: 330,
          child: ClosingNotesCard(
            controller: notesController,
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopBottomSection() {
    return SizedBox(
      height: 430,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClosingSummaryCard(
              sales: 0,
              creditPayments: 0,
              purchases: 0,
              expenses: 0,
              recharge: 0,
              net: 0,
              actualBalance: 0,
              expectedBalance: 0,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: ClosingNotesCard(
              controller: notesController,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return SaveClosingButton(
      onPressed: _saveClosing,
    );
  }

  void _addBalance() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: const Text('إضافة وسيلة دفع'),
            content: TextField(
              controller: controller,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'اسم الوسيلة',
                hintText: 'مثال: محفظة',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('إلغاء'),
              ),
              ElevatedButton(
                onPressed: () {
                  final name = controller.text.trim();
                  if (name.isEmpty) {
                    return;
                  }
                  setState(() {
                    balances.add(
                      PaymentBalanceModel(
                        title: name,
                        icon: Icons.account_balance_wallet_outlined,
                        color: AppColors.gold,
                      ),
                    );
                  });
                  Navigator.pop(context);
                },
                child: const Text('إضافة'),
              ),
            ],
          ),
        );
      },
    ).then((_) {
      controller.dispose();
    });
  }

  void _saveClosing() {}
}

enum _ScreenType {
  mobile,
  tablet,
  desktop,
}