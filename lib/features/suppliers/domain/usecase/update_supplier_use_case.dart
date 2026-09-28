import 'package:injectable/injectable.dart';
import '../../../../core/database/app_database.dart';
import '../repo/supplier_repository.dart';

@injectable
class UpdateSupplierUseCase {
  final SupplierRepository repository;

  UpdateSupplierUseCase(this.repository);

  Future<void> call(Supplier supplier) {
    return repository.updateSupplier(supplier);
  }
}