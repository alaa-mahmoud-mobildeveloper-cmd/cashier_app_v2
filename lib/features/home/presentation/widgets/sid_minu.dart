import 'package:cashier_app_v2/features/home/presentation/widgets/drawer_header_widget.dart';
import 'package:cashier_app_v2/features/home/presentation/widgets/drawer_item.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeaderWidget(),
            DrawerItem(icon: Icons.shopping_cart_outlined, label: 'الكاشير'),
            DrawerItem(icon: Icons.inventory_2_outlined, label: 'إدارة الأصناف'),
            DrawerItem(icon: Icons.show_chart, label: 'تقرير المبيعات'),
            Divider(),
            DrawerItem(icon: Icons.logout, label: 'تسجيل الخروج', isDanger: true),
          ],
        ),
      ),
    );
  }
}