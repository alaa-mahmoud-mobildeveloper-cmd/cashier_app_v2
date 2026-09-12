import 'package:flutter/material.dart';

class SidebarMenu extends StatelessWidget {
  final String currentRoute;
  final Function(String) onNavigate;

  const SidebarMenu({
    super.key,
    required this.currentRoute,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      color: const Color(0xFF0D0D0D),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4A017),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.shopping_cart, color: Colors.black),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('سوبر ماركت',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    Text('نقطة البيع',
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white12, height: 1),

          _sectionTitle('العمليات'),
          _navItem(icon: Icons.shopping_cart, label: 'الكاشير', route: 'pos'),
          _navItem(icon: Icons.credit_card, label: 'الآجل والمديونيات', route: 'debts'),

          const SizedBox(height: 12),
          _sectionTitle('الإدارة'),
          _navItem(icon: Icons.grid_view, label: 'لوحة التحكم', route: 'dashboard'),
          _navItem(icon: Icons.show_chart, label: 'تقرير المبيعات', route: 'reports'),
          _navItem(icon: Icons.inventory_2_outlined, label: 'إدارة الأصناف', route: 'inventory'),
          _navItem(icon: Icons.people_outline, label: 'العمال', route: 'workers'),
          _navItem(icon: Icons.description_outlined, label: 'إضافة مصروف', route: 'expenses'),
          _navItem(icon: Icons.lock_outline, label: 'قفلة اليومية', route: 'closing'),

          const Spacer(),
          const Divider(color: Colors.white12, height: 1),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Color(0xFFD4A017),
                  child: Icon(Icons.person, color: Colors.black),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('احمد', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                    Text('مدير النظام', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
                const Spacer(),
                const CircleAvatar(
                  radius: 14,
                  backgroundColor: Color(0xFFD4A017),
                  child: Icon(Icons.help_outline, size: 16, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ),
    );
  }

  Widget _navItem({required IconData icon, required String label, required String route}) {
    final bool isActive = currentRoute == route;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Material(
        color: isActive ? const Color(0xFFD4A017).withOpacity(0.15) : Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () => onNavigate(route),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(icon, color: isActive ? const Color(0xFFD4A017) : Colors.grey, size: 20),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: TextStyle(
                    color: isActive ? const Color(0xFFD4A017) : Colors.white70,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}