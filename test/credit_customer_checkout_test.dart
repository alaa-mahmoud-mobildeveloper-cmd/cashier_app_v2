import 'package:cashier_app_v2/core/database/app_database.dart' as db;
import 'package:cashier_app_v2/features/auth/domain/session_provider.dart';
import 'package:cashier_app_v2/features/pos/data/models/cart_item_model.dart';
import 'package:cashier_app_v2/features/pos/data/repositories/sales_repository_impl.dart';
import 'package:cashier_app_v2/features/pos/presentation/bloc/pos_bloc.dart';
import 'package:cashier_app_v2/features/pos/presentation/bloc/pos_event.dart';
import 'package:cashier_app_v2/features/pos/presentation/bloc/pos_state.dart';
import 'package:drift/drift.dart' show Value, driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final previousDuplicateDatabaseWarning =
      driftRuntimeOptions.dontWarnAboutMultipleDatabases;
  late db.AppDatabase database;
  late SalesRepositoryImpl sales;
  late int userId;
  late db.Product product;

  setUpAll(() {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  });

  tearDownAll(() {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases =
        previousDuplicateDatabaseWarning;
  });

  setUp(() async {
    database = db.AppDatabase.forTesting(NativeDatabase.memory());
    sales = SalesRepositoryImpl(database);

    userId = await database
        .into(database.users)
        .insert(
          db.UsersCompanion.insert(
            username: 'credit_cashier',
            passwordHash: 'test-hash',
            fullName: 'كاشير اختبار الآجل',
          ),
        );

    final productId = await database
        .into(database.products)
        .insert(
          db.ProductsCompanion.insert(
            name: 'منتج آجل',
            barcode: 'TEST-CREDIT-001',
            category: 'اختبار',
            price: 25,
            stockQuantity: 10,
          ),
        );
    product = await (database.select(
      database.products,
    )..where((row) => row.id.equals(productId))).getSingle();
  });

  tearDown(() async {
    await database.close();
  });

  test(
    'creates a customer once, aggregates repeat credit debt, and reverses a return',
    () async {
      final firstInvoiceId = await sales.checkout(
        userId: userId,
        cartItems: [CartItem(product: product)],
        discount: 0,
        tax: 0,
        paymentMethod: 'credit',
        paidAmount: 5,
        newCustomerName: 'أحمد محمود',
        newCustomerPhone: '01012345678',
      );

      var customers = await database.select(database.customers).get();
      expect(customers, hasLength(1));
      final customerId = customers.single.id;

      var firstInvoice = await (database.select(
        database.invoices,
      )..where((invoice) => invoice.id.equals(firstInvoiceId))).getSingle();
      expect(firstInvoice.customerId, customerId);
      expect(firstInvoice.status, 'partial');
      expect(firstInvoice.paidAmount, 5);
      expect(firstInvoice.remainingAmount, 20);
      expect(customers.single.totalDebt, 20);

      final secondInvoiceId = await sales.checkout(
        userId: userId,
        cartItems: [CartItem(product: product)],
        discount: 0,
        tax: 0,
        paymentMethod: 'credit',
        paidAmount: 10,
        customerId: customerId,
      );

      customers = await database.select(database.customers).get();
      expect(customers, hasLength(1));
      expect(customers.single.totalDebt, closeTo(35, 0.001));

      final invoices = await database.select(database.invoices).get();
      expect(invoices, hasLength(2));
      expect(invoices.map((invoice) => invoice.customerId), [
        customerId,
        customerId,
      ]);
      expect(invoices.map((invoice) => invoice.status), ['partial', 'partial']);
      expect(invoices.map((invoice) => invoice.remainingAmount), [20, 15]);
      expect(invoices.map((invoice) => invoice.userId), [userId, userId]);

      await sales.returnInvoice(userId: userId, invoiceId: firstInvoiceId);

      customers = await database.select(database.customers).get();
      expect(customers.single.totalDebt, closeTo(15, 0.001));
      firstInvoice = await (database.select(
        database.invoices,
      )..where((invoice) => invoice.id.equals(firstInvoiceId))).getSingle();
      expect(firstInvoice.status, 'returned');
      final remainingInvoice = await (database.select(
        database.invoices,
      )..where((invoice) => invoice.id.equals(secondInvoiceId))).getSingle();
      expect(remainingInvoice.status, 'partial');

      final updatedProduct = await (database.select(
        database.products,
      )..where((row) => row.id.equals(product.id))).getSingle();
      expect(updatedProduct.stockQuantity, 9);
      final movements = await database.select(database.stockMovements).get();
      expect(movements.map((movement) => movement.quantity), [-1, -1, 1]);
    },
  );

  test(
    'sets unpaid and paid statuses and does not add paid invoices to debt',
    () async {
      final customerId = await database
          .into(database.customers)
          .insert(
            db.CustomersCompanion.insert(
              name: 'عميل قائم',
              phone: const Value('01098765432'),
            ),
          );

      final paidInvoiceId = await sales.checkout(
        userId: userId,
        cartItems: [CartItem(product: product)],
        discount: 0,
        tax: 0,
        paymentMethod: 'credit',
        paidAmount: 25,
        customerId: customerId,
      );
      final unpaidInvoiceId = await sales.checkout(
        userId: userId,
        cartItems: [CartItem(product: product)],
        discount: 0,
        tax: 0,
        paymentMethod: 'credit',
        paidAmount: 0,
        customerId: customerId,
      );

      final paidInvoice = await (database.select(
        database.invoices,
      )..where((invoice) => invoice.id.equals(paidInvoiceId))).getSingle();
      final unpaidInvoice = await (database.select(
        database.invoices,
      )..where((invoice) => invoice.id.equals(unpaidInvoiceId))).getSingle();
      final customer = await (database.select(
        database.customers,
      )..where((row) => row.id.equals(customerId))).getSingle();

      expect(paidInvoice.status, 'paid');
      expect(paidInvoice.remainingAmount, 0);
      expect(unpaidInvoice.status, 'unpaid');
      expect(unpaidInvoice.remainingAmount, 25);
      expect(customer.totalDebt, 25);
    },
  );

  test(
    'rejects duplicate normalized phone and rolls back all checkout changes',
    () async {
      await sales.checkout(
        userId: userId,
        cartItems: [CartItem(product: product)],
        discount: 0,
        tax: 0,
        paymentMethod: 'credit',
        paidAmount: 0,
        newCustomerName: 'عميل مكرر',
        newCustomerPhone: '010-123-4567',
      );

      await expectLater(
        sales.checkout(
          userId: userId,
          cartItems: [CartItem(product: product)],
          discount: 0,
          tax: 0,
          paymentMethod: 'credit',
          paidAmount: 0,
          newCustomerName: 'عميل جديد',
          newCustomerPhone: '010 123 4567',
        ),
        throwsStateError,
      );

      expect(await database.select(database.customers).get(), hasLength(1));
      expect(await database.select(database.invoices).get(), hasLength(1));
      expect(
        await database.select(database.stockMovements).get(),
        hasLength(1),
      );
      final unchangedProduct = await (database.select(
        database.products,
      )..where((row) => row.id.equals(product.id))).getSingle();
      expect(unchangedProduct.stockQuantity, 9);
    },
  );

  test(
    'rolls back a new customer if the cart has insufficient stock',
    () async {
      await (database.update(database.products)
            ..where((row) => row.id.equals(product.id)))
          .write(const db.ProductsCompanion(stockQuantity: Value(0)));

      await expectLater(
        sales.checkout(
          userId: userId,
          cartItems: [CartItem(product: product)],
          discount: 0,
          tax: 0,
          paymentMethod: 'credit',
          paidAmount: 0,
          newCustomerName: 'عميل مخزون',
          newCustomerPhone: '01011223344',
        ),
        throwsException,
      );

      expect(await database.select(database.customers).get(), isEmpty);
      expect(await database.select(database.invoices).get(), isEmpty);
      expect(await database.select(database.stockMovements).get(), isEmpty);
    },
  );

  test(
    'CheckoutCart forwards an existing customer ID through CartBloc',
    () async {
      final customerId = await database
          .into(database.customers)
          .insert(db.CustomersCompanion.insert(name: 'عميل من القائمة'));
      final session = InMemorySessionProvider()
        ..startSession(userId, role: 'cashier', fullName: 'كاشير اختبار');
      final bloc = CartBloc(sales, session);

      try {
        final cartLoaded = bloc.stream.firstWhere(
          (state) => state.cartItems.isNotEmpty,
        );
        bloc.add(AddProductToCart(product));
        await cartLoaded.timeout(const Duration(seconds: 5));

        final checkoutFinished = bloc.stream.firstWhere(
          (state) => state.status == CartStatus.checkoutSuccess,
        );
        bloc.add(
          CheckoutCart(
            paymentMethod: 'credit',
            paidAmount: 5,
            customerId: customerId,
          ),
        );
        final state = await checkoutFinished.timeout(
          const Duration(seconds: 5),
        );

        final invoice = await database.select(database.invoices).getSingle();
        final customer = await (database.select(
          database.customers,
        )..where((row) => row.id.equals(customerId))).getSingle();
        expect(invoice.customerId, customerId);
        expect(invoice.userId, userId);
        expect(invoice.status, 'partial');
        expect(customer.totalDebt, 20);
        expect(state.lastInvoiceId, invoice.id);
        expect(state.cartItems, isEmpty);
      } finally {
        await bloc.close();
      }
    },
  );

  test('CheckoutCart forwards new customer details through CartBloc', () async {
    final session = InMemorySessionProvider()
      ..startSession(userId, role: 'cashier', fullName: 'كاشير اختبار');
    final bloc = CartBloc(sales, session);

    try {
      final cartLoaded = bloc.stream.firstWhere(
        (state) => state.cartItems.isNotEmpty,
      );
      bloc.add(AddProductToCart(product));
      await cartLoaded.timeout(const Duration(seconds: 5));

      final checkoutFinished = bloc.stream.firstWhere(
        (state) => state.status == CartStatus.checkoutSuccess,
      );
      bloc.add(
        const CheckoutCart(
          paymentMethod: 'credit',
          paidAmount: 0,
          newCustomerName: 'عميل جديد عبر الكاشير',
          newCustomerPhone: '01055667788',
        ),
      );
      final state = await checkoutFinished.timeout(const Duration(seconds: 5));

      final invoice = await database.select(database.invoices).getSingle();
      final customer = await (database.select(
        database.customers,
      )..where((row) => row.id.equals(invoice.customerId!))).getSingle();
      expect(customer.name, 'عميل جديد عبر الكاشير');
      expect(customer.phone, '01055667788');
      expect(customer.totalDebt, 25);
      expect(invoice.status, 'unpaid');
      expect(state.lastInvoiceId, invoice.id);
      expect(state.cartItems, isEmpty);
    } finally {
      await bloc.close();
    }
  });
}
