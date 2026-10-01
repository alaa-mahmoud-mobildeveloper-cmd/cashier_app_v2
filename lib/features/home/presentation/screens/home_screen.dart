import 'package:cashier_app_v2/core/constants/app_colors.dart';
import 'package:cashier_app_v2/core/constants/app_routes.dart';
import 'package:cashier_app_v2/di.dart';
import 'package:cashier_app_v2/features/auth/domain/role_access_policy.dart';
import 'package:cashier_app_v2/features/auth/domain/session_provider.dart';
import 'package:cashier_app_v2/features/closing/presentation/screen/closing_screen.dart';
import 'package:cashier_app_v2/features/dashbord/presentation/screen/dashboard_screen.dart';
import 'package:cashier_app_v2/features/debts/presentation/screen/debts_screen.dart';
import 'package:cashier_app_v2/features/expenses/presentation/screen/expenses_screen.dart';
import 'package:cashier_app_v2/features/home/presentation/screens/my_details_screen.dart';
import 'package:cashier_app_v2/features/inventory/presentation/screen/products_screen.dart';
import 'package:cashier_app_v2/features/pos/presentation/screen/pos_screen.dart';
import 'package:cashier_app_v2/features/payment_accounts/presentation/screens/payment_accounts_screen.dart';
import 'package:cashier_app_v2/features/purchases/presentation/screen/purchases_invoice_screen.dart';
import 'package:cashier_app_v2/features/reports/presentation/screen/sales_report_screen.dart';
import 'package:cashier_app_v2/features/suppliers/presentation/screens/suppliers_screen.dart';
import 'package:cashier_app_v2/features/workers/presentation/screen/workers_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/sidebar_menu.dart';

/// الشاشة الرئيسية المسؤولة عن التنقل بين الشاشات المسموح بها لدور المستخدم.
class HomeScreen extends StatefulWidget {
  final VoidCallback? onLogout;

  const HomeScreen({super.key, this.onLogout});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SessionProvider _session = getIt<SessionProvider>();
  String _selectedRoute = AppRoutes.pos;

  List<String> get _visibleRoutes =>
      RoleAccessPolicy.routesForRole(_session.currentRole);

  String get _currentRoute {
    final routes = _visibleRoutes;
    if (routes.isEmpty) return '';
    return routes.contains(_selectedRoute) ? _selectedRoute : routes.first;
  }

  String get _roleLabel => switch (_session.currentRole) {
    'admin' => 'مدير النظام',
    'manager' => 'مدير',
    'cashier' => 'كاشير',
    _ => 'مستخدم',
  };

  void _onNavigate(String route) {
    if (!_visibleRoutes.contains(route)) return;
    setState(() => _selectedRoute = route);
  }

  Widget _screenForRoute(String route) {
    return switch (route) {
      AppRoutes.pos => const PosScreen(),
      AppRoutes.debts => const DebtsScreen(),
      AppRoutes.dashboard => const DashboardScreen(),
      AppRoutes.reports => const SalesReportScreen(),
      AppRoutes.inventory => const ProductsScreen(),
      AppRoutes.purchases => const PurchaseInvoicesScreen(),
      AppRoutes.suppliers => const SuppliersScreen(),
      AppRoutes.workers => const WorkersScreen(),
      AppRoutes.expenses => const ExpensesScreen(),
      AppRoutes.paymentAccounts => const PaymentAccountsScreen(),
      AppRoutes.closing => const ClosingScreen(),
      AppRoutes.myDetails => const MyDetailsScreen(),
      _ => const Center(child: Text('هذه الشاشة غير متاحة')),
    };
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.sizeOf(context).width > 900;
    final hasRoutes = _visibleRoutes.isNotEmpty;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: isDesktop
          ? null
          : AppBar(
              backgroundColor: AppColors.surfaceLight,
              title: const Text('سوبر ماركت'),
              actions: [
                IconButton(
                  onPressed: widget.onLogout,
                  tooltip: 'تسجيل الخروج',
                  icon: const Icon(Icons.logout),
                ),
              ],
            ),
      drawer: !isDesktop && hasRoutes ? Drawer(child: _buildSidebar()) : null,
      body: isDesktop
          ? Column(
              children: [
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(end: 16, top: 4),
                    child: TextButton.icon(
                      onPressed: widget.onLogout,
                      icon: const Icon(Icons.logout),
                      label: const Text('تسجيل الخروج'),
                    ),
                  ),
                ),
                Expanded(child: _buildWorkspace(isDesktop)),
              ],
            )
          : _buildWorkspace(isDesktop),
    );
  }

  Widget _buildSidebar() {
    return SidebarMenu(
      currentRoute: _currentRoute,
      allowedRoutes: _visibleRoutes,
      userName: _session.currentFullName ?? 'المستخدم',
      userRole: _roleLabel,
      onNavigate: (route) {
        _onNavigate(route);
        Navigator.of(context).pop();
      },
    );
  }

  Widget _buildWorkspace(bool isDesktop) {
    final routes = _visibleRoutes;
    if (routes.isEmpty) {
      return const Center(
        child: Text(
          'لا توجد صلاحيات مخصصة لهذا الحساب',
          style: TextStyle(color: AppColors.textSecondary),
        ),
      );
    }

    final selectedIndex = routes.indexOf(_currentRoute);
    return Row(
      children: [
        if (isDesktop)
          SidebarMenu(
            currentRoute: _currentRoute,
            allowedRoutes: routes,
            userName: _session.currentFullName ?? 'المستخدم',
            userRole: _roleLabel,
            onNavigate: _onNavigate,
          ),
        if (isDesktop) const VerticalDivider(width: 1, color: Colors.white12),
        Expanded(
          child: IndexedStack(
            index: selectedIndex,
            children: [
              for (final route in routes)
                KeyedSubtree(
                  key: ValueKey(route),
                  child: _screenForRoute(route),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
