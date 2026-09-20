import 'package:cashier_app_v2/features/debts/domain/entities/debt_invoice.dart';



abstract class DebtLocalDataSource {
  Stream<List<DebtInvoice>> watchDebts();

  Future<List<DebtInvoice>> getDebts();

  Future<void> payDebt({
    required int invoiceId,
    required double amount,
  });
}