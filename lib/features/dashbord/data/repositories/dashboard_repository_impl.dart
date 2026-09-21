import 'package:cashier_app_v2/features/dashbord/data/datasources/dashboard_local_data_source.dart';
import 'package:cashier_app_v2/features/dashbord/data/models/dashboard_model.dart';
import 'package:cashier_app_v2/features/dashbord/domain/repositories/dashboard_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: DashboardRepository)
class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardLocalDataSource _localDataSource;
  DashboardRepositoryImpl(this._localDataSource);
  @override
  Future<DashboardModel> getDashboard() {
    return _localDataSource.getDashboard();
  }
}