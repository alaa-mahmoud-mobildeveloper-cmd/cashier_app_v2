import 'package:drift/drift.dart';

class DailyClosings extends Table {
  IntColumn get id => integer().autoIncrement()();

  DateTimeColumn get date => dateTime()();

  RealColumn get totalSales =>
      real().withDefault(const Constant(0))();

  RealColumn get totalPurchases =>
      real().withDefault(const Constant(0))();

  RealColumn get totalExpenses =>
      real().withDefault(const Constant(0))();

  RealColumn get cashBalance =>
      real().withDefault(const Constant(0))();

  RealColumn get posBalance =>
      real().withDefault(const Constant(0))();

  RealColumn get walletBalance =>
      real().withDefault(const Constant(0))();

  RealColumn get expectedBalance =>
      real().withDefault(const Constant(0))();

  RealColumn get difference =>
      real().withDefault(const Constant(0))();

  TextColumn get note =>
      text().nullable()();

  TextColumn get userName =>
      text().nullable()();

  BoolColumn get isClosed =>
      boolean().withDefault(const Constant(false))();
}