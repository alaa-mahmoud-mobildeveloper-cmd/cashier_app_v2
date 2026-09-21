import 'package:cashier_app_v2/features/dashbord/domain/usecases/get_dashboard.dart';
import 'package:cashier_app_v2/features/dashbord/presentation/bloc/dash_event.dart';
import 'package:cashier_app_v2/features/dashbord/presentation/bloc/dash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetDashboard _getDashboard;
  DashboardBloc(this._getDashboard) : super(const DashboardInitial()) {
    on<LoadDashboard>(_onLoadDashboard);
    on<RefreshDashboard>(_onRefreshDashboard);
  }
  Future<void> _onLoadDashboard( LoadDashboard event, Emitter<DashboardState> emit, ) async {
    await _loadDashboard(emit);
  }
  Future<void> _onRefreshDashboard( RefreshDashboard event, Emitter<DashboardState> emit, ) async {
    await _loadDashboard(emit);
  }
  Future<void> _loadDashboard( Emitter<DashboardState> emit, ) async {
    emit(const DashboardLoading());
    try {
      final dashboard = await _getDashboard();
      emit(DashboardLoaded(dashboard));
    } catch (e) {
      emit( DashboardError( e.toString(), )
        ,
      );
    }
  }
}