import 'package:injectable/injectable.dart';

import '../repo/supplier_repository.dart';

@injectable
class AddSupplierUseCase {
  final SupplierRepository repository;

  AddSupplierUseCase(this.repository);

  Future<int> call({
    required String name,
    String? phone,
    String? address,
  }) {
    return repository.addSupplier(
      name: name,
      phone: phone,
      address: address,
    );
  }
}