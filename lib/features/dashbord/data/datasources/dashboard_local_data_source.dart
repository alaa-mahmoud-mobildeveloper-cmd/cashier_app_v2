import 'package:cashier_app_v2/features/dashbord/data/models/dashboard_model.dart';

abstract class DashboardLocalDataSource {
  Future<DashboardModel> getDashboard();
}