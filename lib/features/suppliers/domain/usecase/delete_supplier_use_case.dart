import 'package:injectable/injectable.dart';

import '../repo/supplier_repository.dart';

@injectable
class DeleteSupplierUseCase {
  final SupplierRepository repository;

  DeleteSupplierUseCase(this.repository);

  Future<void> call(int id) {
    return repository.deleteSupplier(id);
  }
}