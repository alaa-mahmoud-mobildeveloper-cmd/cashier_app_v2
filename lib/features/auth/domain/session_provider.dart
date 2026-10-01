import 'package:injectable/injectable.dart';

abstract class SessionProvider {
  int get currentUserId;
  int? get authenticatedUserId;
  void startSession(int userId);
  void endSession();
}

@LazySingleton(as: SessionProvider)
class InMemorySessionProvider implements SessionProvider {
  int? _userId;

  @override
  int get currentUserId =>
      _userId ?? (throw StateError('لا يوجد مستخدم مسجل الدخول'));

  @override
  int? get authenticatedUserId => _userId;

  @override
  void startSession(int userId) => _userId = userId;

  @override
  void endSession() => _userId = null;
}
