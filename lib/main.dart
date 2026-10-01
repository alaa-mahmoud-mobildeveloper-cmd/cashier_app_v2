import 'package:cashier_app_v2/core/theme/app_theme.dart';
import 'package:cashier_app_v2/features/auth/presentation/screen/auth_gate.dart';
import 'package:flutter/material.dart';

import 'di.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cashier App',
      theme: AppTheme.dark(),
      themeMode: ThemeMode.dark,
      home: const AuthGate(),
    );
  }
}
