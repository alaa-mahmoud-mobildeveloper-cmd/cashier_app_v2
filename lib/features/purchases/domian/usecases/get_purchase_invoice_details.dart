
import 'package:cashier_app_v2/features/purchases/domian/entities/details_invoice.dart';
import 'package:injectable/injectable.dart';

import '../repositories/purchase_repository.dart';

@injectable
class GetPurchaseInvoiceDetails {
const GetPurchaseInvoiceDetails(this.repository);

final PurchaseRepository repository;

Future<PurchaseInvoiceDetails> call(int invoiceId) {
return repository.getPurchaseInvoiceDetails(invoiceId);
}
}
