import 'package:cashier_app_v2/core/database/app_database.dart';
import 'package:cashier_app_v2/features/auth/data/repositories/auth_repository.dart';
import 'package:cashier_app_v2/features/auth/data/security/password_hasher.dart';
import 'package:cashier_app_v2/features/auth/domain/session_provider.dart';
import 'package:cashier_app_v2/features/workers/data/repositories/worker_repository.dart';
import 'package:cashier_app_v2/features/workers/domain/entities/worker.dart';
import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late InMemorySessionProvider session;
  late AuthRepository repository;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    session = InMemorySessionProvider();
    repository = AuthRepository(database, session, PasswordHasher());
  });

  tearDown(() async {
    await database.close();
  });

  test(
    'creates first admin, authenticates, updates login time, and signs out',
    () async {
      expect(await repository.hasLoginAccounts(), isFalse);

      await repository.createInitialAdmin(
        username: 'Administrator',
        fullName: 'مدير النظام',
        password: 'Str0ng-local-password-2026',
      );

      expect(await repository.hasLoginAccounts(), isTrue);
      final stored = await database.select(database.users).getSingle();
      expect(stored.username, 'administrator');
      expect(stored.passwordHash, startsWith('argon2id-v1:'));
      expect(stored.passwordHash, isNot('Str0ng-local-password-2026'));

      expect(
        await repository.signIn(
          username: 'administrator',
          password: 'wrong-password',
        ),
        isNull,
      );
      expect(session.authenticatedUserId, isNull);

      final user = await repository.signIn(
        username: 'ADMINISTRATOR',
        password: 'Str0ng-local-password-2026',
      );
      expect(user?.id, stored.id);
      expect(user?.role, 'admin');
      expect(session.currentUserId, stored.id);

      final loggedIn = await (database.select(
        database.users,
      )..where((row) => row.id.equals(stored.id))).getSingle();
      expect(loggedIn.isLoggedIn, isTrue);
      expect(loggedIn.lastLogin, isNotNull);

      await repository.signOut();
      expect(session.authenticatedUserId, isNull);
      final loggedOut = await (database.select(
        database.users,
      )..where((row) => row.id.equals(stored.id))).getSingle();
      expect(loggedOut.isLoggedIn, isFalse);
    },
  );

  test(
    'upgrades a legacy plaintext password after a successful sign-in',
    () async {
      await database
          .into(database.users)
          .insert(
            UsersCompanion.insert(
              username: 'legacy',
              passwordHash: 'legacy-pass-123',
              fullName: 'Legacy Admin',
              role: const Value('admin'),
            ),
          );

      final user = await repository.signIn(
        username: 'legacy',
        password: 'legacy-pass-123',
      );
      expect(user, isNotNull);

      final stored = await (database.select(
        database.users,
      )..where((row) => row.username.equals('legacy'))).getSingle();
      expect(stored.passwordHash, startsWith('argon2id-v1:'));
      expect(stored.passwordHash, isNot('legacy-pass-123'));
    },
  );

  test(
    'workers are excluded from login and do not count as admin accounts',
    () async {
      final workers = WorkerRepository(database);
      await workers.addWorker(
        Worker(name: 'موظف', phone: '01012345678', role: 'كاشير', salary: 4000),
      );

      expect(await repository.hasLoginAccounts(), isFalse);
      final worker = await database.select(database.users).getSingle();
      expect(
        await repository.signIn(
          username: worker.username,
          password: 'anything-at-all',
        ),
        isNull,
      );
      expect(session.authenticatedUserId, isNull);
    },
  );

  test('inactive users cannot sign in', () async {
    await repository.createInitialAdmin(
      username: 'inactive',
      fullName: 'Disabled Admin',
      password: 'Another-strong-password-2026',
    );
    await (database.update(database.users)
          ..where((user) => user.username.equals('inactive')))
        .write(const UsersCompanion(isActive: Value(false)));

    expect(
      await repository.signIn(
        username: 'inactive',
        password: 'Another-strong-password-2026',
      ),
      isNull,
    );
    expect(session.authenticatedUserId, isNull);
  });
}
