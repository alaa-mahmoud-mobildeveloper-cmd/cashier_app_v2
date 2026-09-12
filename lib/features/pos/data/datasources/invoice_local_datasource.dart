import '../models/invoice_model.dart';

abstract class InvoiceLocalDataSource {
  Future<void> saveInvoice(InvoiceModel invoice);
  Future<List<InvoiceModel>> getInvoices();
}

class InvoiceLocalDataSourceImpl implements InvoiceLocalDataSource {
  final List<InvoiceModel> _invoices = [];

  @override
  Future<void> saveInvoice(InvoiceModel invoice) async {
    _invoices.add(invoice);
  }

  @override
  Future<List<InvoiceModel>> getInvoices() async => _invoices;
}
