class AppException implements Exception {
  final String message;
  final String? code;
  final int? statusCode;

  AppException({
    required this.message,
    this.code,
    this.statusCode,
  });

  @override
  String toString() => message;
}

// Specific exceptions
class NetworkException extends AppException {
  NetworkException() : super(message: 'No internet connection');
}

class UnauthorizedException extends AppException {
  UnauthorizedException(String message)
      : super(message: message, statusCode: 401);
}

class ServerException extends AppException {
  ServerException(String message, {int? statusCode})
      : super(message: message, statusCode: statusCode);
}

class TimeoutException extends AppException {
  TimeoutException() : super(message: 'Request timed out');
}

class BadRequestException extends AppException {
  BadRequestException(String message)
      : super(message: message, statusCode: 400);
}