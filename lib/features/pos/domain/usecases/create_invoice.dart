import '../entities/invoice.dart';
import '../repositories/pos_repository.dart';

class CreateInvoiceParams {
  final List<InvoiceItem> items;
  final double discount;
  final double total;
  final String paymentMethod;

  const CreateInvoiceParams({
    required this.items,
    required this.discount,
    required this.total,
    required this.paymentMethod,
  });
}

class CreateInvoice {
  final PosRepository repository;
  CreateInvoice(this.repository);

  Future<Invoice> call(CreateInvoiceParams params) {
    return repository.createInvoice(
      items: params.items,
      discount: params.discount,
      total: params.total,
      paymentMethod: params.paymentMethod,
    );
  }
}
