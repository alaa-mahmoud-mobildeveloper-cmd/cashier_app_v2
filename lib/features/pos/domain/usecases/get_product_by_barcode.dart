import '../entities/product.dart';
import '../repositories/pos_repository.dart';

class GetProductByBarcode {
  final PosRepository repository;
  GetProductByBarcode(this.repository);

  Future<Product?> call(String barcode) => repository.getProductByBarcode(barcode);
}
