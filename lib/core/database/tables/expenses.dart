import 'package:drift/drift.dart';

class Expenses extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text()();

  TextColumn get category => text()();

  RealColumn get amount => real()();

  TextColumn get notes => text().nullable()();

  TextColumn get status => text().withDefault(const Constant('paid'))();

  DateTimeColumn get expenseDate => dateTime()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
