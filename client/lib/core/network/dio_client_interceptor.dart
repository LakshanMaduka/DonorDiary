import 'package:dio/dio.dart';
import 'package:donardiary/core/constants/api_endpoints.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/secure_storage_service/secure_storage_service.dart';

final dioClientInterceptorProvider =
    Provider.family<DioClientInterceptor, Dio>((ref, dio) {
  final tokenService = ref.watch(secureStorageServiceProvider);
  return DioClientInterceptor(tokenService, dio);
});

final class DioClientInterceptor extends Interceptor {
  final SecureStorageService _secureStorageService;
  final Dio _dio;

  DioClientInterceptor(this._secureStorageService, this._dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await _secureStorageService.getAccessToken();

    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = 'application/json';
    // if the access token is not null, add it to the request headers
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // handle unauthorized error
    if (err.response?.statusCode == 401) {
      final token = await _secureStorageService.getRefreshToken();

      try {
        // refresh token request - api call
        final result = await _dio.post<Map<String, dynamic>>(
          ApiEndPoints.baseUrl + ApiEndPoints.refreshToken,
          data: {'refreshToken': 'Bearer $token'},
        );

        final accesToken = result.data!['accessToken'];

        // save new access token and refresh token to secure storage
        await _secureStorageService.saveAccessToken(accesToken);

        final options = err.requestOptions;
        // update request headers with new access token
        options.headers['Authorization'] = 'Bearer $accesToken';
        // repeat the request with new access token
        return handler.resolve(await _dio.fetch(options));
      } on DioException catch (e) {
        if (e.response?.statusCode == 498) {
          // remove access token and refresh token from secure storage
          await _secureStorageService.deleteTokens();
          err.response?.statusCode = 498;

          return handler.next(err);
        }

        // continue with the error
        return handler.next(err);
      }
    }
    // continue with the error
    return handler.next(err);
  }
}
