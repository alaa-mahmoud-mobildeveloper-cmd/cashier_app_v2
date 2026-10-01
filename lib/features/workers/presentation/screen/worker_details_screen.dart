import 'package:cashier_app_v2/core/database/app_database.dart';
import 'package:cashier_app_v2/features/workers/data/repositories/worker_repository.dart';
import 'package:cashier_app_v2/features/workers/domain/entities/worker.dart';
import 'package:cashier_app_v2/features/workers/domain/entities/worker_details_data.dart';
import 'package:cashier_app_v2/features/workers/presentation/widgets/add_advance_section.dart';
import 'package:cashier_app_v2/features/workers/presentation/widgets/add_product_section.dart';
import 'package:cashier_app_v2/features/workers/presentation/widgets/advances_list_section.dart';
import 'package:cashier_app_v2/features/workers/presentation/widgets/products_list_section.dart';
import 'package:cashier_app_v2/features/workers/presentation/widgets/worker_details_header.dart';
import 'package:cashier_app_v2/features/workers/presentation/widgets/worker_details_summary_cards.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../di.dart';

class WorkerDetailsScreen extends StatefulWidget {
  final Worker worker;
  final bool readOnly;

  const WorkerDetailsScreen({
    super.key,
    required this.worker,
    this.readOnly = false,
  });

  @override
  State<WorkerDetailsScreen> createState() => _WorkerDetailsScreenState();
}

class _WorkerDetailsScreenState extends State<WorkerDetailsScreen> {
  final TextEditingController _advanceAmountController =
      TextEditingController();
  final TextEditingController _advanceReasonController =
      TextEditingController();
  final TextEditingController _productBarcodeController =
      TextEditingController();
  late final WorkerRepository _repository = WorkerRepository(
    getIt<AppDatabase>(),
  );
  bool _isSavingAdvance = false;
  bool _isIssuingProduct = false;

  @override
  void dispose() {
    _advanceAmountController.dispose();
    _advanceReasonController.dispose();
    _productBarcodeController.dispose();
    super.dispose();
  }

  Future<void> _addAdvance() async {
    final workerId = widget.worker.id;
    final amount = double.tryParse(_advanceAmountController.text.trim());
    if (workerId == null) {
      _showMessage('تعذر تحديد العامل');
      return;
    }
    if (amount == null || amount <= 0) {
      _showMessage('أدخل مبلغًا صحيحًا أكبر من صفر');
      return;
    }

    setState(() => _isSavingAdvance = true);
    try {
      await _repository.addAdvance(
        workerId: workerId,
        amount: amount,
        reason: _advanceReasonController.text,
      );
      _advanceAmountController.clear();
      _advanceReasonController.clear();
      _showMessage('تم تسجيل السلفة');
    } catch (error) {
      _showMessage(_messageFromError(error));
    } finally {
      if (mounted) setState(() => _isSavingAdvance = false);
    }
  }

  Future<void> _issueProduct(String barcode) async {
    final workerId = widget.worker.id;
    if (workerId == null) {
      _showMessage('تعذر تحديد العامل');
      return;
    }
    if (barcode.trim().isEmpty || _isIssuingProduct) return;

    setState(() => _isIssuingProduct = true);
    try {
      final productName = await _repository.issueProductByBarcode(
        workerId: workerId,
        barcode: barcode,
      );
      _productBarcodeController.clear();
      _showMessage('تم تسجيل أخذ: $productName');
    } catch (error) {
      _showMessage(_messageFromError(error));
    } finally {
      if (mounted) setState(() => _isIssuingProduct = false);
    }
  }

  String _messageFromError(Object error) => error
      .toString()
      .replaceFirst('Bad state: ', '')
      .replaceFirst('Invalid argument(s): ', '');

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final workerId = widget.worker.id;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: workerId == null
              ? const Center(child: Text('العامل غير مرتبط بقاعدة البيانات'))
              : StreamBuilder<WorkerDetailsData>(
                  stream: _repository.watchWorkerDetails(workerId),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'تعذر تحميل بيانات العامل: ${snapshot.error}',
                        ),
                      );
                    }
                    final data =
                        snapshot.data ??
                        const WorkerDetailsData(advances: [], products: []);
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        final isCompact = constraints.maxWidth < 900;
                        return SingleChildScrollView(
                          padding: EdgeInsets.all(isCompact ? 16 : 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              WorkerDetailsHeader(
                                worker: widget.worker,
                                showBackButton: !widget.readOnly,
                              ),
                              const SizedBox(height: 20),
                              WorkerDetailsSummaryCards(
                                worker: widget.worker,
                                isCompact: isCompact,
                                advancesTotal: data.advancesTotal,
                                productsTotal: data.productsTotal,
                              ),
                              const SizedBox(height: 20),
                              isCompact
                                  ? _buildCompactBody(data)
                                  : _buildDesktopBody(data),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
        ),
      ),
    );
  }

  Widget _buildDesktopBody(WorkerDetailsData data) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AddAdvanceSection(
                amountController: _advanceAmountController,
                reasonController: _advanceReasonController,
                isSubmitting: _isSavingAdvance,
                onSubmit: _addAdvance,
              ),
              const SizedBox(height: 16),
              AdvancesListSection(advances: data.advances),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AddProductSection(
                barcodeController: _productBarcodeController,
                isSubmitting: _isIssuingProduct,
                onSubmit: _issueProduct,
              ),
              const SizedBox(height: 16),
              ProductsListSection(products: data.products),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompactBody(WorkerDetailsData data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AddAdvanceSection(
          amountController: _advanceAmountController,
          reasonController: _advanceReasonController,
          isSubmitting: _isSavingAdvance,
          onSubmit: _addAdvance,
        ),
        const SizedBox(height: 16),
        AdvancesListSection(advances: data.advances),
        if (!widget.readOnly) ...[
          const SizedBox(height: 16),
          AddProductSection(
            barcodeController: _productBarcodeController,
            isSubmitting: _isIssuingProduct,
            onSubmit: _issueProduct,
          ),
          const SizedBox(height: 16),
        ],
        ProductsListSection(products: data.products),
      ],
    );
  }
}
