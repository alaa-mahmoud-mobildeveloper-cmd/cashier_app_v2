import 'package:cashier_app_v2/core/database/app_database.dart';
import 'package:cashier_app_v2/features/auth/data/repositories/auth_repository.dart';
import 'package:cashier_app_v2/features/auth/data/security/password_hasher.dart';
import 'package:cashier_app_v2/features/auth/domain/session_provider.dart';
import 'package:cashier_app_v2/features/auth/presentation/screen/initial_admin_setup_screen.dart';
import 'package:cashier_app_v2/features/auth/presentation/screen/login_screen.dart';
import 'package:cashier_app_v2/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

import '../../../../di.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  late final AuthRepository _authRepository = AuthRepository(
    getIt<AppDatabase>(),
    getIt<SessionProvider>(),
    PasswordHasher(),
  );

  bool? _hasLoginAccounts;
  Object? _startupError;
  bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    _loadAccountState();
  }

  Future<void> _loadAccountState() async {
    try {
      await _authRepository.clearStaleLoginFlags();
      final hasAccounts = await _authRepository.hasLoginAccounts();
      if (mounted) setState(() => _hasLoginAccounts = hasAccounts);
    } catch (error) {
      if (mounted) setState(() => _startupError = error);
    }
  }

  Future<void> _signOut() async {
    try {
      await _authRepository.signOut();
    } finally {
      if (mounted) setState(() => _isAuthenticated = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_startupError != null) {
      return Scaffold(
        body: Center(child: Text('تعذر فتح قاعدة البيانات: $_startupError')),
      );
    }
    if (_isAuthenticated) return HomeScreen(onLogout: _signOut);
    if (_hasLoginAccounts == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (!_hasLoginAccounts!) {
      return InitialAdminSetupScreen(
        authRepository: _authRepository,
        onSetupComplete: () => setState(() => _hasLoginAccounts = true),
      );
    }
    return LoginScreen(
      authRepository: _authRepository,
      onAuthenticated: () => setState(() => _isAuthenticated = true),
    );
  }
}
