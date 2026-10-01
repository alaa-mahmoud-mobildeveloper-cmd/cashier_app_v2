enum WorkerStatus { active, inactive }

class Worker {
  final int? id;
  final String name;
  final String phone;
  final String role;
  final double salary;
  final String? barcode; // أضف هذا السطر
  WorkerStatus status;

  Worker({
    this.id,
    required this.name,
    required this.phone,
    required this.role,
    required this.salary,
    this.barcode, // وأضفه هنا أيضاً
    this.status = WorkerStatus.active,
  });
}
