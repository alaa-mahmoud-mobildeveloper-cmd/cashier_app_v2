import 'package:injectable/injectable.dart';

import '../entities/purchase_invoice.dart';
import '../repositories/purchase_repository.dart';

@injectable
class WatchPurchaseInvoices {
  const WatchPurchaseInvoices(this.repository);

  final PurchaseRepository repository;

  Stream<List<PurchaseInvoice>> call() {
    return repository.watchPurchaseInvoices();
  }
}