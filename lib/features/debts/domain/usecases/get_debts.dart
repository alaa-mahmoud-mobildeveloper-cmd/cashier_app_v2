import 'package:cashier_app_v2/features/debts/domain/entities/debt_invoice.dart';
import 'package:cashier_app_v2/features/debts/domain/repositories/debt_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetDebts {
  final DebtRepository _repository;

  GetDebts(this._repository);

  Future<List<DebtInvoice>> call() {
    return _repository.getDebts();
  }
}