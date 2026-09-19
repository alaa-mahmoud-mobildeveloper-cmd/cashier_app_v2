import 'package:injectable/injectable.dart';

import '../repositories/product_repository.dart';
@injectable

/// حذف صنف. مش مستخدم في الشاشة دلوقتي، بس موجود جاهز لو حبيت تضيف
/// زرار حذف على الصف بعدين (نفس نمط باقي الـ UseCases).
class DeleteProduct {
  final ProductRepository _repository;

  const DeleteProduct(this._repository);

  Future<void> call(String id) => _repository.deleteProduct(id);
}
