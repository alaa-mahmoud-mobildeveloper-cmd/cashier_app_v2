import 'package:flutter/material.dart';

class OpenDrawerButton extends StatelessWidget {
  const OpenDrawerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.menu),
      label: const Text('افتح القائمة'),
      onPressed: () => Scaffold.of(context).openDrawer(),
    );
  }
}