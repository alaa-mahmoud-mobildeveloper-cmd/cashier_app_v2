import 'package:flutter/material.dart';

class PosScreen extends StatelessWidget {
  const PosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('POS Screen'),
      ),
      body: const Center(
        child: Text('This is the POS screen.'),
      ),
    );
  }
}
