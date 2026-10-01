class WorkerAdvance {
  final int id;
  final int workerId;
  final double amount;
  final String? reason;
  final DateTime createdAt;

  const WorkerAdvance({
    required this.id,
    required this.workerId,
    required this.amount,
    required this.reason,
    required this.createdAt,
  });
}
