import 'package:cashier_app_v2/features/dashbord/data/models/dashboard_model.dart';
import 'package:cashier_app_v2/features/dashbord/domain/repositories/dashboard_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetDashboard {
  final DashboardRepository _repository;

  GetDashboard(this._repository);

  Future<DashboardModel> call() {
    return _repository.getDashboard();
  }

  Stream<DashboardModel> watch() {
    return _repository.watchDashboardData();
  }
}