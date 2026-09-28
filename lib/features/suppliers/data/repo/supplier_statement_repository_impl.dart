import 'package:cashier_app_v2/features/suppliers/domain/entities/supplier_transaction_ui.dart';
import 'package:injectable/injectable.dart';


import '../../domain/entities/supplier_transaction.dart';
import '../../domain/repo/supplier_statement_repository.dart';
import '../datasource/supplier_statement_local_datasource.dart';

@LazySingleton(as: SupplierStatementRepository)
class SupplierStatementRepositoryImpl
    implements SupplierStatementRepository {
  final SupplierStatementLocalDataSource localDataSource;

  SupplierStatementRepositoryImpl(this.localDataSource);

  @override
  Stream<List<SupplierTransaction>> watchSupplierStatement(
      int supplierId,
      ) {
    return localDataSource.watchSupplierStatement(supplierId);
  }

  @override
  Future<void> collectPayment({
    required int purchaseId,
    required double amount,
    required String paymentMethod,
    String? note,
  }) {
    return localDataSource.collectPayment(
      purchaseId: purchaseId,
      amount: amount,
      paymentMethod: paymentMethod,
      note: note,
    );
  }
}