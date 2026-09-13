import 'package:cashier_app_v2/features/workers/presentation/widgets/add_advance_section.dart';
import 'package:cashier_app_v2/features/workers/presentation/widgets/add_product_section.dart';
import 'package:cashier_app_v2/features/workers/presentation/widgets/advances_list_section.dart';
import 'package:cashier_app_v2/features/workers/presentation/widgets/products_list_section.dart';
import 'package:cashier_app_v2/features/workers/presentation/widgets/worker_details_header.dart';
import 'package:cashier_app_v2/features/workers/presentation/widgets/worker_details_summary_cards.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/worker.dart';


class WorkerDetailsScreen extends StatefulWidget {
  final Worker worker;

  const WorkerDetailsScreen({super.key, required this.worker});

  @override
  State<WorkerDetailsScreen> createState() => _WorkerDetailsScreenState();
}

class _WorkerDetailsScreenState extends State<WorkerDetailsScreen> {
  final TextEditingController _advanceAmountController = TextEditingController();
  final TextEditingController _advanceReasonController = TextEditingController();
  final TextEditingController _productBarcodeController = TextEditingController();

  @override
  void dispose() {
    _advanceAmountController.dispose();
    _advanceReasonController.dispose();
    _productBarcodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isCompact = constraints.maxWidth < 900;
              return SingleChildScrollView(
                padding: EdgeInsets.all(isCompact ? 16 : 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    WorkerDetailsHeader(worker: widget.worker),
                    const SizedBox(height: 20),
                    WorkerDetailsSummaryCards(worker: widget.worker, isCompact: isCompact),
                    const SizedBox(height: 20),
                    isCompact ? _buildCompactBody() : _buildDesktopBody(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopBody() {
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
                onSubmit: () {},
              ),
              const SizedBox(height: 16),
              const AdvancesListSection(),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AddProductSection(barcodeController: _productBarcodeController),
              const SizedBox(height: 16),
              const ProductsListSection(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompactBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AddAdvanceSection(
          amountController: _advanceAmountController,
          reasonController: _advanceReasonController,
          onSubmit: () {},
        ),
        const SizedBox(height: 16),
        const AdvancesListSection(),
        const SizedBox(height: 16),
        AddProductSection(barcodeController: _productBarcodeController),
        const SizedBox(height: 16),
        const ProductsListSection(),
      ],
    );
  }
}