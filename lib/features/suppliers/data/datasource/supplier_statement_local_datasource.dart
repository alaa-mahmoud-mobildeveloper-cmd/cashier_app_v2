import 'package:cashier_app_v2/features/suppliers/domain/entities/supplier_transaction.dart';
import 'package:cashier_app_v2/features/suppliers/domain/entities/supplier_transaction_ui.dart';



abstract class SupplierStatementLocalDataSource {
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