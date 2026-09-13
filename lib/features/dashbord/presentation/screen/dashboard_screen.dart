import 'package:cashier_app_v2/features/dashbord/data/models/low_stock_item.dart';
import 'package:cashier_app_v2/features/dashbord/data/models/sales_category.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/low_stock_table.dart';
import '../widgets/quick_action_button.dart';
import '../widgets/sales_by_category_card.dart';
import '../widgets/sales_trend_card.dart';
import '../widgets/stat_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const _weekLabels = ['السبت', 'الأحد', 'الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة'];
  static const _weekValues = [2500.0, 3900.0, 3300.0, 4300.0, 3600.0, 5800.0, 7300.0];

  static final _categories = [
    const SalesCategory(label: 'أخرى', value: 12, color: AppColors.gold),
    SalesCategory(label: 'مواد غذائية', value: 22, color: AppColors.gold.withOpacity(0.85)),
    SalesCategory(label: 'منظفات', value: 15, color: AppColors.gold.withOpacity(0.65)),
    SalesCategory(label: 'مشروبات', value: 18, color: AppColors.gold.withOpacity(0.45)),
    SalesCategory(label: 'ألبان', value: 20, color: AppColors.gold.withOpacity(0.3)),
  ];

  static const _lowStockItems = [
    LowStockItem(name: 'زيت عباد الشمس 1.5 لتر', remaining: '3 كرتون', status: StockStatus.nearingOut),
    LowStockItem(name: 'شاي ليبتون 100 كيس', remaining: '5 علبة', status: StockStatus.nearingOut),
    LowStockItem(name: 'سكر أبيض 1 كجم', remaining: '2 كيس', status: StockStatus.critical),
    LowStockItem(name: 'أرز بسمتي 5 كجم', remaining: '4 كيس', status: StockStatus.nearingOut),
    LowStockItem(name: 'صابون اريال 3 كجم', remaining: '1 علبة', status: StockStatus.critical),
    LowStockItem(name: 'حليب بارمالات 1 لتر', remaining: '7 كرتون', status: StockStatus.nearingOut),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: LayoutBuilder(builder: (context, constraints) {
            final compact = constraints.maxWidth < 800;
            return SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 24, left: compact ? 12 : 28, right: compact ? 12 : 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DashboardHeader(userName: 'احمد', date: DateTime(2026, 9, 13)),
                  const SizedBox(height: 16),
                  _statsGrid(compact),
                  const SizedBox(height: 20),
                  _chartsRow(compact),
                  const SizedBox(height: 24),
                  const Text(
                    'الإجراءات السريعة',
                    style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  _quickActions(compact),
                  const SizedBox(height: 20),
                  LowStockTable(items: _lowStockItems),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _statsGrid(bool compact) {
    const cards = [
      StatCard(title: 'عملاء اليوم', value: '64', deltaLabel: '3%', isPositive: false, icon: Icons.people_outline),
      StatCard(title: 'فواتير اليوم', value: '87', deltaLabel: '5%', isPositive: true, icon: Icons.receipt_long_outlined),
      StatCard(title: 'ربح اليوم', value: '2,040 ج', deltaLabel: '8%', isPositive: true, icon: Icons.attach_money),
      StatCard(title: 'مبيعات اليوم', value: '6,800 ج', deltaLabel: '12%', isPositive: true, icon: Icons.trending_up),
    ];
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: compact ? 2 : 4,
      mainAxisSpacing: 14,
      crossAxisSpacing: 14,
      childAspectRatio: compact ? 1.7 : 1.6,
      children: cards,
    );
  }

  Widget _chartsRow(bool compact) {
    final donut = SalesByCategoryCard(categories: _categories);
    final trend = SalesTrendCard(values: _weekValues, labels: _weekLabels);

    if (compact) {
      return Column(children: [donut, const SizedBox(height: 16), trend]);
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(flex: 2, child: donut),
          const SizedBox(width: 16),
          Expanded(flex: 3, child: trend),
        ],
      ),
    );
  }

  Widget _quickActions(bool compact) {
    final actions = [
      QuickActionButton(label: 'قفلة اليومية', icon: Icons.lock_outline, onTap: () {}),
      QuickActionButton(label: 'إضافة مشتريات', icon: Icons.inventory_2_outlined, onTap: () {}),
      QuickActionButton(label: 'إضافة مصروف', icon: Icons.add_circle_outline, onTap: () {}),
      QuickActionButton(label: 'بيع جديد', icon: Icons.shopping_bag_outlined, highlighted: true, onTap: () {}),
    ];
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: compact ? 2 : 4,
      mainAxisSpacing: 14,
      crossAxisSpacing: 14,
      childAspectRatio: compact ? 1.6 : 1.3,
      children: actions,
    );
  }
}