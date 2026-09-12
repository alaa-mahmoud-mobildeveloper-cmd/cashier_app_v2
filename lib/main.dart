import 'package:cashier_app_v2/sidebar_menu.dart';
import 'package:cashier_app_v2/top_header.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showSemanticsDebugger: false,
      home: const MainShell(),
    );
  }
}
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  // نفس ترتيب الشاشات في السايدبار
  final List<Widget> _screens = [
    Container(color:Colors.black,child: Text('POS'),),
    Container(color:Colors.black,child: Text('Debts'),),
    Container(color:Colors.black,child: Text('Dashboard'),),
    Container(color:Colors.black,child: Text('Reports'),),
    Container(color:Colors.black,child: Text('Inventory'),),
    Container(color:Colors.black,child: Text('Workers'),),
    Container(color:Colors.black,child: Text('Expenses'),),
    Container(color:Colors.black,child: Text('Closing'),),
  ];

  final List<String> _routeKeys = [
    'pos', 'debts', 'dashboard', 'reports',
    'inventory', 'workers', 'expenses', 'closing',
  ];

  void _onNavigate(String routeKey) {
    setState(() {
      _selectedIndex = _routeKeys.indexOf(routeKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 1024;

    return Scaffold(
      backgroundColor: Color(0xff393737),
      body: Row(
        children: [
          Expanded(child:
          Drawer(
            child: SidebarMenu(
              currentRoute: _routeKeys[_selectedIndex],
              onNavigate: _onNavigate,
            ),
          ),
          ),
          if (isDesktop)
            SidebarMenu(
              currentRoute: _routeKeys[_selectedIndex],
              onNavigate: _onNavigate,
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Expanded(
                  child: IndexedStack(
                    index: _selectedIndex,
                    children: _screens,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: isDesktop
          ? null
          : Drawer(
        child: SidebarMenu(
          currentRoute: _routeKeys[_selectedIndex],
          onNavigate: (route) {
            _onNavigate(route);
            Navigator.pop(context); // يقفل الـ Drawer بعد الاختيار
          },
        ),
      ),
    );
  }
}