import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../pos/presentation/screens/pos_screen.dart';

import '../widgets/sidebar_menu.dart';
import '../widgets/dashboard_placeholder.dart';

/// فيتشر "home" هو المسؤول عن التنقل بين كل الفيتشرز - بدل ما يكون
/// التنقل في مجلد presentation/shell منفصل بره الـ features.
/// أي فيتشر جديد تضيفه، بتسجله هنا في _screens بس، والـ Sidebar
/// (اللي هو widget جوه نفس فيتشر home) بيبعت اسم الـ route المختار.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // الترتيب هنا لازم يطابق ترتيب AppRoutes.order بالظبط
  final List<Widget> _screens = const [
    PosScreen(),
    DashboardPlaceholder(),

  ];

  void _onNavigate(String route) {
    setState(() => _selectedIndex = AppRoutes.order.indexOf(route));
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;

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
                currentRoute: AppRoutes.order[_selectedIndex],
                onNavigate: (route) {
                  _onNavigate(route);
                  Navigator.pop(context);
                },
              ),
            ),
      body: Row(
        children: [
          if (isDesktop)
            SidebarMenu(currentRoute: AppRoutes.order[_selectedIndex], onNavigate: _onNavigate),
          if (isDesktop) const VerticalDivider(width: 1, color: Colors.white12),
          Expanded(
            child: IndexedStack(index: _selectedIndex, children: _screens),
          ),
        ],
      ),
    );
  }
}
