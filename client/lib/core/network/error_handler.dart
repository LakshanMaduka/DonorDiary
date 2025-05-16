import 'package:dio/dio.dart';
import "../exeptions/app_exeptions.dart";

class ErrorHandler {
  static AppException handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException();
      case DioExceptionType.badCertificate:
        return BadRequestException('Invalid certificate');
      case DioExceptionType.badResponse:
        return _handleResponseError(error);
      case DioExceptionType.cancel:
        return AppException(message: 'Request cancelled');
      case DioExceptionType.connectionError:
        return NetworkException();
      case DioExceptionType.unknown:
        return NetworkException();
    }
  }

  static AppException _handleResponseError(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    final message = data?['message']?.toString() ?? 'Something went wrong';

    switch (statusCode) {
      case 400:
        return BadRequestException(message);
      case 401:
        return UnauthorizedException(message);
      case 403:
        return AppException(message: 'Forbidden', statusCode: 403);
      case 404:
        return AppException(message: 'Resource not found', statusCode: 404);
      case 500:
        if (data != null) {
          return ServerException(data['message'], statusCode: 500);
        } else {
          return ServerException("Internel Server Error!", statusCode: 500);
        }
      // return data != null ? : ServerException('Internal server error', statusCode: 500);
      case 502:
        return ServerException('Bad gateway', statusCode: 502);
      default:
        return ServerException(message, statusCode: statusCode);
    }
  }
}
