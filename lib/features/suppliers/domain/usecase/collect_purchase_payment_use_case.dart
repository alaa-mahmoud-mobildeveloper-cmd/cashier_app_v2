import 'package:injectable/injectable.dart';

import '../repo/supplier_statement_repository.dart';

@injectable
class CollectPurchasePaymentUseCase {
  final SupplierStatementRepository repository;

  CollectPurchasePaymentUseCase(this.repository);

  Future<void> call({
    required int purchaseId,
    required double amount,
    required String paymentMethod,
    String? note,
  }) {
    return repository.collectPayment(
      purchaseId: purchaseId,
      amount: amount,
      paymentMethod: paymentMethod,
      note: note,
    );
  }
}