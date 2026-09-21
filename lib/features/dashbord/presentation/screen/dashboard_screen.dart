import 'package:cashier_app_v2/features/dashbord/presentation/bloc/dash_bloc.dart';
import 'package:cashier_app_v2/features/dashbord/presentation/bloc/dash_event.dart';
import 'package:cashier_app_v2/features/dashbord/presentation/bloc/dash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../di.dart';
import '../../data/models/dashboard_model.dart';

import '../widgets/dashboard_header.dart';
import '../widgets/low_stock_table.dart';
import '../widgets/quick_action_button.dart';
import '../widgets/sales_by_category_card.dart';
import '../widgets/sales_trend_card.dart';
import '../widgets/stat_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
        create: (_) => getIt<DashboardBloc>()..add(const LoadDashboard()),
        child: const _DashboardView(),
      ),
    );
  }
}

class _DashboardView extends StatelessWidget {
  const _DashboardView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state is DashboardInitial || state is DashboardLoading) {
              return const _LoadingView();
            }

            if (state is DashboardError) {
              return _ErrorView(
                message: state.message,
                onRetry: () {
                  context.read<DashboardBloc>().add(const LoadDashboard());
                },
              );
            }

            if (state is DashboardLoaded) {
              return _DashboardContent(dashboard: state.dashboard);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

/// عرض مؤشر التحميل
class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.gold,
      ),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  final DashboardModel dashboard;

  const _DashboardContent({required this.dashboard});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 800;

        return RefreshIndicator(
          color: AppColors.gold,
          onRefresh: () async {
            context.read<DashboardBloc>().add(const RefreshDashboard());
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(
              left: compact ? 12 : 28,
              right: compact ? 12 : 28,
              bottom: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DashboardHeader(
                  userName: 'أحمد',
                  // استخدام التاريخ الحالي
                  date: DateTime.now(), // أو DateTime.now() بحسب الـ Widget لديك
                ),
                const SizedBox(height: 16),
                _buildStatsGrid(compact),
                const SizedBox(height: 20),
                _buildChartsRow(compact),
                const SizedBox(height: 24),
                _buildSectionTitle('الإجراءات السريعة'),
                const SizedBox(height: 12),
                _buildQuickActions(compact),
                const SizedBox(height: 20),
                LowStockTable(
                  items: dashboard.lowStockItems,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// عنوان الأقسام الثابت
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }

  /// شبكة الإحصائيات (Stats Grid)
  Widget _buildStatsGrid(bool compact) {
    final cards = [
       StatCard(
        title: 'عملاء اليوم',
        value: '${dashboard.todayCustomers}',
        icon: Icons.people_alt_outlined,
      ),
      StatCard(
        title: 'فواتير اليوم',
        value: '${dashboard.todayInvoices}',
        icon: Icons.receipt_long_outlined,
      ),
      StatCard(
        title: 'ربح اليوم',
        value: '${dashboard.todayProfit.toStringAsFixed(2)} ج',
        icon: Icons.attach_money,
      ),
      StatCard(
        title: 'مبيعات اليوم',
        value: '${dashboard.todaySales.toStringAsFixed(2)} ج',
        icon: Icons.trending_up,
      ),
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

  /// صف الرسومات البيانية (Charts Row)
  Widget _buildChartsRow(bool compact) {
    final donut = SalesByCategoryCard(
      categories: dashboard.salesByCategory,
    );

    final trend = SalesTrendCard(
      values: dashboard.weeklySales,
      labels: dashboard.weekLabels,
    );

    if (compact) {
      return Column(
        children: [
          donut,
          const SizedBox(height: 16),
          trend,
        ],
      );
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

  /// شبكة الإجراءات السريعة (Quick Actions)
  Widget _buildQuickActions(bool compact) {
    final actions = [
      QuickActionButton(
        label: 'قفلة اليومية',
        icon: Icons.lock_outline,
        onTap: () {},
      ),
      QuickActionButton(
        label: 'إضافة مشتريات',
        icon: Icons.inventory_2_outlined,
        onTap: () {},
      ),
      QuickActionButton(
        label: 'إضافة مصروف',
        icon: Icons.add_circle_outline,
        onTap: () {},
      ),
      QuickActionButton(
        label: 'بيع جديد',
        icon: Icons.shopping_bag_outlined,
        highlighted: true,
        onTap: () {},
      ),
    ];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: compact ? 2 : 4,
      mainAxisSpacing: 14,
      crossAxisSpacing: 14,
      childAspectRatio: compact ? 1.6 : 1.3, // ملاحظة: تم تعديل childAspectRatio ليكون صحيحاً
      // (ملاحظة: تأكد من تمرير الخاصية باسمها الصحيح كالتالي: childAspectRatio: ...)
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              color: AppColors.danger,
              size: 48,
            ),
            const SizedBox(height: 12),
            const Text(
              'حدث خطأ أثناء تحميل لوحة التحكم',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('إعادة المحاولة'),
            ),
          ],
        ),
      ),
    );
  }
}