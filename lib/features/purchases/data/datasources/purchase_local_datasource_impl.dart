import 'package:cashier_app_v2/core/database/app_database.dart';
import 'package:cashier_app_v2/features/purchases/domian/entities/save_purchase_params.dart';
import 'package:cashier_app_v2/features/purchases/domian/entities/details_invoice.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../domian/entities/purchase_invoice.dart';
import 'purchase_local_datasource.dart';

@LazySingleton(as: PurchaseLocalDataSource)
class PurchaseLocalDataSourceImpl implements PurchaseLocalDataSource {
  PurchaseLocalDataSourceImpl(this._db);

  final AppDatabase _db;

  @override
  Future<void> savePurchase(SavePurchaseParams params) async {
    await _db.transaction(() async {
      final purchaseId = await _db.into(_db.purchases).insert(
        PurchasesCompanion.insert(
          supplierId: params.supplierId,
          invoiceNumber: params.invoiceNumber,
          total: params.total,
          discount: Value(params.discount),
          tax: Value(params.tax),
          netTotal: params.netTotal,
          paymentMethod: params.paymentMethod,
          dueDate: Value(params.dueDate),
        ),
      );

      for (final item in params.items) {
        await _db.into(_db.purchaseItems).insert(
          PurchaseItemsCompanion.insert(
            purchaseId: purchaseId,
            productId: item.productId,
            quantity: item.quantity,
            purchasePrice: item.purchasePrice,
            total: item.total,
            cartonQuantity: Value(item.cartonQuantity),
            unitsPerCarton: Value(item.unitsPerCarton),
            salePrice:Value(item.salePrice),
          ),
        );

        final product = await (_db.select(_db.products)
          ..where((p) => p.id.equals(item.productId)))
            .getSingleOrNull();

        if (product == null) {
          throw Exception(
            'المنتج غير موجود: ${item.productId}',
          );
        }

        final addedUnits =
        (item.cartonQuantity * item.unitsPerCarton).round();

        final newStockQuantity =
            product.stockQuantity + addedUnits;

        final newCartonQuantity =
            product.cartonQuantity + item.cartonQuantity;

        final unitPurchasePrice = item.unitsPerCarton > 0
            ? item.purchasePrice / item.unitsPerCarton
            : item.purchasePrice;

        await (_db.update(_db.products)
          ..where((p) => p.id.equals(item.productId)))
            .write(
          ProductsCompanion(
            stockQuantity: Value(newStockQuantity),
            cartonQuantity: Value(newCartonQuantity),
            cartonPrice: Value(item.purchasePrice),
            unitsPerCarton: Value(item.unitsPerCarton),
            purchasePrice: Value(unitPurchasePrice),
            price: Value(item.salePrice),
            updatedAt: Value(DateTime.now()),
          ),
        );
      }

      if (params.paidAmount > 0) {
        await _db.into(_db.purchasePayments).insert(
          PurchasePaymentsCompanion.insert(
            purchaseId: purchaseId,
            amount: params.paidAmount,
            paymentMethod: const Value('cash'),
          ),
        );
      }
    });
  }
  @override
  Stream<List<PurchaseInvoice>> watchPurchaseInvoices() {
    final query = _db.select(_db.purchases).join([
      leftOuterJoin(
        _db.suppliers,
        _db.suppliers.id.equalsExp(
          _db.purchases.supplierId,
        ),
      ),
      leftOuterJoin(
        _db.purchasePayments,
        _db.purchasePayments.purchaseId.equalsExp(
          _db.purchases.id,
        ),
      ),
    ]);

    return query.watch().asyncMap((rows) async {
      final purchases = <int, PurchaseInvoice>{};
      final paymentsByPurchase = <int, double>{};

      for (final row in rows) {
        final purchase = row.readTable(_db.purchases);
        final supplier = row.readTableOrNull(_db.suppliers);
        final payment = row.readTableOrNull(_db.purchasePayments);

        paymentsByPurchase.putIfAbsent(purchase.id, () => 0);

        if (payment != null) {
          paymentsByPurchase[purchase.id] =
              paymentsByPurchase[purchase.id]! + payment.amount;
        }

        if (purchases.containsKey(purchase.id)) {
          continue;
        }

        final items = await (_db.select(_db.purchaseItems)
          ..where(
                (item) => item.purchaseId.equals(purchase.id),
          ))
            .get();

        purchases[purchase.id] = PurchaseInvoice(
          id: purchase.id,
          invoiceNumber: purchase.invoiceNumber,
          supplier: supplier?.name ?? 'مورد غير معروف',
          createdAt: purchase.createdAt,
          itemsCount: items.length,
          total: purchase.total,
          discount: purchase.discount,
          tax: purchase.tax,
          netTotal: purchase.netTotal,
          paymentMethod: purchase.paymentMethod,
          paidAmount: 0,
          remainingAmount: purchase.netTotal,
        );
      }

      return purchases.values.map((invoice) {
        final paidAmount = paymentsByPurchase[invoice.id] ?? 0;

        final remainingAmount = (invoice.netTotal - paidAmount)
            .clamp(0, double.infinity)
            .toDouble();

        return PurchaseInvoice(
          id: invoice.id,
          invoiceNumber: invoice.invoiceNumber,
          supplier: invoice.supplier,
          createdAt: invoice.createdAt,
          itemsCount: invoice.itemsCount,
          total: invoice.total,
          discount: invoice.discount,
          tax: invoice.tax,
          netTotal: invoice.netTotal,
          paymentMethod: invoice.paymentMethod,
          paidAmount: paidAmount,
          remainingAmount: remainingAmount,
        );
      }).toList();
    });
  }

  @override
  Future<PurchaseInvoiceDetails> getPurchaseInvoiceDetails(
      int invoiceId,
      ) async {
    final purchase = await (_db.select(_db.purchases)
      ..where((p) => p.id.equals(invoiceId)))
        .getSingleOrNull();

    if (purchase == null) {
      throw Exception('فاتورة المشتريات غير موجودة');
    }

    final supplier = await (_db.select(_db.suppliers)
      ..where((s) => s.id.equals(purchase.supplierId)))
        .getSingleOrNull();

    final rows = await (_db.select(_db.purchaseItems).join([
      leftOuterJoin(
        _db.products,
        _db.products.id.equalsExp(
          _db.purchaseItems.productId,
        ),
      ),
    ])
      ..where(
        _db.purchaseItems.purchaseId.equals(invoiceId),
      ))
        .get();

    final items = rows.map((row) {
      final item = row.readTable(_db.purchaseItems);
      final product = row.readTableOrNull(_db.products);

      return PurchaseInvoiceItem(
        productId: item.productId,
        productName: product?.name ?? 'منتج غير معروف',
        barcode: product?.barcode ?? '',
        cartonQuantity: item.cartonQuantity,
        unitsPerCarton: item.unitsPerCarton,
        purchasePrice: item.purchasePrice,
        salePrice: item.salePrice,
        total: item.total,
      );
    }).toList();

    final paymentRows = await (_db.select(_db.purchasePayments)
      ..where(
            (p) => p.purchaseId.equals(purchase.id),
      )
      ..orderBy([
            (p) => OrderingTerm(
          expression: p.createdAt,
          mode: OrderingMode.desc,
        ),
      ]))
        .get();

    final paidAmount = paymentRows.fold<double>(
      0,
          (sum, payment) => sum + payment.amount,
    );

    final remainingAmount = (purchase.netTotal - paidAmount)
        .clamp(0, double.infinity)
        .toDouble();
    final payments = paymentRows.map((payment) {
      return PurchasePaymentEntity(
        id: payment.id,
        purchaseId: payment.purchaseId,
        amount: payment.amount,
        paymentMethod: payment.paymentMethod,
        createdAt: payment.createdAt,
        note: payment.note,
      );
    }).toList();

    return PurchaseInvoiceDetails(
      id: purchase.id,
      invoiceNumber: purchase.invoiceNumber,
      supplierName: supplier?.name ?? 'مورد غير معروف',
      createdAt: purchase.createdAt,
      total: purchase.total,
      discount: purchase.discount,
      tax: purchase.tax,
      netTotal: purchase.netTotal,
      paymentMethod: purchase.paymentMethod,
      dueDate: purchase.dueDate,
      paidAmount: paidAmount,
      remainingAmount: remainingAmount,
      items: items,
      payments: payments,
    );
  }
  @override
  Future<void> collectPurchasePayment({
    required int purchaseId,
    required double amount,
    String paymentMethod = 'cash',
    String? note,
  }) async {
    if (amount <= 0) {
      throw Exception('مبلغ التحصيل يجب أن يكون أكبر من صفر');
    }

    await _db.transaction(() async {
      final purchase = await (_db.select(_db.purchases)
        ..where((p) => p.id.equals(purchaseId)))
          .getSingleOrNull();

      if (purchase == null) {
        throw Exception('فاتورة المشتريات غير موجودة');
      }

      final payments = await (_db.select(_db.purchasePayments)
        ..where((p) => p.purchaseId.equals(purchaseId)))
          .get();

      final paidAmount = payments.fold<double>(
        0,
            (sum, payment) => sum + payment.amount,
      );

      final remainingAmount = purchase.netTotal - paidAmount;

      if (remainingAmount <= 0.01) {
        throw Exception('الفاتورة تم تحصيلها بالكامل');
      }

      if (amount > remainingAmount + 0.01) {
        throw Exception(
          'مبلغ التحصيل أكبر من المبلغ المتبقي',
        );
      }

      await _db.into(_db.purchasePayments).insert(
        PurchasePaymentsCompanion.insert(
          purchaseId: purchaseId,
          amount: amount,
          paymentMethod: Value(paymentMethod),
          note: Value(note),
        ),
      );
    });
  }
}