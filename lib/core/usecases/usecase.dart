/// Interface عام لكل الـ UseCases في المشروع.
/// [Type] نوع القيمة اللي بترجع، [Params] البارامترات اللي بتتبعت.
abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

/// يُستخدم لما الـ UseCase مش محتاج أي بارامترات (زي GetProducts).
class NoParams {
  const NoParams();
}
