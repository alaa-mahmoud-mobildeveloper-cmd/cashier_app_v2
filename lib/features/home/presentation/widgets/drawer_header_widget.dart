import 'package:flutter/material.dart';

class DrawerHeaderWidget extends StatelessWidget {
  const DrawerHeaderWidget();

  @override
  Widget build(BuildContext context) {
    return const DrawerHeader(
      decoration: BoxDecoration(color: Colors.black87),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CircleAvatar(radius: 24, child: Icon(Icons.person)),
          SizedBox(height: 8),
          Text('احمد', style: TextStyle(color: Colors.white, fontSize: 16)),
          Text('مدير النظام', style: TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }
}