import 'package:flutter/material.dart';

/// شاشة مؤقتة للوحة التحكم - استبدلها بفيتشر كامل لاحقاً بنفس نمط باقي الفيتشرز
class DashboardPlaceholder extends StatelessWidget {
  const DashboardPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('لوحة التحكم - قيد الإنشاء', style: TextStyle(color: Colors.white38)),
    );
  }
}
