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
    'records wallet, Visa, and Fawry receipts and reverses returned sales',
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
      final fawryId = await accounts.addAccount(
        type: 'fawry',
        name: 'حساب فوري الفرع',
        provider: 'فوري',
        reference: 'MERCHANT-001',
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
      final fawryInvoiceId = await sales.checkout(
        userId: userId,
        cartItems: [CartItem(product: product)],
        discount: 0,
        tax: 0,
        paymentMethod: 'fawry',
        paymentAccountId: fawryId,
      );

      final invoices = await database.select(database.invoices).get();
      expect(invoices.map((invoice) => invoice.paymentMethod), [
        'wallet',
        'visa',
        'fawry',
      ]);
      expect(invoices.map((invoice) => invoice.userId), [
        userId,
        userId,
        userId,
      ]);

      final walletEntries = await accounts.watchEntries(walletId).first;
      final visaEntries = await accounts.watchEntries(visaId).first;
      final fawryEntries = await accounts.watchEntries(fawryId).first;
      expect(walletEntries, hasLength(1));
      expect(walletEntries.single.kind, 'sale');
      expect(walletEntries.single.invoiceId, walletInvoiceId);
      expect(walletEntries.single.amount, 25);
      expect(walletEntries.single.userId, userId);
      expect(visaEntries, hasLength(1));
      expect(visaEntries.single.invoiceId, visaInvoiceId);
      expect(fawryEntries, hasLength(1));
      expect(fawryEntries.single.kind, 'sale');
      expect(fawryEntries.single.invoiceId, fawryInvoiceId);
      expect(
        (await accounts.getActiveAccounts(type: 'fawry')).single.typeLabel,
        'فوري',
      );

      var summaries = await accounts.watchSummaries().first;
      expect(
        summaries.singleWhere((account) => account.id == walletId).balance,
        25,
      );
      expect(
        summaries.singleWhere((account) => account.id == visaId).balance,
        25,
      );
      expect(
        summaries.singleWhere((account) => account.id == fawryId).balance,
        25,
      );

      await sales.returnInvoice(userId: userId, invoiceId: walletInvoiceId);
      await sales.returnInvoice(userId: userId, invoiceId: fawryInvoiceId);
      final returnedEntries = await accounts.watchEntries(walletId).first;
      expect(returnedEntries, hasLength(2));
      expect(returnedEntries.first.kind, 'refund');
      final returnedFawryEntries = await accounts.watchEntries(fawryId).first;
      expect(returnedFawryEntries, hasLength(2));
      expect(
        returnedFawryEntries.any((entry) => entry.kind == 'refund'),
        isTrue,
      );
      summaries = await accounts.watchSummaries().first;
      expect(
        summaries.singleWhere((account) => account.id == walletId).balance,
        0,
      );
      expect(
        summaries.singleWhere((account) => account.id == visaId).balance,
        25,
      );
      expect(
        summaries.singleWhere((account) => account.id == fawryId).balance,
        0,
      );
    },
  );

  test('tracks wallet opening balance, deposits, and withdrawals', () async {
    final walletId = await accounts.addAccount(
      type: 'wallet',
      name: 'محفظة الرصيد',
      openingBalance: 500,
      userId: userId,
    );

    await accounts.recordDeposit(
      accountId: walletId,
      userId: userId,
      amount: 125,
      note: 'إضافة رصيد نقدي',
    );
    await accounts.recordWithdrawal(
      accountId: walletId,
      userId: userId,
      amount: 75,
      note: 'سحب للمصروفات',
    );

    final summary = (await accounts.watchSummaries().first).single;
    expect(summary.balance, 550);
    expect(summary.transactionCount, 3);

    final entries = await accounts.watchEntries(walletId).first;
    expect(entries, hasLength(3));
    expect(
      entries.singleWhere((entry) => entry.kind == 'opening_balance').amount,
      500,
    );
    expect(
      entries.singleWhere((entry) => entry.kind == 'deposit').note,
      'إضافة رصيد نقدي',
    );
    expect(
      entries.singleWhere((entry) => entry.kind == 'withdrawal').note,
      'سحب للمصروفات',
    );
    expect(
      entries.singleWhere((entry) => entry.kind == 'withdrawal').kindLabel,
      'سحب',
    );
    expect(
      entries
          .singleWhere((entry) => entry.kind == 'withdrawal')
          .decreasesBalance,
      isTrue,
    );

    await expectLater(
      accounts.recordWithdrawal(
        accountId: walletId,
        userId: userId,
        amount: 551,
      ),
      throwsStateError,
    );
    await expectLater(
      accounts.recordDeposit(
        accountId: walletId,
        userId: userId,
        amount: double.nan,
      ),
      throwsArgumentError,
    );

    final visaId = await accounts.addAccount(type: 'visa', name: 'جهاز فيزا');
    await expectLater(
      accounts.recordDeposit(accountId: visaId, userId: userId, amount: 10),
      throwsStateError,
    );
    expect(
      (await accounts.watchSummaries().first)
          .singleWhere((account) => account.id == walletId)
          .balance,
      550,
    );

    await accounts.setAccountActive(accountId: walletId, isActive: false);
    await expectLater(
      accounts.recordDeposit(accountId: walletId, userId: userId, amount: 1),
      throwsStateError,
    );
  });

  test('validates opening balance and records it atomically', () async {
    expect(
      () => accounts.addAccount(
        type: 'wallet',
        name: 'محفظة بلا مستخدم',
        openingBalance: 10,
      ),
      throwsArgumentError,
    );
    expect(
      () => accounts.addAccount(
        type: 'visa',
        name: 'جهاز فيزا برصيد',
        openingBalance: 10,
        userId: userId,
      ),
      throwsArgumentError,
    );
    expect(await database.select(database.paymentAccounts).get(), isEmpty);
    expect(
      await database.select(database.paymentAccountTransactions).get(),
      isEmpty,
    );
  });

  test(
    'rejects missing, inactive, or mismatched digital accounts atomically',
    () async {
      final walletId = await accounts.addAccount(
        type: 'wallet',
        name: 'محفظة الفرع',
      );
      final fawryId = await accounts.addAccount(
        type: 'fawry',
        name: 'حساب فوري الفرع',
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
      await expectLater(checkout(method: 'fawry'), throwsStateError);
      await expectLater(
        checkout(method: 'fawry', accountId: walletId),
        throwsStateError,
      );

      await accounts.setAccountActive(accountId: walletId, isActive: false);
      await expectLater(
        checkout(method: 'wallet', accountId: walletId),
        throwsStateError,
      );
      await accounts.setAccountActive(accountId: fawryId, isActive: false);
      await expectLater(
        checkout(method: 'fawry', accountId: fawryId),
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
      expect(await accounts.getActiveAccounts(type: 'fawry'), isEmpty);
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
