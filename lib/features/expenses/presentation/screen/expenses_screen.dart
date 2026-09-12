import 'package:flutter/material.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses Screen'),
      ),
      body: const Center(
        child: Text('This is the expenses screen.'),
      ),
    );
  }
}
