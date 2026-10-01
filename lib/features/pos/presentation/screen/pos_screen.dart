
import 'dart:async';

import 'package:cashier_app_v2/core/database/app_database.dart';
import 'package:cashier_app_v2/di.dart';
import 'package:cashier_app_v2/features/pos/data/models/cart_item_model.dart';
import 'package:cashier_app_v2/features/pos/domain/entities/product.dart'
    hide Product, CartItem;
import 'package:cashier_app_v2/features/pos/domain/repositories/sales_repository.dart';
import 'package:cashier_app_v2/features/pos/presentation/bloc/pos_bloc.dart';
import 'package:cashier_app_v2/features/pos/presentation/bloc/pos_event.dart';
import 'package:cashier_app_v2/features/pos/presentation/bloc/pos_state.dart';
import 'package:cashier_app_v2/features/pos/presentation/widgets/cart_item_tile.dart';
import 'package:cashier_app_v2/features/pos/presentation/widgets/empty_cart_state.dart';
import 'package:cashier_app_v2/features/pos/presentation/widgets/payment_methods.dart';
import 'package:cashier_app_v2/features/pos/presentation/widgets/return_invoice_dialog.dart';
import 'package:cashier_app_v2/features/pos/presentation/widgets/simple_calculator_dialog.dart';
import 'package:cashier_app_v2/features/payment_accounts/data/payment_account_repository.dart';
import 'package:cashier_app_v2/features/payment_accounts/domain/payment_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/database/app_database.dart' hide Product;
import '../widgets/category_tabs.dart';
import '../widgets/pos_header.dart';
import '../widgets/products_grid.dart';

void _keepPosInputFocus(PointerDownEvent event) {}

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
final discountController = TextEditingController(text: '0');
final receivedController = TextEditingController(text: '0');

late final FocusNode _barcodeFocusNode;

Timer? _searchDebounce;

PaymentMethod paymentMethod = PaymentMethod.cash;
PaymentAccountInfo? _selectedPaymentAccount;
late final PaymentAccountRepository _paymentAccountRepository;
bool _isSelectingPaymentAccount = false;

String category = 'الكل';

static const categories = [
'الكل',
'مواد غذائية',
'مشروبات',
'مياه وعصائر',
'ألبان',
'جبن',
'زبادي',
'بسكوت',
'حلويات',
'شوكولاتة',
'سناكس',
'معلبات',
'أرز ومكرونة',
'بقوليات',
'زيوت وسمن',
'سكر وملح',
'توابل',
'صلصات',
'شاي وقهوة',
'منظفات',
'مجمدات',
'أخرى',
];

@override
void initState() {
super.initState();

_paymentAccountRepository = PaymentAccountRepository(getIt<AppDatabase>());
_barcodeFocusNode = FocusNode();

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
_searchDebounce?.cancel();

searchController.dispose();
_barcodeFocusNode.dispose();

discountController.dispose();
receivedController.dispose();

super.dispose();
}

void _handleSearchChanged(String value) {
_searchDebounce?.cancel();

_searchDebounce = Timer(
const Duration(milliseconds: 350),
() {
if (!mounted) return;

context.read<CartBloc>().add(
LoadProducts(
searchQuery: value.trim(),
category: category,
),
);
},
);
}

void _handlePaymentMethodSelected(PaymentMethod method) {
  if (method == PaymentMethod.wallet ||
      method == PaymentMethod.visa ||
      method == PaymentMethod.fawry) {
    unawaited(_selectDigitalPaymentAccount(method));
    return;
  }

  setState(() {
    paymentMethod = method;
    _selectedPaymentAccount = null;
  });
}

Future<void> _selectDigitalPaymentAccount(PaymentMethod method) async {
  setState(() => _isSelectingPaymentAccount = true);
  try {
    final accounts = await _paymentAccountRepository.getActiveAccounts(
      type: method.name,
    );
    if (!mounted) return;

    if (accounts.isEmpty) {
      final methodLabel = switch (method) {
        PaymentMethod.wallet => 'محفظة',
        PaymentMethod.visa => 'فيزا',
        PaymentMethod.fawry => 'فوري',
        _ => 'الدفع الإلكتروني',
      };
      _showMessage(
        'لا يوجد حساب $methodLabel نشط. اطلب من المدير إضافة حساب أولًا.',
        isError: true,
      );
      return;
    }

    final account = accounts.length == 1
        ? accounts.single
        : await _choosePaymentAccount(accounts);
    if (!mounted || account == null) return;

    setState(() {
      paymentMethod = method;
      _selectedPaymentAccount = account;
    });
  } catch (error) {
    if (mounted) {
      _showMessage('تعذر تحميل حسابات الدفع: $error', isError: true);
    }
  } finally {
    if (mounted) setState(() => _isSelectingPaymentAccount = false);
  }
}

Future<PaymentAccountInfo?> _choosePaymentAccount(
  List<PaymentAccountInfo> accounts,
) {
  return showDialog<PaymentAccountInfo>(
    context: context,
    builder: (dialogContext) => Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        title: const Text('اختر حساب الاستلام'),
        content: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420, maxHeight: 360),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: accounts
                  .map(
                    (account) => ListTile(
                      leading: Icon(
                        account.type == PaymentAccountType.wallet.name
                            ? Icons.wallet_outlined
                            : account.type == PaymentAccountType.fawry.name
                            ? Icons.qr_code_2_outlined
                            : Icons.credit_card,
                        color: AppColors.gold,
                      ),
                      title: Text(account.name),
                      subtitle: Text(
                        [
                          if (account.provider?.isNotEmpty ?? false)
                            account.provider!,
                          if (account.reference?.isNotEmpty ?? false)
                            account.reference!,
                        ].join(' • '),
                      ),
                      onTap: () => Navigator.of(dialogContext).pop(account),
                    ),
                  )
                  .toList(growable: false),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('إلغاء'),
          ),
        ],
      ),
    ),
  );
}

void _handleCategorySelected(String value) {
setState(() {
category = value;
});

context.read<CartBloc>().add(
LoadProducts(
searchQuery: searchController.text.trim(),
category: value,
),
);

_requestBarcodeFocus();
}

void _handleBarcodeScanned(
BuildContext context,
String barcode,
) {
final code = barcode.trim();

if (code.isEmpty) {
_requestBarcodeFocus();
return;
}

context.read<CartBloc>().add(
AddProductByBarcode(code),
);

searchController.clear();

_requestBarcodeFocus();
}

void _saveCreditOrder({
required int? customerId,
required String customerName,
required String customerPhone,
required double paidAmount,
required double totalAmount,
required List<CartItem> cartItems,
}) {
if (cartItems.isEmpty) {
  _showMessage('السلة فارغة', isError: true);
  return;
}

if (customerId == null && customerName.trim().isEmpty) {
  _showMessage('من فضلك أدخل اسم العميل', isError: true);
  return;
}
if (customerId == null && customerPhone.trim().isEmpty) {
  _showMessage('من فضلك أدخل رقم هاتف العميل', isError: true);
  return;
}
if (totalAmount <= 0) {
  _showMessage('إجمالي الفاتورة غير صحيح', isError: true);
  return;
}
if (!paidAmount.isFinite || paidAmount < 0 || paidAmount > totalAmount) {
  _showMessage('راجع المبلغ المدفوع والمتبقي للفاتورة', isError: true);
  return;
}

context.read<CartBloc>().add(
  CheckoutCart(
    paymentMethod: PaymentMethod.credit.name,
    paidAmount: paidAmount,
    customerId: customerId,
    newCustomerName: customerId == null ? customerName.trim() : null,
    newCustomerPhone: customerId == null ? customerPhone.trim() : null,
  ),
);
}

double _change(double total) {
final received =
double.tryParse(receivedController.text) ?? 0;

return (received - total)
    .clamp(0, double.infinity)
    .toDouble();
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
paymentAccountId: _selectedPaymentAccount?.id,
),
);
}

Future<void> _returnInvoice(
BuildContext context,
) async {
try {
final salesRepo = getIt<SalesRepository>();

final recentInvoices =
await salesRepo.getRecentInvoices();

if (!context.mounted) return;

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
if (!context.mounted) return;

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
if (!mounted) return;

ScaffoldMessenger.of(context)
..hideCurrentSnackBar()
..showSnackBar(
SnackBar(
content: Text(
message,
textDirection: TextDirection.rtl,
),
backgroundColor:
isError ? AppColors.danger : AppColors.success,
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
 _selectedPaymentAccount = null;
});

_showMessage(
'تم حفظ الفاتورة بنجاح '
'(رقم: ${state.lastInvoiceId ?? '-'})',
);

_requestBarcodeFocus();
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
final productsPanel = Column(
children: [
PosHeader(
controller: searchController,
focusNode: _barcodeFocusNode,
onSearch: _handleSearchChanged,
onBarcodeScanned: (barcode) {
_handleBarcodeScanned(
context,
barcode,
);
},
onReturn: () {
_returnInvoice(context);
},
),
CategoryTabs(
categories: categories,
selected: category,
onSelected: _handleCategorySelected,
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
products: state.products,
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
mainAxisAlignment:
MainAxisAlignment.spaceBetween,
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
itemCount:
state.cartItems.length,
separatorBuilder: (_, __) =>
const SizedBox(height: 8),
itemBuilder: (_, index) {
final item =
state.cartItems[index];

return CartItemTile(
item: item,
onQuantityChanged:
(delta) {
context
    .read<CartBloc>()
    .add(
UpdateQuantity(
item.product.id,
item.quantity +
delta,
),
);
},
);
},
),
),
const SizedBox(height: 12),
Row(
mainAxisAlignment:
MainAxisAlignment.spaceBetween,
children: [
const Text(
'الإجمالي قبل الخصم',
style: TextStyle(
color:
AppColors.textSecondary,
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
onTapOutside: (_) {},
onChanged: (value) {
context.read<CartBloc>().add(
ApplyDiscount(
double.tryParse(value) ?? 0,
),
);
},
keyboardType:
const TextInputType.numberWithOptions(
decimal: true,
),
decoration:
const InputDecoration(
labelText: 'خصم (ج)',
isDense: true,
),
),
const SizedBox(height: 10),
Container(
padding: const EdgeInsets.all(14),
decoration: BoxDecoration(
color: AppColors.goldSurface,
borderRadius:
BorderRadius.circular(14),
border: Border.all(
color: AppColors.goldDark,
),
),
child: Row(
mainAxisAlignment:
MainAxisAlignment.spaceBetween,
children: [
const Text(
'الإجمالي',
style: TextStyle(
color:
AppColors.goldLight,
fontWeight:
FontWeight.bold,
),
),
Text(
'${total.toStringAsFixed(2)} ج',
style: const TextStyle(
color:
AppColors.goldLight,
fontSize: 20,
fontWeight:
FontWeight.bold,
),
),
],
),
),
const SizedBox(height: 10),
PaymentMethods(
selected: paymentMethod,
onSelected: _handlePaymentMethodSelected,
onDeferredConfirm:
(customerId, name, phone, amount) {
setState(() {
paymentMethod =
PaymentMethod.credit;
_selectedPaymentAccount = null;
});

_saveCreditOrder(
customerId: customerId,
customerName: name,
customerPhone: phone,
paidAmount: amount,
totalAmount: total,
cartItems: state.cartItems,
);
},
),
if (paymentMethod == PaymentMethod.wallet ||
    paymentMethod == PaymentMethod.visa ||
    paymentMethod == PaymentMethod.fawry) ...[
  const SizedBox(height: 8),
  Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: AppColors.surfaceLight,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: AppColors.border),
    ),
    child: Row(
      children: [
        const Icon(Icons.account_balance_wallet_outlined,
            color: AppColors.gold, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            _isSelectingPaymentAccount
                ? 'جاري تحميل الحسابات...'
                : 'حساب الاستلام: ${_selectedPaymentAccount?.displayLabel ?? 'غير محدد'}',
            style: const TextStyle(color: AppColors.textPrimary),
          ),
        ),
        TextButton(
          onPressed: _isSelectingPaymentAccount
              ? null
              : () => unawaited(
                    _selectDigitalPaymentAccount(paymentMethod),
                  ),
          child: const Text('تغيير'),
        ),
      ],
    ),
  ),
],
if (paymentMethod ==
PaymentMethod.cash) ...[
const SizedBox(height: 10),
TextField(
controller: receivedController,
onTapOutside: (_) {},
onChanged: (_) {
setState(() {});
},
keyboardType:
const TextInputType.numberWithOptions(
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
onTapOutside: _keepPosInputFocus,
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
state.status ==
CartStatus.loading ||
_isSelectingPaymentAccount ||
((paymentMethod == PaymentMethod.wallet ||
        paymentMethod == PaymentMethod.visa ||
        paymentMethod == PaymentMethod.fawry) &&
    _selectedPaymentAccount == null) ||
paymentMethod ==
PaymentMethod.credit
? null
    : () {
_checkout(
state,
total,
);
},
icon: state.status ==
CartStatus.loading
? const SizedBox(
width: 18,
height: 18,
child:
CircularProgressIndicator(
strokeWidth: 2,
color: Colors.black,
),
)
    : const Icon(
Icons
    .check_circle_outline,
),
label: Text(
state.status ==
CartStatus.loading
? 'جاري الحفظ...'
    : paymentMethod ==
PaymentMethod.credit
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
builder: (_) =>
const SimpleCalculatorDialog(),
);
},
icon: const Icon(
Icons.calculate_outlined,
),
),
],
),
SizedBox(
height:
MediaQuery.of(context)
    .viewInsets
    .bottom +
8,
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
