import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:cashier_app_v2/features/purchases/domian/entities/product_search_result.dart';
import 'package:cashier_app_v2/features/purchases/presentation/bloc/product_search_bloc.dart';
import 'package:cashier_app_v2/features/purchases/presentation/widgets/add_product_sheet.dart';

import '../bloc/product_search_event.dart';
import '../bloc/product_search_state.dart';
import 'product_search_field.dart';

class ProductSearchSection extends StatelessWidget {
  const ProductSearchSection({
    super.key,
    required this.onProductPicked,
  });

  final ValueChanged<ProductSearchResult> onProductPicked;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<ProductSearchBloc>(),
      child: _Body(onProductPicked: onProductPicked),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({
    required this.onProductPicked,
  });

  final ValueChanged<ProductSearchResult> onProductPicked;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ===========================================================================
  // Action Handlers
  // ===========================================================================
  void _pick(ProductSearchResult product) {
    widget.onProductPicked(product);
    _reset();
  }

  void _reset() {
    _controller.clear();
    context.read<ProductSearchBloc>().add(
      const ProductSearchCleared(),
    );
  }

  Future<void> _openAddForm(String query) async {
    final bloc = context.read<ProductSearchBloc>();
    final isBarcode = RegExp(r'^\d{6,}$').hasMatch(query);

    final created = await AddProductSheet.show(
      context,
      bloc: bloc,
      initialBarcode: isBarcode ? query : null,
      initialName: isBarcode ? null : query,
    );

    if (!mounted) return;

    if (created != null) {
      _pick(created);
    } else {
      _reset();
    }
  }

  // ===========================================================================
  // Build Method
  // ===========================================================================
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductSearchBloc, ProductSearchState>(
      listenWhen: (p, c) => p.status != c.status,
      listener: (context, state) {
        switch (state.status) {
          case ProductSearchStatus.exactMatch:
            _pick(state.selected!);

          case ProductSearchStatus.addNewRequested:
            _openAddForm(state.query);

          case ProductSearchStatus.failure:
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'خطأ'),
              ),
            );

          default:
            break;
        }
      },
      builder: (context, state) {
        final bloc = context.read<ProductSearchBloc>();

        return ProductSearchField(
          controller: _controller,
          results: state.status == ProductSearchStatus.results
              ? state.results
              : const [],
          isSearching: state.status == ProductSearchStatus.loading,
          hasSearched: state.status == ProductSearchStatus.notFound ||
              state.status == ProductSearchStatus.results,
          onChanged: (q) {
            bloc.add(ProductSearchQueryChanged(q));
          },
          onBarcodeSubmitted: (q) {
            bloc.add(ProductSearchSubmitted(q));
          },
          onProductSelected: _pick,
          onAddNewRequested: _openAddForm,
        );
      },
    );
  }
}