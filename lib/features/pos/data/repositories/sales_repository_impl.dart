import 'package:drift/drift.dart';
import 'package:cashier_app_v2/core/database/app_database.dart';
import 'package:cashier_app_v2/features/pos/data/models/cart_item_model.dart';
import 'package:cashier_app_v2/features/pos/domain/repositories/sales_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SalesRepository)
class SalesRepositoryImpl implements SalesRepository {
  final AppDatabase _db;

  SalesRepositoryImpl(this._db);

  @override
  Future<List<Product>> getProductsPage({
    required int limit,
    required int offset,
    String searchQuery = '',
    String category = 'الكل',
  }) async {
    final query = _db.select(_db.products);

    final search = searchQuery.trim();

    if (search.isNotEmpty) {
      query.where(
            (product) =>
        product.name.like('%$search%') |
        product.barcode.like('%$search%'),
      );
    }

    if (category.trim().isNotEmpty && category != 'الكل') {
      query.where(
            (product) => product.category.equals(category),
      );
    }

    query
      ..orderBy([
            (product) => OrderingTerm(
          expression: product.name,
          mode: OrderingMode.asc,
        ),
      ])
      ..limit(
        limit,
        offset: offset,
      );

    return query.get();
  }

  @override
  Future<Product?> getProductByBarcode(String barcode) async {
    final code = barcode.trim();

    if (code.isEmpty) {
      return null;
    }

    final query = _db.select(_db.products)
      ..where(
            (product) => product.barcode.equals(code),
      )
      ..limit(1);

    return query.getSingleOrNull();
  }

  @override
  Future<int> checkout({
    required int userId,
    required List<CartItem> cartItems,
    required double discount,
    required double tax,
    required String paymentMethod,
    double? paidAmount,
    int? paymentAccountId,
    int? customerId,
    String? newCustomerName,
    String? newCustomerPhone,
  }) async {
    if (cartItems.isEmpty) {
      throw Exception('لا يمكن تنفيذ بيع بدون منتجات');
    }

    final subtotal = cartItems.fold<double>(
      0,
          (sum, item) => sum + item.totalPrice,
    );

    final netAmount = subtotal + tax - discount;
    final paid = paidAmount ?? netAmount;
    final isCredit = paymentMethod == 'credit';
    final hasNewCustomerData =
        newCustomerName != null || newCustomerPhone != null;

    if (isCredit) {
      if (customerId == null &&
          (newCustomerName == null || newCustomerPhone == null)) {
        throw StateError('اختر حساب عميل سابق أو أدخل بيانات عميل جديد');
      }
      if (customerId != null && hasNewCustomerData) {
        throw StateError(
          'لا يمكن اختيار حساب سابق وإرسال بيانات حساب جديد معًا',
        );
      }
      if (!netAmount.isFinite ||
          !paid.isFinite ||
          netAmount <= 0 ||
          paid < 0 ||
          paid > netAmount) {
        throw StateError('راجع إجمالي الفاتورة والمبلغ المدفوع للآجل');
      }
      if (customerId == null) {
        final name = newCustomerName!.trim();
        final phone = newCustomerPhone!.trim();
        if (name.length < 2) {
          throw StateError('اسم العميل يجب أن يكون حرفين على الأقل');
        }
        if (_normalizePhone(phone).length < 10) {
          throw StateError('رقم تليفون العميل غير صحيح');
        }
      }
    } else if (customerId != null || hasNewCustomerData) {
      throw StateError('بيانات حساب العميل مطلوبة لفواتير الآجل فقط');
    }

    final requiresAccount =
        paymentMethod == 'wallet' ||
        paymentMethod == 'visa' ||
        paymentMethod == 'fawry';

    if (requiresAccount != (paymentAccountId != null)) {
      throw StateError(
        requiresAccount
            ? 'اختر حساب الاستلام قبل إتمام البيع'
            : 'طريقة الدفع المحددة لا تستخدم حساب استلام',
      );
    }
    if (requiresAccount && (paid <= 0 || paid > netAmount)) {
      throw StateError(
        'مبلغ التحصيل الرقمي يجب أن يكون أكبر من صفر وألا يتجاوز الإجمالي',
      );
    }

    final invoiceNumber =
        'INV-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';

    final remaining =
        (netAmount - paid).clamp(0.0, double.infinity).toDouble();
    final invoiceStatus = !isCredit
        ? 'completed'
        : remaining <= 0.01
        ? 'paid'
        : paid > 0.01
        ? 'partial'
        : 'unpaid';

    return _db.transaction(() async {
      int? invoiceCustomerId;
      var existingCustomerDebt = 0.0;
      if (isCredit) {
        if (customerId != null) {
          final customer = await (_db.select(_db.customers)
                ..where((row) => row.id.equals(customerId)))
              .getSingleOrNull();
          if (customer == null) {
            throw StateError('حساب العميل المحدد لم يعد موجودًا');
          }
          invoiceCustomerId = customer.id;
          existingCustomerDebt = customer.totalDebt;
        } else {
          final name = newCustomerName!.trim();
          final phone = newCustomerPhone!.trim();
          final normalizedPhone = _normalizePhone(phone);
          final customers = await _db.select(_db.customers).get();
          if (customers.any(
            (customer) =>
                _normalizePhone(customer.phone) == normalizedPhone,
          )) {
            throw StateError(
              'رقم التليفون مسجل لحساب آجل سابق؛ اختر حساب العميل الموجود',
            );
          }
          invoiceCustomerId = await _db.into(_db.customers).insert(
                CustomersCompanion(
                  name: Value(name),
                  phone: Value(phone),
                  totalDebt: const Value(0),
                ),
              );
        }
      }

      final paymentAccount = paymentAccountId == null
          ? null
          : await (_db.select(_db.paymentAccounts)
                ..where((account) =>
                    account.id.equals(paymentAccountId) &
                    account.isActive.equals(true) &
                    account.type.equals(paymentMethod)))
              .getSingleOrNull();

      if (requiresAccount && paymentAccount == null) {
        throw StateError('حساب الدفع غير نشط أو لا يطابق طريقة الدفع');
      }

      double totalProfit = 0;

      final products = <int, Product>{};

      for (final item in cartItems) {
        final product = await (_db.select(_db.products)
          ..where(
                (p) => p.id.equals(item.product.id),
          ))
            .getSingleOrNull();

        if (product == null) {
          throw Exception(
            'المنتج غير موجود: ${item.product.name}',
          );
        }

        if (product.stockQuantity < item.quantity) {
          throw Exception(
            'المخزون غير كافي للمنتج ${product.name}',
          );
        }

        products[product.id] = product;

        totalProfit +=
            (product.price - product.purchasePrice) * item.quantity;
      }

      final invoiceId = await _db.into(_db.invoices).insert(
        InvoicesCompanion.insert(
            invoiceNumber: invoiceNumber,
            userId: userId,
            customerId: Value(invoiceCustomerId),
            totalAmount: subtotal,
          discount: Value(discount),
          tax: Value(tax),
          netAmount: netAmount,
          paidAmount: Value(paid),
            remainingAmount: Value(remaining),
            paymentMethod: Value(paymentMethod),
            status: Value(invoiceStatus),
            profit: Value(totalProfit),
          ),
        );

      if (invoiceCustomerId != null) {
        await (_db.update(_db.customers)
              ..where((customer) => customer.id.equals(invoiceCustomerId!)))
            .write(
          CustomersCompanion(
            totalDebt: Value(existingCustomerDebt + remaining),
          ),
        );
      }

      if (paymentAccount != null) {
        await _db.into(_db.paymentAccountTransactions).insert(
          PaymentAccountTransactionsCompanion.insert(
            accountId: paymentAccount.id,
            invoiceId: Value(invoiceId),
            invoiceNumber: Value(invoiceNumber),
            userId: userId,
            kind: 'sale',
            amount: paid,
            note: const Value('تحصيل من فاتورة بيع'),
          ),
        );
      }

      for (final item in cartItems) {
        final product = products[item.product.id]!;

        final itemProfit =
            (product.price - product.purchasePrice) * item.quantity;

        final itemTotal = product.price * item.quantity;

        await _db.into(_db.invoiceItems).insert(
          InvoiceItemsCompanion.insert(
            invoiceId: invoiceId,
            productId: product.id,
            productName: product.name,
            barcode: product.barcode,
            category: product.category,
            unit: product.unit,
            purchasePrice: product.purchasePrice,
            unitPrice: product.price,
            quantity: item.quantity,
            totalPrice: itemTotal,
            profit: Value(itemProfit),
          ),
        );

        await (_db.update(_db.products)
          ..where(
                (p) => p.id.equals(product.id),
          ))
            .write(
          ProductsCompanion(
            stockQuantity: Value(
              product.stockQuantity - item.quantity,
            ),
          ),
        );

        await _db.into(_db.stockMovements).insert(
          StockMovementsCompanion.insert(
            productId: product.id,
            userId: userId,
            quantity: -item.quantity,
            type: 'sale',
            note: Value('فاتورة $invoiceNumber'),
          ),
        );
      }

      return invoiceId;
    });
  }

  @override
  Future<List<Invoice>> getRecentInvoices() async {
    return (_db.select(_db.invoices)
      ..orderBy([
            (invoice) => OrderingTerm(
          expression: invoice.createdAt,
          mode: OrderingMode.desc,
        ),
      ])
      ..limit(3))
        .get();
  }

  @override
  Future<int> returnInvoice({
    required int userId,
    int? invoiceId,
  }) async {
    return _db.transaction(() async {
      final targetInvoice = invoiceId != null
          ? await (_db.select(_db.invoices)
        ..where(
              (i) => i.id.equals(invoiceId),
        ))
          .getSingleOrNull()
          : await (_db.select(_db.invoices)
        ..orderBy([
              (invoice) => OrderingTerm(
            expression: invoice.createdAt,
            mode: OrderingMode.desc,
          ),
        ])
        ..limit(1))
          .getSingleOrNull();

      if (targetInvoice == null) {
        throw Exception('لا توجد فواتير');
      }

      if (targetInvoice.status == 'returned') {
        throw Exception(
          'الفاتورة ${targetInvoice.invoiceNumber} تم إرجاعها بالفعل',
        );
      }

      final invoiceItems = await (_db.select(_db.invoiceItems)
        ..where(
              (item) => item.invoiceId.equals(targetInvoice.id),
        ))
          .get();

      if (invoiceItems.isEmpty) {
        throw Exception(
          'الفاتورة ${targetInvoice.invoiceNumber} لا تحتوي على أصناف',
        );
      }

      for (final item in invoiceItems) {
        final product = await (_db.select(_db.products)
          ..where(
                (p) => p.id.equals(item.productId),
          ))
            .getSingleOrNull();

        if (product == null) {
          throw Exception(
            'المنتج غير موجود: ${item.productName}',
          );
        }

        final newStock = product.stockQuantity + item.quantity;

        await (_db.update(_db.products)
          ..where(
                (p) => p.id.equals(product.id),
          ))
            .write(
          ProductsCompanion(
            stockQuantity: Value(newStock),
          ),
        );

        await _db.into(_db.stockMovements).insert(
          StockMovementsCompanion.insert(
            productId: product.id,
            userId: userId,
            quantity: item.quantity,
            type: 'return',
            note: Value(
              'إرجاع الفاتورة ${targetInvoice.invoiceNumber}',
            ),
          ),
        );
      }

      if (targetInvoice.customerId != null &&
          targetInvoice.remainingAmount > 0) {
        final customer = await (_db.select(_db.customers)
              ..where((row) => row.id.equals(targetInvoice.customerId!)))
            .getSingleOrNull();
        if (customer != null) {
          final updatedDebt = (customer.totalDebt -
                  targetInvoice.remainingAmount)
              .clamp(0.0, double.infinity)
              .toDouble();
          await (_db.update(_db.customers)
                ..where((row) => row.id.equals(customer.id)))
              .write(
            CustomersCompanion(totalDebt: Value(updatedDebt)),
          );
        }
      }

      final accountReceipts = await (_db.select(
        _db.paymentAccountTransactions,
      )..where(
              (entry) =>
                  entry.invoiceId.equals(targetInvoice.id) &
                  entry.kind.equals('sale'),
            ))
          .get();

      for (final receipt in accountReceipts) {
        await _db.into(_db.paymentAccountTransactions).insert(
          PaymentAccountTransactionsCompanion.insert(
            accountId: receipt.accountId,
            invoiceId: Value(targetInvoice.id),
            invoiceNumber: Value(targetInvoice.invoiceNumber),
            userId: userId,
            kind: 'refund',
            amount: receipt.amount,
            note: const Value('عكس تحصيل فاتورة مرتجعة'),
          ),
        );
      }

      await (_db.update(_db.invoices)
        ..where(
              (invoice) => invoice.id.equals(targetInvoice.id),
        ))
          .write(
        const InvoicesCompanion(
          status: Value('returned'),
        ),
      );

      return targetInvoice.id;
    });
  }

  String _normalizePhone(String? phone) =>
      (phone ?? '').replaceAll(RegExp(r'\D'), '');
}
