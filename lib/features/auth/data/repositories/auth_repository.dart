import 'package:cashier_app_v2/core/database/app_database.dart';
import 'package:cashier_app_v2/features/auth/data/security/password_hasher.dart';
import 'package:cashier_app_v2/features/auth/domain/session_provider.dart';
import 'package:drift/drift.dart';

class AuthUser {
  final int id;
  final String username;
  final String fullName;
  final String role;

  const AuthUser({
    required this.id,
    required this.username,
    required this.fullName,
    required this.role,
  });
}

class AuthRepository {
  final AppDatabase _database;
  final SessionProvider _session;
  final PasswordHasher _passwordHasher;

  AuthRepository(this._database, this._session, this._passwordHasher);

  Future<void> clearStaleLoginFlags() async {
    await _database
        .update(_database.users)
        .write(const UsersCompanion(isLoggedIn: Value(false)));
  }

  Future<bool> hasLoginAccounts() async {
    final users = await (_database.select(
      _database.users,
    )..where((user) => user.isWorker.equals(false))).get();
    return users.any(
      (user) => !user.passwordHash.startsWith('WORKER_LOGIN_DISABLED:'),
    );
  }

  Future<void> createInitialAdmin({
    required String username,
    required String fullName,
    required String password,
  }) async {
    final normalizedUsername = username.trim().toLowerCase();
    final normalizedName = fullName.trim();
    if (normalizedUsername.length < 3 || normalizedUsername.length > 50) {
      throw ArgumentError('اسم المستخدم يجب أن يكون بين 3 و50 حرفًا');
    }
    if (normalizedName.length < 2 || normalizedName.length > 100) {
      throw ArgumentError('أدخل اسمًا صحيحًا للمدير');
    }
    if (password.length < 12 || password.length > 256) {
      throw ArgumentError('كلمة المرور يجب أن تكون بين 12 و256 حرفًا');
    }

    final passwordHash = await _passwordHasher.hashPassword(password);
    await _database.transaction(() async {
      final existing = await (_database.select(
        _database.users,
      )..where((user) => user.isWorker.equals(false))).get();
      if (existing.any(
        (user) => !user.passwordHash.startsWith('WORKER_LOGIN_DISABLED:'),
      )) {
        throw StateError(
          'تم إعداد حساب بالفعل؛ سجّل الدخول بدلًا من إنشاء حساب جديد',
        );
      }

      await _database
          .into(_database.users)
          .insert(
            UsersCompanion.insert(
              username: normalizedUsername,
              passwordHash: passwordHash,
              fullName: normalizedName,
              role: const Value('admin'),
            ),
          );
    });
  }

  /// Returns null for an unknown, inactive, worker, or invalid-credential account.
  Future<AuthUser?> signIn({
    required String username,
    required String password,
  }) async {
    final normalizedUsername = username.trim().toLowerCase();
    if (normalizedUsername.isEmpty ||
        password.isEmpty ||
        password.length > 256) {
      return null;
    }

    final user =
        await (_database.select(_database.users)..where(
              (row) =>
                  row.username.equals(normalizedUsername) &
                  row.isWorker.equals(false),
            ))
            .getSingleOrNull();
    if (user == null || !user.isActive) return null;

    final verification = await _passwordHasher.verifyPassword(
      password: password,
      storedValue: user.passwordHash,
    );
    if (!verification.isValid) return null;

    final upgradedHash = verification.needsUpgrade
        ? await _passwordHasher.hashPassword(password)
        : null;
    final now = DateTime.now();
    await _database.transaction(() async {
      await _database
          .update(_database.users)
          .write(const UsersCompanion(isLoggedIn: Value(false)));
      await (_database.update(
        _database.users,
      )..where((row) => row.id.equals(user.id))).write(
        UsersCompanion(
          isLoggedIn: const Value(true),
          lastLogin: Value(now),
          passwordHash: upgradedHash == null
              ? const Value.absent()
              : Value(upgradedHash),
        ),
      );
    });

    _session.startSession(user.id);
    return AuthUser(
      id: user.id,
      username: user.username,
      fullName: user.fullName,
      role: user.role,
    );
  }

  Future<void> signOut() async {
    final userId = _session.authenticatedUserId;
    _session.endSession();
    if (userId == null) return;

    await (_database.update(_database.users)
          ..where((user) => user.id.equals(userId)))
        .write(const UsersCompanion(isLoggedIn: Value(false)));
  }
}
