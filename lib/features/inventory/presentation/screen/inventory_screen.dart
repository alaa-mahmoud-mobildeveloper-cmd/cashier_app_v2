import 'package:flutter/material.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory Screen'),
      ),
      body: const Center(
        child: Text('This is the inventory screen.'),
      ),
    );
  }
}
