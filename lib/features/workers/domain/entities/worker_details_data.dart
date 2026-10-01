import 'worker_advance.dart';
import 'worker_product_issue.dart';

class WorkerDetailsData {
  final List<WorkerAdvance> advances;
  final List<WorkerProductIssue> products;

  const WorkerDetailsData({required this.advances, required this.products});

  double get advancesTotal =>
      advances.fold(0, (total, advance) => total + advance.amount);

  double get productsTotal =>
      products.fold(0, (total, issue) => total + issue.total);
}
