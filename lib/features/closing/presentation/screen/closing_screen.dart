import 'package:flutter/material.dart';

class ClosingScreen extends StatelessWidget {
  const ClosingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Closing Screen'),
      ),
      body: const Center(
        child: Text('This is the closing screen.'),
      ),
    );
  }
}
