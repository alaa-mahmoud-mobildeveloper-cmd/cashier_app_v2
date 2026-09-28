
import 'package:injectable/injectable.dart';

import '../entities/save_purchase_params.dart';
import '../repositories/purchase_repository.dart';
@injectable
class SavePurchase {
const SavePurchase(this.repository);

final PurchaseRepository repository;

Future<void> call(SavePurchaseParams params) {
return repository.savePurchase(params);
}
}

