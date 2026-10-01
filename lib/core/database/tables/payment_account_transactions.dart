import 'package:drift/drift.dart';

import 'invoices_table.dart';
import 'payment_accounts.dart';
import 'users_table.dart';

class PaymentAccountTransactions extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get accountId => integer().references(PaymentAccounts, #id)();

  IntColumn get invoiceId => integer().nullable().references(Invoices, #id)();

  TextColumn get invoiceNumber => text().nullable()();

  IntColumn get userId => integer().references(Users, #id)();

  /// sale is a receipt; refund reverses a returned invoice receipt.
  TextColumn get kind => text()();

  /// Always stored as a positive amount; kind determines the balance sign.
  RealColumn get amount => real()();

  TextColumn get note => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
