import 'package:injectable/injectable.dart';

abstract class SessionProvider {
  int get currentUserId;
  int? get authenticatedUserId;
  String? get currentRole;
  String? get currentFullName;
  void startSession(
    int userId, {
    required String role,
    required String fullName,
  });
  void endSession();
}

@LazySingleton(as: SessionProvider)
class InMemorySessionProvider implements SessionProvider {
  int? _userId;
  String? _role;
  String? _fullName;

  @override
  int get currentUserId =>
      _userId ?? (throw StateError('لا يوجد مستخدم مسجل الدخول'));

  @override
  int? get authenticatedUserId => _userId;

  @override
  String? get currentRole => _role;

  @override
  String? get currentFullName => _fullName;

  @override
  void startSession(
    int userId, {
    required String role,
    required String fullName,
  }) {
    _userId = userId;
    _role = role.trim().toLowerCase();
    _fullName = fullName.trim();
  }

  @override
  void endSession() {
    _userId = null;
    _role = null;
    _fullName = null;
  }
}
