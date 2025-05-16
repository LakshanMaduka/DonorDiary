import 'package:donardiary/core/services/secure_storage_service/secure_storage_service.dart';
import 'package:donardiary/features/auth/model/previous_donation_model.dart';
import 'package:donardiary/features/auth/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_view_model.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  Future<UserModel?> build() async {
    return _getUserData();
  }

  Future<UserModel?> _getUserData() async {
    final userData = await ref.read(secureStorageServiceProvider).getUserData();
    return userData;
  }

  int get totalDonationsCount {
    final user = state.value;
    return user?.previousDonations?.length ?? 0;
  }

  int? get daysSinceLastDonation {
    final user = state.value;
    final donations = user?.previousDonations;

    if (donations == null || donations.isEmpty) return null;

    // Find most recent donation
    final sorted = List<PreviousDonationModel>.from(donations)
      ..sort((a, b) => b.donationDate!.compareTo(a.donationDate!));

    final lastDonationDate = DateTime.parse(sorted.first.donationDate!);
    final today = DateTime.now();

    return today.difference(lastDonationDate).inDays;
  }

  // Optional: Get formatted last donation date
  String? get lastDonationFormatted {
    final days = daysSinceLastDonation;
    if (days == null) return 'No previous donations';
    return days == 0 ? 'Today' : '$days days ago';
  }
}
