import 'package:dio/dio.dart';
import 'package:donardiary/core/constants/api_endpoints.dart';
import 'package:donardiary/core/network/dio_client_interceptor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final dioClientProvider = Provider<Dio>((ref) {
  final options = BaseOptions(
    baseUrl: ApiEndPoints.baseUrl,
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
    sendTimeout: const Duration(seconds: 60),
  );

  final dio = Dio(options);
  final networkServiceInterceptor =
      ref.watch(dioClientInterceptorProvider(dio));

  dio.interceptors.addAll([
    
    networkServiceInterceptor,
  ]);

  return dio;
});