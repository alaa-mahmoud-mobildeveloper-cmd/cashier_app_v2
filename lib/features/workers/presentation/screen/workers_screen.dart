import 'package:cashier_app_v2/features/workers/presentation/screen/worker_details_screen.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/worker.dart';
import '../widgets/add_worker_dialog.dart';

import '../widgets/worker_row.dart';
import '../widgets/worker_summary_card.dart';
import '../widgets/workers_header.dart';

class WorkersScreen extends StatefulWidget {
  const WorkersScreen({super.key});

  @override
  State<WorkersScreen> createState() => _WorkersScreenState();
}

class _WorkersScreenState extends State<WorkersScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _currentFilter = 'الكل';

  final List<Worker> _workers = [
    Worker(name: 'أحمد محمد', phone: '01012345678', role: 'كاشير', salary: 4500),
    Worker(name: 'محمد علي', phone: '01098765432', role: 'مدير مخزن', salary: 6000),
    Worker(
      name: 'سارة حسن',
      phone: '01123456789',
      role: 'كاشير',
      salary: 4200,
      status: WorkerStatus.inactive,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Worker> get _filteredWorkers {
    final query = _searchController.text.trim().toLowerCase();
    return _workers.where((worker) {
      final queryMatch = query.isEmpty ||
          worker.name.toLowerCase().contains(query) ||
          worker.phone.contains(query) ||
          worker.role.toLowerCase().contains(query);

      final filterMatch = _currentFilter == 'الكل' ||
          (_currentFilter == 'نشط' && worker.status == WorkerStatus.active) ||
          (_currentFilter == 'غير نشط' && worker.status == WorkerStatus.inactive);

      return queryMatch && filterMatch;
    }).toList();
  }

  Future<void> _addWorker() async {
    final worker = await showDialog<Worker>(
      context: context,
      builder: (_) => const AddWorkerDialog(),
    );
    if (worker != null && mounted) {
      setState(() => _workers.add(worker));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (_, constraints) {
              final isCompact = constraints.maxWidth < 800;
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: isCompact ? 12 : 28,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    WorkersHeader(onAdd: _addWorker),
                    const SizedBox(height: 16),
                    _buildSummarySection(isCompact),
                    const SizedBox(height: 16),
                    _buildFiltersSection(isCompact),
                    const SizedBox(height: 16),
                    _buildWorkersList(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSummarySection(bool isCompact) {
    final activeCount = _workers.where((w) => w.status == WorkerStatus.active).length;
    final inactiveCount = _workers.length - activeCount;

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: isCompact ? 1 : 3,
      childAspectRatio: isCompact ? 4.2 : 2.8,
      crossAxisSpacing: 16,
      mainAxisSpacing: 12,
      children: [
        WorkerSummaryCard(
          title: 'إجمالي العمال',
          value: '${_workers.length}',
          color: AppColors.gold,
          icon: Icons.groups_outlined,
        ),
        WorkerSummaryCard(
          title: 'العمال النشطون',
          value: '$activeCount',
          color: AppColors.success,
          icon: Icons.person_outline,
        ),
        WorkerSummaryCard(
          title: 'غير النشطين',
          value: '$inactiveCount',
          color: AppColors.danger,
          icon: Icons.person_off_outlined,
        ),
      ],
    );
  }

  Widget _buildFiltersSection(bool isCompact) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _searchController,
            onChanged: (_) => setState(() {}),
            decoration: const InputDecoration(
              hintText: 'ابحث باسم العامل أو الهاتف أو الوظيفة...',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        const SizedBox(width: 12),
        ...['الكل', 'نشط', 'غير نشط'].map(
              (value) => Padding(
            padding: const EdgeInsets.only(left: 8),
            child: ChoiceChip(
              label: Text(value),
              selected: _currentFilter == value,
              onSelected: (_) => setState(() => _currentFilter = value),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWorkersList() {
    final filtered = _filteredWorkers;

    if (filtered.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 32),
        child: Center(
          child: Text(
            'لا يوجد عمال مطابقون للبحث',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filtered.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, index) {
        final worker = filtered[index];
        return WorkerRow(
          worker: worker,
          onToggle: () => setState(() {
            worker.status = worker.status == WorkerStatus.active
                ? WorkerStatus.inactive
                : WorkerStatus.active;
          }),
          onView: () => _showWorkerDetails(worker),
          onDelete: () => _deleteWorker(worker),
        );
      },
    );
  }

  Future<void> _showWorkerDetails(Worker worker) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WorkerDetailsScreen(worker: worker),
      ),
    );
  }

  Future<void> _deleteWorker(Worker worker) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('حذف العامل'),
        content: Text('هل تريد حذف ${worker.name}؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('حذف'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      setState(() => _workers.remove(worker));
    }
  }
}