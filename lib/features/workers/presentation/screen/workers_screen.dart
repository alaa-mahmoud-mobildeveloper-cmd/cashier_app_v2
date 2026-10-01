import 'package:cashier_app_v2/core/database/app_database.dart';
import 'package:cashier_app_v2/features/workers/data/repositories/worker_repository.dart';
import 'package:cashier_app_v2/features/workers/presentation/screen/worker_details_screen.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../di.dart';
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
  late final WorkerRepository _repository;
  late final Stream<List<Worker>> _workersStream;
  String _currentFilter = 'الكل';

  @override
  void initState() {
    super.initState();
    _repository = WorkerRepository(getIt<AppDatabase>());
    _workersStream = _repository.watchWorkers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Worker> _filteredWorkers(List<Worker> workers) {
    final query = _searchController.text.trim().toLowerCase();
    return workers.where((worker) {
      final queryMatch =
          query.isEmpty ||
          worker.name.toLowerCase().contains(query) ||
          worker.phone.contains(query) ||
          worker.role.toLowerCase().contains(query);
      final filterMatch =
          _currentFilter == 'الكل' ||
          (_currentFilter == 'نشط' && worker.status == WorkerStatus.active) ||
          (_currentFilter == 'غير نشط' &&
              worker.status == WorkerStatus.inactive);
      return queryMatch && filterMatch;
    }).toList();
  }

  Future<void> _addWorker() async {
    final worker = await showDialog<Worker>(
      context: context,
      builder: (_) => const AddWorkerDialog(),
    );
    if (worker == null || !mounted) return;

    try {
      await _repository.addWorker(worker);
      if (mounted) _showMessage('تم حفظ العامل');
    } catch (error) {
      if (mounted) _showMessage('تعذر حفظ العامل: $error');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: StreamBuilder<List<Worker>>(
            stream: _workersStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('تعذر تحميل العمال: ${snapshot.error}'),
                );
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final workers = snapshot.data!;
              return LayoutBuilder(
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
                        _buildSummarySection(workers, isCompact),
                        const SizedBox(height: 16),
                        _buildFiltersSection(),
                        const SizedBox(height: 16),
                        _buildWorkersList(_filteredWorkers(workers)),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSummarySection(List<Worker> workers, bool isCompact) {
    final activeCount = workers
        .where((w) => w.status == WorkerStatus.active)
        .length;
    final inactiveCount = workers.length - activeCount;

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
          value: '${workers.length}',
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

  Widget _buildFiltersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _searchController,
          onChanged: (_) => setState(() {}),
          decoration: const InputDecoration(
            hintText: 'ابحث باسم العامل أو الهاتف أو الوظيفة...',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: ['الكل', 'نشط', 'غير نشط']
              .map(
                (value) => ChoiceChip(
                  label: Text(value),
                  selected: _currentFilter == value,
                  onSelected: (_) => setState(() => _currentFilter = value),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildWorkersList(List<Worker> filtered) {
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
          onToggle: () => _toggleWorker(worker),
          onView: () => _showWorkerDetails(worker),
          onDelete: () => _archiveWorker(worker),
        );
      },
    );
  }

  Future<void> _toggleWorker(Worker worker) async {
    final id = worker.id;
    if (id == null) return;
    try {
      await _repository.setWorkerActive(
        id,
        worker.status != WorkerStatus.active,
      );
    } catch (error) {
      if (mounted) _showMessage('تعذر تحديث حالة العامل: $error');
    }
  }

  Future<void> _showWorkerDetails(Worker worker) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => WorkerDetailsScreen(worker: worker)),
    );
  }

  Future<void> _archiveWorker(Worker worker) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('إخفاء العامل'),
        content: Text(
          'سيتم إخفاء ${worker.name} من قائمة العمال مع الاحتفاظ بالسلف وسجل الأصناف.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('إخفاء'),
          ),
        ],
      ),
    );

    if (confirmed != true || worker.id == null) return;
    try {
      await _repository.archiveWorker(worker.id!);
    } catch (error) {
      if (mounted) _showMessage('تعذر إخفاء العامل: $error');
    }
  }
}
