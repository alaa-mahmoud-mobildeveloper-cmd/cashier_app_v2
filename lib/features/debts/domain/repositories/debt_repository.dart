import '../entities/debt_invoice.dart';

abstract class DebtRepository {
  Stream<List<DebtInvoice>> watchDebts();

  Future<List<DebtInvoice>> getDebts();

  Future<void> payDebt({
    required int invoiceId,
    required double amount,
    int? paymentAccountId,
  });
}
