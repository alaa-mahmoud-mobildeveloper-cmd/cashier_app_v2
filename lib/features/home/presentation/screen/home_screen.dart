import 'package:cashier_app_v2/features/home/presentation/widgets/open_drawer_button.dart';
import 'package:cashier_app_v2/features/home/presentation/widgets/sid_minu.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الرئيسية')),
      drawer: const AppDrawer(),
      body: const Center(child: OpenDrawerButton()),
    );
  }
}