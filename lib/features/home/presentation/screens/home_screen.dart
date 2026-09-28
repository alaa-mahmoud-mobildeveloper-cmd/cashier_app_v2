import 'package:cashier_app_v2/features/dashbord/presentation/screen/dashboard_screen.dart';
import 'package:cashier_app_v2/features/inventory/presentation/screen/products_screen.dart';
import 'package:cashier_app_v2/features/purchases/presentation/screen/purchases_invoice_screen.dart';
import 'package:cashier_app_v2/features/reports/presentation/screen/sales_report_screen.dart';
import 'package:cashier_app_v2/features/suppliers/presentation/screens/suppliers_screen.dart';
import 'package:flutter/material.dart';

import 'package:cashier_app_v2/core/constants/app_colors.dart';
import 'package:cashier_app_v2/core/constants/app_routes.dart';
import 'package:cashier_app_v2/features/closing/presentation/screen/closing_screen.dart';
import 'package:cashier_app_v2/features/debts/presentation/screen/debts_screen.dart';
import 'package:cashier_app_v2/features/expenses/presentation/screen/expenses_screen.dart';
import 'package:cashier_app_v2/features/pos/presentation/screen/pos_screen.dart';
import 'package:cashier_app_v2/features/workers/presentation/screen/workers_screen.dart';

import '../widgets/sidebar_menu.dart';

/// الشاشة الرئيسية المسؤولة عن التنقل بين جميع أقسام التطبيق.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  /// يجب أن يكون ترتيب الشاشات مطابقًا تمامًا لترتيب AppRoutes.order.
  final List<Widget> _screens = [
    const PosScreen(),
    const DebtsScreen(),
    const DashboardScreen(),
    const SalesReportScreen(),
    const ProductsScreen(),
    const PurchaseInvoicesScreen(),
    const SuppliersScreen(),
    const WorkersScreen(),
    const ExpensesScreen(),
    const ClosingScreen(),
  ];

  String get _currentRoute {
    if (_selectedIndex < 0 ||
        _selectedIndex >= AppRoutes.order.length) {
      return AppRoutes.order.first;
    }

    return AppRoutes.order[_selectedIndex];
  }

  void _onNavigate(String route) {
    final index = AppRoutes.order.indexOf(route);

    // تجاهل المسار إذا لم يكن موجودًا في AppRoutes.order
    if (index == -1 || index >= _screens.length) {
      return;
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.sizeOf(context).width > 900;

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: isDesktop
          ? null
          : AppBar(
        backgroundColor: AppColors.surfaceLight,
        title: const Text('سوبر ماركت'),
      ),

      drawer: isDesktop
          ? null
          : Drawer(
        child: SidebarMenu(
          currentRoute: _currentRoute,
          onNavigate: (route) {
            _onNavigate(route);
            Navigator.of(context).pop();
          },
        ),
      ),

      body: Row(
        children: [
          if (isDesktop)
            SidebarMenu(
              currentRoute: _currentRoute,
              onNavigate: _onNavigate,
            ),

          if (isDesktop)
            const VerticalDivider(
              width: 1,
              color: Colors.white12,
            ),

          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: _screens,
            ),
          ),
        ],
      ),
    );
  }
}
