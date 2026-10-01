import 'dart:io';

import 'package:cashier_app_v2/core/database/app_database.dart' as db;
import 'package:cashier_app_v2/features/payment_accounts/data/payment_account_repository.dart';
import 'package:cashier_app_v2/features/pos/data/models/cart_item_model.dart';
import 'package:cashier_app_v2/features/pos/data/repositories/sales_repository_impl.dart';
import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final previousDuplicateDatabaseWarning =
      driftRuntimeOptions.dontWarnAboutMultipleDatabases;
  late db.AppDatabase database;
  late PaymentAccountRepository accounts;
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
    accounts = PaymentAccountRepository(database);
    sales = SalesRepositoryImpl(database);

    userId = await database
        .into(database.users)
        .insert(
          db.UsersCompanion.insert(
            username: 'cashier_test',
            passwordHash: 'test-hash',
            fullName: 'كاشير الاختبار',
          ),
        );

    final productId = await database
        .into(database.products)
        .insert(
          db.ProductsCompanion.insert(
            name: 'منتج اختبار',
            barcode: 'TEST-PAYMENT-001',
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
    'records wallet and Visa receipts and reverses them on invoice return',
    () async {
      final walletId = await accounts.addAccount(
        type: 'wallet',
        name: 'محفظة الفرع',
        provider: 'Vodafone Cash',
        reference: '01000000000',
      );
      final visaId = await accounts.addAccount(
        type: 'visa',
        name: 'جهاز فيزا 1',
        provider: 'بنك الاختبار',
        reference: '1234',
      );
      expect(
        () => accounts.addAccount(
          type: 'visa',
          name: 'مرجع غير آمن',
          reference: '4111 1111 1111 1111',
        ),
        throwsArgumentError,
      );

      final walletInvoiceId = await sales.checkout(
        userId: userId,
        cartItems: [CartItem(product: product)],
        discount: 0,
        tax: 0,
        paymentMethod: 'wallet',
        paymentAccountId: walletId,
      );
      final visaInvoiceId = await sales.checkout(
        userId: userId,
        cartItems: [CartItem(product: product)],
        discount: 0,
        tax: 0,
        paymentMethod: 'visa',
        paymentAccountId: visaId,
      );

      final invoices = await database.select(database.invoices).get();
      expect(invoices.map((invoice) => invoice.paymentMethod), [
        'wallet',
        'visa',
      ]);
      expect(invoices.map((invoice) => invoice.userId), [userId, userId]);

      final walletEntries = await accounts.watchEntries(walletId).first;
      final visaEntries = await accounts.watchEntries(visaId).first;
      expect(walletEntries, hasLength(1));
      expect(walletEntries.single.kind, 'sale');
      expect(walletEntries.single.invoiceId, walletInvoiceId);
      expect(walletEntries.single.amount, 25);
      expect(walletEntries.single.userId, userId);
      expect(visaEntries, hasLength(1));
      expect(visaEntries.single.invoiceId, visaInvoiceId);

      var summaries = await accounts.watchSummaries().first;
      expect(
        summaries.singleWhere((account) => account.id == walletId).balance,
        25,
      );
      expect(
        summaries.singleWhere((account) => account.id == visaId).balance,
        25,
      );

      await sales.returnInvoice(userId: userId, invoiceId: walletInvoiceId);
      final returnedEntries = await accounts.watchEntries(walletId).first;
      expect(returnedEntries, hasLength(2));
      expect(returnedEntries.first.kind, 'refund');
      summaries = await accounts.watchSummaries().first;
      expect(
        summaries.singleWhere((account) => account.id == walletId).balance,
        0,
      );
      expect(
        summaries.singleWhere((account) => account.id == visaId).balance,
        25,
      );
    },
  );

  test(
    'rejects missing, inactive, or mismatched digital accounts atomically',
    () async {
      final walletId = await accounts.addAccount(
        type: 'wallet',
        name: 'محفظة الفرع',
      );

      Future<int> checkout({required String method, int? accountId}) {
        return sales.checkout(
          userId: userId,
          cartItems: [CartItem(product: product)],
          discount: 0,
          tax: 0,
          paymentMethod: method,
          paymentAccountId: accountId,
        );
      }

      await expectLater(checkout(method: 'wallet'), throwsStateError);
      await expectLater(
        checkout(method: 'visa', accountId: walletId),
        throwsStateError,
      );

      await accounts.setAccountActive(accountId: walletId, isActive: false);
      await expectLater(
        checkout(method: 'wallet', accountId: walletId),
        throwsStateError,
      );

      expect(await database.select(database.invoices).get(), isEmpty);
      expect(
        await database.select(database.paymentAccountTransactions).get(),
        isEmpty,
      );
      final unchangedProduct = await (database.select(
        database.products,
      )..where((row) => row.id.equals(product.id))).getSingle();
      expect(unchangedProduct.stockQuantity, 10);
      expect(await accounts.getActiveAccounts(type: 'wallet'), isEmpty);
    },
  );

  test('cash checkout does not create a digital account entry', () async {
    await sales.checkout(
      userId: userId,
      cartItems: [CartItem(product: product)],
      discount: 0,
      tax: 0,
      paymentMethod: 'cash',
    );

    expect(
      await database.select(database.paymentAccountTransactions).get(),
      isEmpty,
    );
  });

  test(
    'schema version 18 upgrade creates both account ledger tables',
    () async {
      final directory = await Directory.systemTemp.createTemp(
        'payment_accounts_test_',
      );
      final file = File('${directory.path}/accounts.sqlite');
      late db.AppDatabase fileDatabase;
      fileDatabase = db.AppDatabase.forTesting(NativeDatabase(file));

      try {
        await fileDatabase.customStatement(
          'DROP TABLE payment_account_transactions',
        );
        await fileDatabase.customStatement('DROP TABLE payment_accounts');
        await fileDatabase.customStatement('PRAGMA user_version = 18');
        await fileDatabase.close();

        fileDatabase = db.AppDatabase.forTesting(NativeDatabase(file));
        expect(
          await fileDatabase.select(fileDatabase.paymentAccounts).get(),
          isEmpty,
        );
        expect(
          await fileDatabase
              .select(fileDatabase.paymentAccountTransactions)
              .get(),
          isEmpty,
        );
        final version = await fileDatabase
            .customSelect('PRAGMA user_version')
            .getSingle();
        expect(version.read<int>('user_version'), 19);
      } finally {
        await fileDatabase.close();
        await directory.delete(recursive: true);
      }
    },
  );
}
