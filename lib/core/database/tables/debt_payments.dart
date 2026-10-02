import 'package:drift/drift.dart';

import 'invoices_table.dart';
import 'payment_accounts.dart';
import 'users_table.dart';

/// Immutable receipts for every payment collected against a credit invoice.
class DebtPayments extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get invoiceId => integer().references(Invoices, #id)();

  RealColumn get amount => real()();

  TextColumn get paymentMethod => text()();

  IntColumn get paymentAccountId =>
      integer().nullable().references(PaymentAccounts, #id)();

  IntColumn get userId => integer().references(Users, #id)();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
