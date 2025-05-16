import 'dart:io';

import 'package:donardiary/features/auth/model/previous_donation_model.dart';
import 'package:donardiary/features/auth/model/user_model.dart';
import 'package:donardiary/features/auth/repositories/auth_remote_repository.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sri_lanka_provinces_districts_cities/sri_lanka_provinces_districts_cities.dart';

import '../../../core/services/secure_storage_service/secure_storage_service.dart';

part 'auth_view_model.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late final AuthRemoteRepository _authRemoteRepository;
  late final SecureStorageService _secureStorageService;

  @override
  AsyncValue<UserModel>? build() {
    _authRemoteRepository = ref.read(authRemoteRepository);
    _secureStorageService = ref.read(secureStorageServiceProvider);
    return null;
  }

  bool showPassword = true;
  bool showConfirmPassword = true;

  void togglePasswordShow() {
    showPassword = !showPassword;
  }

  void toggleConfirmPasswordShow() {
    showConfirmPassword = !showConfirmPassword;
  }

  Future<void> checkLogin() async {
    try {
      state = const AsyncValue.loading();
      final accessToken = await _secureStorageService.getAccessToken();
      final refreshToken = await _secureStorageService.getRefreshToken();

      if (accessToken != null && refreshToken != null) {
        state = AsyncValue.data(
            UserModel(accessToken: accessToken, refreshToken: refreshToken));
      } else {
        state = AsyncValue.error("No tokens found", StackTrace.current);
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> login({required email, required password}) async {
    try {
      state = const AsyncValue.loading();
      final res = await _authRemoteRepository
          .signIn(UserModel(email: email, password: password));

      switch (res) {
        case Left(value: final value):
          state = AsyncValue.error(value.message, StackTrace.current);
        case Right(value: final value):

          // Save tokens to secure storage
          await _secureStorageService.saveAccessToken(value.accessToken!);
          await _secureStorageService.saveRefreshToken(value.refreshToken!);
          await _secureStorageService.saveUserData(value);
          state = AsyncValue.data(value);
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> signUP(UserModel model) async {
    try {
      state = const AsyncValue.loading();
      final res = await _authRemoteRepository.signUp(model);
      final val = switch (res) {
        Left(value: final value) => state =
            AsyncValue.error(value.message, StackTrace.current),
        Right(value: final value) => state = AsyncValue.data(value),
      };
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> logout() async {
    try {
      await _secureStorageService.deleteTokens();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<List<DropdownMenuEntry<Cities>>> getCityFromDistrict(
      District district) async {
    try {
      state = const AsyncValue.loading();
      final res = getCitiesByDistrictId(district.id);
      final List<DropdownMenuEntry<Cities>> cityList = res
          .map((e) => DropdownMenuEntry<Cities>(
                label: e.nameEn,
                value: e,
              ))
          .toList();
      return cityList;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
    return [];
  }

  File? imageFile;
  String? imagePath;

  List<PreviousDonationModel> previousDoners = [];

  void addPreviousDonations(PreviousDonationModel prevDonation) {
    previousDoners.add(prevDonation);
  }
}
