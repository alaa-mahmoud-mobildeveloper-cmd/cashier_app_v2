import 'dart:async';

import 'package:cashier_app_v2/features/suppliers/domain/usecase/add_supplier_use_case.dart';
import 'package:cashier_app_v2/features/suppliers/domain/usecase/delete_supplier_use_case.dart';
import 'package:cashier_app_v2/features/suppliers/domain/usecase/get_suppliers_usecase.dart';
import 'package:cashier_app_v2/features/suppliers/domain/usecase/update_supplier_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'suppliers_event.dart';
import 'suppliers_state.dart';

@injectable
class SuppliersBloc extends Bloc<SuppliersEvent, SuppliersState> {
  final GetSuppliersUseCase getSuppliersUseCase;
  final AddSupplierUseCase addSupplierUseCase;
  final UpdateSupplierUseCase updateSupplierUseCase;
  final DeleteSupplierUseCase deleteSupplierUseCase;

  StreamSubscription? _subscription;

  SuppliersBloc(
      this.getSuppliersUseCase,
      this.addSupplierUseCase,
      this.updateSupplierUseCase,
      this.deleteSupplierUseCase,
      ) : super(const SuppliersState()) {
    on<WatchSuppliersEvent>(_onWatch);
    on<SuppliersUpdatedEvent>(_onUpdated);
    on<SuppliersErrorEvent>(_onStreamError);
    on<AddSupplierEvent>(_onAdd);
    on<UpdateSupplierEvent>(_onUpdate);
    on<DeleteSupplierEvent>(_onDelete);
  }

  Future<void> _onWatch(
      WatchSuppliersEvent event,
      Emitter<SuppliersState> emit,
      ) async {
    emit(
      state.copyWith(
        status: SuppliersStatus.loading,
        errorMessage: null,
      ),
    );

    await _subscription?.cancel();

    _subscription = getSuppliersUseCase().listen(
          (suppliers) {
        add(SuppliersUpdatedEvent(suppliers));
      },
      onError: (error) {
        add(
          SuppliersErrorEvent(
            error.toString(),
          ),
        );
      },
    );
  }

  void _onUpdated(
      SuppliersUpdatedEvent event,
      Emitter<SuppliersState> emit,
      ) {
    emit(
      state.copyWith(
        status: SuppliersStatus.success,
        suppliers: event.suppliers,
        errorMessage: null,
      ),
    );
  }

  void _onStreamError(
      SuppliersErrorEvent event,
      Emitter<SuppliersState> emit,
      ) {
    emit(
      state.copyWith(
        status: SuppliersStatus.failure,
        errorMessage: event.message,
      ),
    );
  }

  Future<void> _onAdd(
      AddSupplierEvent event,
      Emitter<SuppliersState> emit,
      ) async {
    try {
      await addSupplierUseCase(
        name: event.name,
        phone: event.phone,
        address: event.address,
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: SuppliersStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onUpdate(
      UpdateSupplierEvent event,
      Emitter<SuppliersState> emit,
      ) async {
    try {
      await updateSupplierUseCase(event.supplier);
    } catch (e) {
      emit(
        state.copyWith(
          status: SuppliersStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onDelete(
      DeleteSupplierEvent event,
      Emitter<SuppliersState> emit,
      ) async {
    try {
      await deleteSupplierUseCase(event.id);
    } catch (e) {
      emit(
        state.copyWith(
          status: SuppliersStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}