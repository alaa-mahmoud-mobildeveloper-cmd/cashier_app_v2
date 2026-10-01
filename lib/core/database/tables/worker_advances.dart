import 'package:drift/drift.dart';

import 'users_table.dart';

class WorkerAdvances extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get workerId =>
      integer().references(Users, #id, onDelete: KeyAction.cascade)();

  RealColumn get amount => real()();

  TextColumn get reason => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
