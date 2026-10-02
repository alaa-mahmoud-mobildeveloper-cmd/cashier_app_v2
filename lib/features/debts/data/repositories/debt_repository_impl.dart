import 'package:cashier_app_v2/features/debts/domain/entities/debt_invoice.dart';
import 'package:cashier_app_v2/features/debts/domain/repositories/debt_repository.dart';
import 'package:injectable/injectable.dart';

import '../datasources/debt_local_data_source.dart';

@Injectable(as: DebtRepository)
class DebtRepositoryImpl implements DebtRepository {
  final DebtLocalDataSource _dataSource;

  DebtRepositoryImpl(this._dataSource);

  @override
  Stream<List<DebtInvoice>> watchDebts() {
    return _dataSource.watchDebts();
  }

  @override
  Future<List<DebtInvoice>> getDebts() {
    return _dataSource.getDebts();
  }

  @override
  Future<void> payDebt({
    required int invoiceId,
    required double amount,
    int? paymentAccountId,
  }) {
    return _dataSource.payDebt(
      invoiceId: invoiceId,
      amount: amount,
      paymentAccountId: paymentAccountId,
    );
  }
}
