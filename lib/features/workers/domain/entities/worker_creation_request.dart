import 'worker.dart';

/// Form input for creating a worker; credentials are transient and never stored
/// on the Worker domain entity.
class WorkerCreationRequest {
  final Worker worker;
  final String? username;
  final String? password;

  const WorkerCreationRequest({
    required this.worker,
    this.username,
    this.password,
  });
}
