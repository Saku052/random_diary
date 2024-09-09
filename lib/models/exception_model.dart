class ApiKeyNotFoundException implements Exception {
  final String message;
  ApiKeyNotFoundException(this.message);

  @override
  String toString() => 'ApiKeyNotFoundException: $message';
}

class DatabaseIdNotFoundException implements Exception {
  final String message;
  DatabaseIdNotFoundException(this.message);

  @override
  String toString() => 'DatabaseIdNotFoundException: $message';
}

class NamePropNotFoundException implements Exception {
  final String message;
  NamePropNotFoundException(this.message);

  @override
  String toString() => 'namePropNotFoundException: $message';
}

class DatePropNotFoundException implements Exception {
  final String message;
  DatePropNotFoundException(this.message);

  @override
  String toString() => 'datePropNotFoundException: $message';
}

class IncorrectApiKeyException implements Exception {
  final String message;
  IncorrectApiKeyException(this.message);

  @override
  String toString() => 'IncorrectApiKeyException: $message';
}
