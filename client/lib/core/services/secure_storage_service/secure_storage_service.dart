import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features/auth/model/user_model.dart';

final secureStorageServiceProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService();
});

class SecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Save access token
  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: 'access_token', value: token);
  }

  // Save refresh token
  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: 'refresh_token', value: token);
  }

  // Retrieve access token (optional)
  Future<String?> getAccessToken() async {
    return await _storage.read(key: 'access_token') ;
  }

  // Retrieve refresh token (optional)
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: 'refresh_token');
  }

  // save userdata
  Future<void> saveUserData(UserModel user) async {
    await _storage.write(key: "user_data", value: user.toJson());
  }

  //get userData
  Future<UserModel?> getUserData() async {
    final userData = await _storage.read(key: "user_data");
    if (userData != null) {
      return UserModel.fromJson(userData);
    }
    return null;
  }

  // Delete tokens (optional, e.g., for logout)
  Future<void> deleteTokens() async {
    await _storage.delete(key: 'access_token');
    await _storage.delete(key: 'refresh_token');
  }
}
