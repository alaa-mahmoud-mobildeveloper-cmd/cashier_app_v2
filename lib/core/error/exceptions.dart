class DatabaseException implements Exception {
  final String message;
  DatabaseException(this.message);
}

class ValidationException implements Exception {
  final String message;
  ValidationException(this.message);
}

class NotFoundException implements Exception {
  final String message;
  NotFoundException(this.message);
}
