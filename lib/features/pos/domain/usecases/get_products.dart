import '../../../../core/usecases/usecase.dart';
import '../entities/product.dart';
import '../repositories/pos_repository.dart';

class GetProducts implements UseCase<List<Product>, NoParams> {
  final PosRepository repository;
  GetProducts(this.repository);

  @override
  Future<List<Product>> call(NoParams params) => repository.getProducts();
}
