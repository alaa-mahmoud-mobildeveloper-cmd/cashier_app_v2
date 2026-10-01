import 'package:cashier_app_v2/core/constants/app_routes.dart';
import 'package:cashier_app_v2/features/auth/domain/role_access_policy.dart';
import 'package:cashier_app_v2/features/home/presentation/widgets/sidebar_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildSidebar(String role) {
    return MaterialApp(
      home: SizedBox(
        height: 900,
        width: 360,
        child: SidebarMenu(
          currentRoute: AppRoutes.pos,
          allowedRoutes: RoleAccessPolicy.routesForRole(role),
          userName: 'Test User',
          userRole: role,
          onNavigate: (_) {}, onLogout: () {},
        ),
      ),
    );
  }

  testWidgets('cashier sees only POS and personal details', (tester) async {
    await tester.pumpWidget(buildSidebar('cashier'));

    expect(find.text('الكاشير'), findsOneWidget);
    expect(find.text('تفاصيلي'), findsOneWidget);
    expect(find.text('الآجل والمديونيات'), findsNothing);
    expect(find.text('الإدارة'), findsNothing);
    expect(find.text('العمال'), findsNothing);
  });

  testWidgets('manager sees management screens and personal details', (
    tester,
  ) async {
    await tester.pumpWidget(buildSidebar('manager'));

    expect(find.text('الكاشير'), findsOneWidget);
    expect(find.text('لوحة التحكم'), findsOneWidget);
    expect(find.text('العمال'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('تفاصيلي'),
      250,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('تفاصيلي'), findsOneWidget);
  });
}
