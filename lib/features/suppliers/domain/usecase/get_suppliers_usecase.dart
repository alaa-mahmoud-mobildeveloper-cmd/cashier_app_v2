import 'package:injectable/injectable.dart';

import '../../../../core/database/app_database.dart';

import '../repo/supplier_repository.dart';

@injectable
class GetSuppliersUseCase {
  final SupplierRepository repository;

  GetSuppliersUseCase(this.repository);

  Stream<List<Supplier>> call() {
    return repository.watchSuppliers();
  }
}