import 'package:cashier_app_v2/core/database/app_database.dart';
import 'package:cashier_app_v2/di.dart';
import 'package:cashier_app_v2/features/pos/domain/entities/product.dart' hide Product;
import 'package:cashier_app_v2/features/pos/domain/repositories/sales_repository.dart';
import 'package:cashier_app_v2/features/pos/presentation/bloc/pos_bloc.dart';
import 'package:cashier_app_v2/features/pos/presentation/bloc/pos_event.dart';
import 'package:cashier_app_v2/features/pos/presentation/bloc/pos_state.dart';
import 'package:cashier_app_v2/features/pos/presentation/widgets/cart_item_tile.dart';
import 'package:cashier_app_v2/features/pos/presentation/widgets/empty_cart_state.dart';
import 'package:cashier_app_v2/features/pos/presentation/widgets/payment_methods.dart';
import 'package:cashier_app_v2/features/pos/presentation/widgets/return_invoice_dialog.dart';
import 'package:cashier_app_v2/features/pos/presentation/widgets/simple_calculator_dialog.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/database/app_database.dart' hide Product;
import '../widgets/category_tabs.dart';
import '../widgets/pos_header.dart';
import '../widgets/products_grid.dart';

class PosScreen extends StatelessWidget {
  const PosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CartBloc>()..add(const LoadProducts()),
      child: const _PosView(),
    );
  }
}

class _PosView extends StatefulWidget {
  const _PosView();

  @override
  State<_PosView> createState() => _PosViewState();
}

class _PosViewState extends State<_PosView> {
  final searchController = TextEditingController();
  final searchFocusNode = FocusNode();
  final discountController = TextEditingController(text: '0');
  final receivedController = TextEditingController(text: '0');

  PaymentMethod paymentMethod = PaymentMethod.cash;

  String category = 'الكل';

  double? deferredPaidAmount;

  static const categories = [
    'الكل',
    'مواد غذائية',
    'مشروبات',
    'منظفات',
    'ألبان',
    'مخبوزات',
  ];
  late final FocusNode _barcodeFocusNode;
  void _handleBarcodeFocus() {
    if (!mounted) return;

    if (!_barcodeFocusNode.hasFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;

        _barcodeFocusNode.requestFocus();
      });
    }
  }
  @override
  void initState() {
    super.initState();

    _barcodeFocusNode = FocusNode();

    _barcodeFocusNode.addListener(_handleBarcodeFocus);

    _requestBarcodeFocus();
  }

  void _requestBarcodeFocus() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      _barcodeFocusNode.requestFocus();
    });
  }



  @override
  void dispose() {
    searchController.dispose();
    _barcodeFocusNode.removeListener(_handleBarcodeFocus);
    _barcodeFocusNode.dispose();

    discountController.dispose();
    receivedController.dispose();
    super.dispose();
  }

  /// يدور على منتج بالباركود جوه القائمة الحالية.
  Product? _findProductByBarcode(List<Product> products, String barcode) {
    final code = barcode.trim();
    if (code.isEmpty) return null;

    for (final product in products) {
      if (product.barcode == code) {
        return product;
      }
    }
    return null;
  }

  /// بينفّذ لما السكانر يبعت Enter: يدور على المنتج ويضيفه للسلة مباشرة.
  void _handleBarcodeScanned(
      BuildContext context,
      List<Product> products,
      String barcode,
      ) {
    final product = _findProductByBarcode(products, barcode);

    if (product == null) {
      _showMessage('لا يوجد منتج بهذا الباركود', isError: true);
    } else {
      context.read<CartBloc>().add(AddProductToCart(product ));
      _showMessage('تمت إضافة ${product.name} إلى السلة');
    }

    // نجهّز الحقل للسكان اللي بعده في الحالتين
    searchController.clear();
    setState(() {});
    searchFocusNode.requestFocus();
  }

  Future<void> _saveCreditOrder({
    required String customerName,
    required String customerPhone,
    required double paidAmount,
    required double totalAmount,
    required List<dynamic> cartItems,
  }) async {
    if (cartItems.isEmpty) {
      _showMessage(
        'السلة فارغة',
        isError: true,
      );
      return;
    }

    final name = customerName.trim();
    final phone = customerPhone.trim();

    if (name.isEmpty) {
      _showMessage(
        'من فضلك أدخل اسم العميل',
        isError: true,
      );
      return;
    }

    if (phone.isEmpty) {
      _showMessage(
        'من فضلك أدخل رقم هاتف العميل',
        isError: true,
      );
      return;
    }

    if (totalAmount <= 0) {
      _showMessage(
        'إجمالي الفاتورة غير صحيح',
        isError: true,
      );
      return;
    }

    if (paidAmount < 0) {
      _showMessage(
        'مبلغ التحصيل غير صحيح',
        isError: true,
      );
      return;
    }

    if (paidAmount > totalAmount) {
      _showMessage(
        'مبلغ التحصيل لا يمكن أن يكون أكبر من إجمالي الفاتورة',
        isError: true,
      );
      return;
    }

    try {
      final database = getIt<AppDatabase>();

      await database.transaction(() async {
        int customerId;
        double oldCustomerDebt = 0;

        final existingCustomer = await (database.select(database.customers)
          ..where((tbl) => tbl.phone.equals(phone)))
            .getSingleOrNull();

        if (existingCustomer != null) {
          customerId = existingCustomer.id;
          oldCustomerDebt = existingCustomer.totalDebt;

          await (database.update(database.customers)
            ..where((tbl) => tbl.id.equals(customerId)))
              .write(
            CustomersCompanion(
              name: drift.Value(name),
            ),
          );
        } else {
          customerId = await database.into(database.customers).insert(
            CustomersCompanion(
              name: drift.Value(name),
              phone: drift.Value(phone),
              totalDebt: const drift.Value(0),
            ),
          );
        }

        final remaining =
        (totalAmount - paidAmount).clamp(0.0, double.infinity).toDouble();

        final status = _resolveInvoiceStatus(
          paidAmount: paidAmount,
          remainingAmount: remaining,
        );

        final invoiceNumber = 'INV-${DateTime.now().millisecondsSinceEpoch}';

        double totalProfit = 0;

        for (final item in cartItems) {
          final product = item.product;
          final quantity = item.quantity as int;
          final purchasePrice = (product.purchasePrice as num).toDouble();
          final unitPrice = (product.price as num).toDouble();
          final itemProfit = (unitPrice - purchasePrice) * quantity;

          totalProfit += itemProfit;
        }

        final invoiceId = await database.into(database.invoices).insert(
          InvoicesCompanion(
            invoiceNumber: drift.Value(invoiceNumber),
            userId: const drift.Value(1),
            customerId: drift.Value(customerId),
            totalAmount: drift.Value(totalAmount),
            discount: const drift.Value(0),
            tax: const drift.Value(0),
            netAmount: drift.Value(totalAmount),
            profit: drift.Value(totalProfit),
            paidAmount: drift.Value(paidAmount),
            remainingAmount: drift.Value(remaining),
            paymentMethod: const drift.Value('credit'),
            status: drift.Value(status),
            createdAt: drift.Value(DateTime.now()),
          ),
        );

        for (final item in cartItems) {
          final product = item.product;
          final quantity = item.quantity as int;
          final purchasePrice = (product.purchasePrice as num).toDouble();
          final unitPrice = (product.price as num).toDouble();
          final totalPrice = unitPrice * quantity;
          final profit = (unitPrice - purchasePrice) * quantity;

          await database.into(database.invoiceItems).insert(
            InvoiceItemsCompanion(
              invoiceId: drift.Value(invoiceId),
              productId: drift.Value(product.id),
              productName: drift.Value(product.name),
              barcode: drift.Value(product.barcode),
              category: drift.Value(product.category),
              unit: drift.Value(product.unit),
              purchasePrice: drift.Value(purchasePrice),
              unitPrice: drift.Value(unitPrice),
              quantity: drift.Value(quantity),
              totalPrice: drift.Value(totalPrice),
              profit: drift.Value(profit),
            ),
          );
        }


        final newCustomerDebt = oldCustomerDebt + remaining;

        await (database.update(database.customers)
          ..where((tbl) => tbl.id.equals(customerId)))
            .write(
          CustomersCompanion(
            totalDebt: drift.Value(newCustomerDebt),
          ),
        );
      });

      if (!mounted) {
        return;
      }

      context.read<CartBloc>().add(
        const ClearCart(),
      );

      setState(() {
        discountController.text = '0';
        receivedController.text = '0';
        paymentMethod = PaymentMethod.cash;
        deferredPaidAmount = null;
      });

      _showMessage(
        'تم تسجيل الفاتورة الآجلة بنجاح',
      );
    } catch (e) {
      if (!mounted) {
        return;
      }

      _showMessage(
        'حدث خطأ أثناء حفظ الآجل: $e',
        isError: true,
      );
    }
  }

  String _resolveInvoiceStatus({
    required double paidAmount,
    required double remainingAmount,
  }) {
    if (remainingAmount <= 0.01) {
      return 'paid';
    }

    if (paidAmount > 0.01) {
      return 'partial';
    }

    return 'unpaid';
  }

  double _change(double total) {
    final received = double.tryParse(receivedController.text) ?? 0;

    return (received - total).clamp(0, double.infinity).toDouble();
  }

  void _checkout(
      CartState state,
      double netTotal,
      ) {
    if (state.cartItems.isEmpty) {
      return;
    }

    if (paymentMethod == PaymentMethod.credit) {
      _showMessage(
        'استخدم تأكيد الآجل من نموذج العميل',
        isError: true,
      );
      return;
    }

    context.read<CartBloc>().add(
      CheckoutCart(
        paymentMethod: paymentMethod.name,
        paidAmount: null,
      ),
    );
  }

  Future<void> _returnInvoice(
      BuildContext context,
      ) async {
    try {
      final salesRepo = getIt<SalesRepository>();

      final recentInvoices = await salesRepo.getRecentInvoices();

      if (!context.mounted) {
        return;
      }

      showDialog(
        context: context,
        builder: (_) => ReturnInvoiceDialog(
          invoices: recentInvoices,
          onInvoiceSelected: (invoiceId) {
            context.read<CartBloc>().add(
              ReturnInvoiceEvent(invoiceId),
            );
          },
        ),
      );
    } catch (e) {
      if (!context.mounted) {
        return;
      }

      _showMessage(
        'حدث خطأ أثناء تحميل الفواتير: $e',
        isError: true,
      );
    }
  }

  void _showMessage(
      String message, {
        bool isError = false,
      }) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            textDirection: TextDirection.rtl,
          ),
          backgroundColor: isError ? AppColors.danger : AppColors.success,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: BlocConsumer<CartBloc, CartState>(
            listenWhen: (previous, current) =>
            previous.status != current.status,
            listener: (context, state) {
              if (state.status == CartStatus.checkoutSuccess) {
                discountController.text = '0';
                receivedController.text = '0';

                setState(() {
                  paymentMethod = PaymentMethod.cash;
                  deferredPaidAmount = null;
                });

                _showMessage(
                  'تم حفظ الفاتورة بنجاح '
                      '(رقم: ${state.lastInvoiceId ?? '-'})',
                );
              }

              if (state.status == CartStatus.failure &&
                  state.errorMessage != null) {
                _showMessage(
                  state.errorMessage!,
                  isError: true,
                );
              }
            },
            builder: (context, state) {
              final searchQuery = searchController.text.trim();

              final filteredProducts = state.products
                  .where(
                    (product) =>
                category == 'الكل' || product.category == category,
              )
                  .where(
                    (product) =>
                searchQuery.isEmpty ||
                    product.name.contains(searchQuery),
              )
                  .toList();

              final productsPanel = Column(
                children: [
                  PosHeader(
                    controller: searchController,
                    focusNode: _barcodeFocusNode,
                    onSearch: (_) {
                      // مجرد إعادة بناء عشان يتفلتر state.products بالنص الحالي
                      setState(() {});
                    },
                    onBarcodeScanned: (barcode) {
                      _handleBarcodeScanned(context, state.products, barcode);
                    },
                    onReturn: () {
                      _returnInvoice(context);
                    },
                  ),
                  CategoryTabs(
                    categories: categories,
                    selected: category,
                    onSelected: (value) {
                      setState(() {
                        category = value;
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: state.status == CartStatus.loading &&
                        state.products.isEmpty
                        ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.gold,
                      ),
                    )
                        : ProductsGrid(
                      products: filteredProducts,
                      onProductTap: (product) {
                        context.read<CartBloc>().add(
                          AddProductToCart(product),
                        );
                      },
                    ),
                  ),
                ],
              );

              final cartPanel = _cartPanel(state);

              return LayoutBuilder(
                builder: (_, constraints) {
                  if (constraints.maxWidth < 900) {
                    return Column(
                      children: [
                        Expanded(
                          flex: 6,
                          child: productsPanel,
                        ),
                        Expanded(
                          flex: 5,
                          child: cartPanel,
                        ),
                      ],
                    );
                  }

                  return Row(
                    children: [
                      SizedBox(
                        width: 390,
                        child: cartPanel,
                      ),
                      const VerticalDivider(
                        width: 1,
                        color: AppColors.divider,
                      ),
                      Expanded(
                        child: productsPanel,
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _cartPanel(CartState state) {
    final subtotal = state.totalAmount;
    final total = state.netAmount;

    return Container(
      height: double.infinity,
      color: AppColors.surface,
      padding: const EdgeInsets.fromLTRB(
        16,
        16,
        16,
        12,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 850;

          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isDesktop ? 450 : double.infinity,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            color: AppColors.gold,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'السلة',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      if (state.cartItems.isNotEmpty)
                        TextButton(
                          onPressed: () {
                            context.read<CartBloc>().add(
                              const ClearCart(),
                            );
                          },
                          child: const Text(
                            'تفريغ السلة',
                            style: TextStyle(
                              color: AppColors.danger,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const Divider(height: 24),
                  Expanded(
                    child: state.cartItems.isEmpty
                        ? const EmptyCartState()
                        : ListView.separated(
                      itemCount: state.cartItems.length,
                      separatorBuilder: (_, __) =>
                      const SizedBox(height: 8),
                      itemBuilder: (_, index) {
                        final item = state.cartItems[index];

                        return CartItemTile(
                          item: item,
                          onQuantityChanged: (delta) {
                            context.read<CartBloc>().add(
                              UpdateQuantity(
                                item.product.id,
                                item.quantity + delta,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'الإجمالي قبل الخصم',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        '${subtotal.toStringAsFixed(2)} ج',
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: discountController,
                    onChanged: (value) {
                      context.read<CartBloc>().add(
                        ApplyDiscount(
                          double.tryParse(value) ?? 0,
                        ),
                      );
                    },
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'خصم (ج)',
                      isDense: true,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.goldSurface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: AppColors.goldDark,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'الإجمالي',
                          style: TextStyle(
                            color: AppColors.goldLight,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${total.toStringAsFixed(2)} ج',
                          style: const TextStyle(
                            color: AppColors.goldLight,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  PaymentMethods(
                    selected: paymentMethod,
                    onSelected: (value) {
                      setState(() {
                        paymentMethod = value;
                      });
                    },
                    onDeferredConfirm: (name, phone, amount) {
                      setState(() {
                        paymentMethod = PaymentMethod.credit;
                        deferredPaidAmount = amount;
                      });

                      _saveCreditOrder(
                        customerName: name,
                        customerPhone: phone,
                        paidAmount: amount,
                        totalAmount: total,
                        cartItems: state.cartItems,
                      );
                    },
                  ),
                  if (paymentMethod == PaymentMethod.cash) ...[
                    const SizedBox(height: 10),
                    TextField(
                      controller: receivedController,
                      onChanged: (_) {
                        setState(() {});
                      },
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: InputDecoration(
                        labelText: 'المبلغ المستلم',
                        suffixText:
                        'الباقي ${_change(total).toStringAsFixed(2)} ج',
                        isDense: true,
                      ),
                    ),
                  ],
                  const SizedBox(height: 10),
                  const TextField(
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'ملاحظة (اختياري)',
                      isDense: true,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: state.cartItems.isEmpty ||
                              state.status == CartStatus.loading ||
                              paymentMethod == PaymentMethod.credit
                              ? null
                              : () {
                            _checkout(
                              state,
                              total,
                            );
                          },
                          icon: state.status == CartStatus.loading
                              ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.black,
                            ),
                          )
                              : const Icon(
                            Icons.check_circle_outline,
                          ),
                          label: Text(
                            state.status == CartStatus.loading
                                ? 'جاري الحفظ...'
                                : paymentMethod == PaymentMethod.credit
                                ? 'تم تسجيل الآجل'
                                : 'إتمام البيع',
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => const SimpleCalculatorDialog(),
                          );
                        },
                        icon: const Icon(
                          Icons.calculate_outlined,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).viewInsets.bottom + 8,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}