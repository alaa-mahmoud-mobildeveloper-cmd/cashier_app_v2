import 'package:drift/drift.dart';

import 'payment_accounts.dart';

class Expenses extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text()();

  TextColumn get category => text()();

  RealColumn get amount => real()();

  TextColumn get notes => text().nullable()();

  TextColumn get status => text().withDefault(const Constant('paid'))();

  /// cash, credit, or payment-account id represented by paymentAccountId.
  TextColumn get paymentMethod => text().withDefault(const Constant('cash'))();

  IntColumn get paymentAccountId =>
      integer().nullable().references(PaymentAccounts, #id)();

  DateTimeColumn get expenseDate => dateTime()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
