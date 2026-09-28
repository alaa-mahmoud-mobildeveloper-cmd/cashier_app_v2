
import '../entities/supplier_transaction.dart';
import '../entities/supplier_transaction_ui.dart';

abstract class SupplierStatementRepository {
  Stream<List<SupplierTransaction>> watchSupplierStatement(
      int supplierId,
      );

  Future<void> collectPayment({
    required int purchaseId,
    required double amount,
    required String paymentMethod,
    String? note,
  });
}