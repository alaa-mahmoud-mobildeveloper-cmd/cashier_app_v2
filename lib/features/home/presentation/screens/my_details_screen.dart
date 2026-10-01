import 'package:cashier_app_v2/core/database/app_database.dart';
import 'package:cashier_app_v2/features/auth/domain/session_provider.dart';
import 'package:cashier_app_v2/features/home/presentation/screens/admin_details_screen.dart';
import 'package:cashier_app_v2/features/workers/domain/entities/worker.dart';
import 'package:cashier_app_v2/features/workers/presentation/screen/worker_details_screen.dart';
import 'package:flutter/material.dart';

import '../../../../di.dart';

class MyDetailsScreen extends StatefulWidget {
  const MyDetailsScreen({super.key});

  @override
  State<MyDetailsScreen> createState() => _MyDetailsScreenState();
}

class _MyDetailsScreenState extends State<MyDetailsScreen> {
  late final AppDatabase _database = getIt<AppDatabase>();
  late final int _userId = getIt<SessionProvider>().currentUserId;
  late final Future<User?> _userFuture = _loadCurrentUser();

  Future<User?> _loadCurrentUser() {
    return (_database.select(
      _database.users,
    )..where((user) => user.id.equals(_userId))).getSingleOrNull();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: _userFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('تعذر تحميل بيانات الحساب'));
        }
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = snapshot.data;
        if (user == null) {
          return const Center(child: Text('بيانات الحساب غير متاحة'));
        }

        if (user.role.trim().toLowerCase() == 'admin' && !user.isWorker) {
          return AdminDetailsScreen(admin: user);
        }

        final worker = Worker(
          id: user.id,
          name: user.fullName,
          phone: user.phone ?? '',
          role: user.jobTitle.trim().isNotEmpty ? user.jobTitle : user.role,
          salary: user.salary,
          barcode: user.barcode,
          status: user.isActive ? WorkerStatus.active : WorkerStatus.inactive,
        );

        return WorkerDetailsScreen(worker: worker, readOnly: true);
      },
    );
  }
}
