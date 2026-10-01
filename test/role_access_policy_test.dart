import 'package:cashier_app_v2/core/constants/app_routes.dart';
import 'package:cashier_app_v2/features/auth/domain/role_access_policy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('admin and manager can access every route', () {
    expect(RoleAccessPolicy.routesForRole('admin'), AppRoutes.order);
    expect(RoleAccessPolicy.routesForRole('manager'), AppRoutes.order);
  });

  test('cashier can access only POS and their own details', () {
    expect(RoleAccessPolicy.routesForRole('cashier'), [
      AppRoutes.pos,
      AppRoutes.myDetails,
    ]);
    expect(RoleAccessPolicy.routesForRole(' cashier '), [
      AppRoutes.pos,
      AppRoutes.myDetails,
    ]);
  });

  test('unknown roles receive no screen access', () {
    expect(RoleAccessPolicy.routesForRole('auditor'), isEmpty);
    expect(RoleAccessPolicy.routesForRole(null), isEmpty);
  });
}
