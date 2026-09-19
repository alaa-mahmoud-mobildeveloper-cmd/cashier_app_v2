import 'package:injectable/injectable.dart';

abstract class SessionProvider {
  int get currentUserId;
}

@LazySingleton(as: SessionProvider)
class StaticSessionProvider implements SessionProvider {
  @override
  int get currentUserId => 1;
}