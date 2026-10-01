import 'package:cashier_app_v2/core/constants/app_routes.dart';

class RoleAccessPolicy {
  const RoleAccessPolicy._();

  static List<String> routesForRole(String? rawRole) {
    switch (rawRole?.trim().toLowerCase()) {
      case 'admin':
      case 'manager':
        return AppRoutes.order;
      case 'cashier':
        return const [AppRoutes.pos, AppRoutes.myDetails];
      default:
        return const [];
    }
  }
}
