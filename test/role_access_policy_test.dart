import 'package:cashier_app_v2/core/constants/app_routes.dart';
import 'package:cashier_app_v2/features/auth/domain/role_access_policy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'admin and manager can access every route, including payment accounts',
    () {
      expect(RoleAccessPolicy.routesForRole('admin'), AppRoutes.order);
      expect(RoleAccessPolicy.routesForRole('manager'), AppRoutes.order);
      expect(
        RoleAccessPolicy.routesForRole('manager'),
        contains(AppRoutes.paymentAccounts),
      );
    },
  );

  test('cashier can access only POS and their own details', () {
    expect(RoleAccessPolicy.routesForRole('cashier'), [
      AppRoutes.pos,
      AppRoutes.myDetails,
    ]);
    expect(RoleAccessPolicy.routesForRole(' cashier '), [
      AppRoutes.pos,
      AppRoutes.myDetails,
    ]);
    expect(
      RoleAccessPolicy.routesForRole('cashier'),
      isNot(contains(AppRoutes.paymentAccounts)),
    );
  });

  test('unknown roles receive no screen access', () {
    expect(RoleAccessPolicy.routesForRole('auditor'), isEmpty);
    expect(RoleAccessPolicy.routesForRole(null), isEmpty);
  });
}
