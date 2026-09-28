
import 'package:cashier_app_v2/features/purchases/domian/entities/details_invoice.dart';

import '../entities/purchase_invoice.dart';
import '../entities/save_purchase_params.dart';

abstract class PurchaseRepository {
Future<void> savePurchase(SavePurchaseParams params);
Stream<List<PurchaseInvoice>> watchPurchaseInvoices();

Future<PurchaseInvoiceDetails> getPurchaseInvoiceDetails(
    int invoiceId,
    );

Future<void> collectPurchasePayment({
  required int purchaseId,
  required double amount,
  String paymentMethod,
  String? note,
});
}