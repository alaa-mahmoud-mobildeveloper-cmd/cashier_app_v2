import 'package:injectable/injectable.dart';

import '../repositories/purchase_repository.dart';

@injectable
class CollectPurchasePayment {
  const CollectPurchasePayment(this._repository);

  final PurchaseRepository _repository;

  Future<void> call({
    required int purchaseId,
    required double amount,
    String paymentMethod = 'cash',
    String? note,
  }) {
    return _repository.collectPurchasePayment(
      purchaseId: purchaseId,
      amount: amount,
      paymentMethod: paymentMethod,
      note: note,
    );
  }
}