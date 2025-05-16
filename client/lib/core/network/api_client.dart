import 'package:dio/dio.dart';
import 'package:donardiary/core/constants/api_endpoints.dart';
import 'package:donardiary/features/auth/model/user_model.dart';

import '../exeptions/app_exeptions.dart';
import 'error_handler.dart';

class ApiClient {
  final Dio dio;

  ApiClient() : dio = Dio() {
    dio.options = BaseOptions(
      baseUrl: ApiEndPoints.baseUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );
  }

  //login
  Future<Response> login(String email, String password, UserModel data) async {
    
    try {
      final response = await dio.post(ApiEndPoints.baseUrl+ApiEndPoints.login,
      data:data
      );
      print(response);
      return response;
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    } catch (e) {
      throw AppException(message: 'Unknown error occurred');
    }
  
  }
}
