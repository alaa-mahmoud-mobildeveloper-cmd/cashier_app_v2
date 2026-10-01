import 'package:drift/drift.dart';

class Users extends Table {
  /// رقم المستخدم
  IntColumn get id => integer().autoIncrement()();

  /// اسم الدخول
  TextColumn get username => text().withLength(min: 3, max: 50).unique()();

  /// كلمة المرور (يفضل لاحقًا تخزينها Hash)
  TextColumn get passwordHash => text()();

  /// الاسم الكامل
  TextColumn get fullName => text().withLength(min: 2, max: 100)();

  /// Worker-specific profile fields. Non-worker accounts keep the defaults.
  TextColumn get phone => text().nullable()();

  TextColumn get jobTitle => text().withDefault(const Constant(''))();

  RealColumn get salary => real().withDefault(const Constant(0))();

  TextColumn get barcode => text().nullable()();

  BoolColumn get isWorker => boolean().withDefault(const Constant(false))();

  /// الدور
  /// admin - manager - cashier
  TextColumn get role => text().withDefault(const Constant('cashier'))();

  /// صورة المستخدم
  TextColumn get image => text().nullable()();

  /// حالة الحساب
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  /// آخر تسجيل دخول
  DateTimeColumn get lastLogin => dateTime().nullable()();

  BoolColumn get isLoggedIn => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
