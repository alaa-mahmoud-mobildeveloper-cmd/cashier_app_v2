import 'package:cashier_app_v2/core/database/app_database.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repo/supplier_repository.dart';
import '../datasource/supplier_local_datasource.dart';

@LazySingleton(as: SupplierRepository)
class SupplierRepositoryImpl implements SupplierRepository {
  final SupplierLocalDataSource localDataSource;

  SupplierRepositoryImpl(this.localDataSource);

  @override
  Stream<List<Supplier>> watchSuppliers() {
    return localDataSource.watchSuppliers();
  }

  @override
  Future<int> addSupplier({
    required String name,
    String? phone,
    String? address,
  }) {
    return localDataSource.addSupplier(
      name: name,
      phone: phone,
      address: address,
    );
  }

  @override
  Future<void> updateSupplier(Supplier supplier) {
    return localDataSource.updateSupplier(supplier);
  }

  @override
  Future<void> deleteSupplier(int id) {
    return localDataSource.deleteSupplier(id);
  }
}