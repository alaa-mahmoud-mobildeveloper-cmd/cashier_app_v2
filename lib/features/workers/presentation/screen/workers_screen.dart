import 'package:flutter/material.dart';

class WorkersScreen extends StatelessWidget {
  const WorkersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workers Screen'),
      ),
      body: const Center(
        child: Text('This is the workers screen.'),
      ),
    );
  }
}
