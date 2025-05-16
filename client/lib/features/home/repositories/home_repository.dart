import 'package:donardiary/core/constants/api_endpoints.dart';
import 'package:donardiary/core/exeptions/app_exeptions.dart';
import 'package:donardiary/core/network/dio_client.dart';
import 'package:donardiary/core/network/error_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:dio/dio.dart';

final homeRepository = Provider.autoDispose<HomeRepository>((ref) {
  final dio = ref.watch(dioClientProvider);
  return HomeRepository(dio);
});

class HomeRepository{
  final Dio dio;
  HomeRepository(this.dio);

  Future<Either<AppException, Map<String, dynamic>>> testApi() async {
    try {
      final respons = await dio.get(ApiEndPoints.baseUrl + ApiEndPoints.test);
      print(respons.data);
      return Right(respons.data);
    } on DioException catch (e) {
      return Left(ErrorHandler.handleDioError(e));
    }
  }
}