
import 'package:cashier_app_v2/features/purchases/domian/entities/details_invoice.dart';
import 'package:cashier_app_v2/features/purchases/domian/entities/save_purchase_params.dart';
import 'package:cashier_app_v2/features/purchases/domian/repositories/purchase_repository.dart';
import 'package:injectable/injectable.dart';

import '../../domian/entities/purchase_invoice.dart';
import '../datasources/purchase_local_datasource.dart';

@LazySingleton(as: PurchaseRepository)
class PurchaseRepositoryImpl implements PurchaseRepository {
PurchaseRepositoryImpl(this._local);

final PurchaseLocalDataSource _local;

@override
Future<void> savePurchase(SavePurchaseParams params) {
return _local.savePurchase(params);
}

@override
Stream<List<PurchaseInvoice>> watchPurchaseInvoices() {
  return _local.watchPurchaseInvoices();
}

  @override
  Future<PurchaseInvoiceDetails> getPurchaseInvoiceDetails(int invoiceId) {
    return _local.getPurchaseInvoiceDetails(invoiceId);
  }

@override
Future<void> collectPurchasePayment({
  required int purchaseId,
  required double amount,
  String paymentMethod = 'cash',
  String? note,
}) {
  return _local.collectPurchasePayment(
    purchaseId: purchaseId,
    amount: amount,
    paymentMethod: paymentMethod,
    note: note,
  );
}
}
