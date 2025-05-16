import 'package:donardiary/core/services/secure_storage_service/secure_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final authStateProvider = AsyncNotifierProvider<AuthStateNotifier, bool>(
  AuthStateNotifier.new,
);

class AuthStateNotifier extends AsyncNotifier<bool> {
  @override
  FutureOr<bool> build() async {
    final accessToken =
        await ref.watch(secureStorageServiceProvider).getAccessToken();
    if (accessToken != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> logout() async {
    state = const AsyncLoading();
    await ref.watch(secureStorageServiceProvider).deleteTokens();
    state = const AsyncValue.data(false);
  }
}
