import 'package:cashier_app_v2/features/suppliers/domain/entities/supplier_transaction.dart';
import 'package:injectable/injectable.dart';

import '../entities/supplier_transaction_ui.dart';
import '../repo/supplier_statement_repository.dart';

@injectable
class WatchSupplierStatementUseCase {
  final SupplierStatementRepository repository;

  WatchSupplierStatementUseCase(this.repository);

  Stream<List<SupplierTransaction>> call(int supplierId) {
    return repository.watchSupplierStatement(supplierId);
  }
}