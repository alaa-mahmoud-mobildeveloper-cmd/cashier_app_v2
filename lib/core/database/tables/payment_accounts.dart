import 'package:drift/drift.dart';

class PaymentAccounts extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Supported values are wallet and visa.
  TextColumn get type => text()();

  TextColumn get name => text().withLength(min: 2, max: 80)();

  TextColumn get provider => text().nullable()();

  /// Wallet phone or a safe terminal/reference label; never a full card number.
  TextColumn get reference => text().nullable()();

  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
