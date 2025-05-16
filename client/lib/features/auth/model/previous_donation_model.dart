class PreviousDonationModel {
  final int? donationId;
  final int? donationUserId;
  final String? donationDate;
  final String? donationLocation;

  PreviousDonationModel(
      {this.donationId,
      this.donationDate,
      this.donationLocation,
      this.donationUserId});
  PreviousDonationModel.fromJson(Map<String, dynamic> json)
      : donationId = json['id'],
        donationDate = json['date'] as String?,
        donationUserId = json['user_id'],
        donationLocation = json['place'] as String?;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': donationId,
      'user_id': donationUserId,
      'date': donationDate,
      'place': donationLocation,
    };
  }
}
