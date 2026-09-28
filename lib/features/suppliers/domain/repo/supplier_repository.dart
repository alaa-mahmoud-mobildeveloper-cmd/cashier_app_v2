

import '../../../../core/database/app_database.dart';

abstract class SupplierRepository {
  Stream<List<Supplier>> watchSuppliers();

  Future<int> addSupplier({
    required String name,
    String? phone,
    String? address,
  });

  Future<void> updateSupplier(Supplier supplier);

  Future<void> deleteSupplier(int id);
}