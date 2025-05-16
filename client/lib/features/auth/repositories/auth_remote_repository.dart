import 'package:dio/dio.dart';
import 'package:donardiary/core/constants/api_endpoints.dart';
import 'package:donardiary/core/exeptions/app_exeptions.dart';

import 'package:donardiary/core/network/dio_client.dart';
import 'package:donardiary/core/network/error_handler.dart';
import 'package:donardiary/features/auth/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fpdart/fpdart.dart';

final authRemoteRepository = Provider.autoDispose<AuthRemoteRepository>((ref) {
  final dio = ref.watch(dioClientProvider);
  return AuthRemoteRepository(dio);
});

class AuthRemoteRepository {
  final Dio dio;
  AuthRemoteRepository(this.dio);

  Future<Either<AppException, UserModel>> signUp(UserModel data) async {
    try {
      final response = await dio.post(
          ApiEndPoints.baseUrl + ApiEndPoints.register,
          data: data.toJson());

      if (response.statusCode != 201) {
        return Left(response.data['message']);
      } else {
        return Right(UserModel.fromMap(response.data["data"]));
      }
    } on DioException catch (e) {
      return Left(ErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(AppException(message: e.toString()));
    }
  }

  Future<Either<AppException, UserModel>> signIn(UserModel data) async {
    try {
      final response = await dio.post(ApiEndPoints.baseUrl + ApiEndPoints.login,
          data: data.toJson());

      if (response.statusCode != 200) {
        return Left(response.data['message']);
      } else {
        return Right(UserModel.fromMap(response.data["data"]));
      }
    } on DioException catch (e) {
      return Left(ErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(AppException(message: e.toString()));
    }
  }

  


}
