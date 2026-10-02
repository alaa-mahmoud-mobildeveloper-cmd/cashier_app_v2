import 'package:cashier_app_v2/features/debts/domain/repositories/debt_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class PayDebt {
  final DebtRepository _repository;

  PayDebt(this._repository);

  Future<void> call({
    required int invoiceId,
    required double amount,
    int? paymentAccountId,
  }) {
    return _repository.payDebt(
      invoiceId: invoiceId,
      amount: amount,
      paymentAccountId: paymentAccountId,
    );
  }
}
