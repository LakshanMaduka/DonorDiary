import 'dart:convert';

import 'package:donardiary/features/auth/model/previous_donation_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class UserModel extends Equatable {
  final String? id;
  final String? email;
  final String? username;
  final String? password;
  final String? district;
  final String? nearestCity;
  final String? profileUrl;
  final String? booldGroup;
  final String? phoneNumber;
  
  final String? refreshToken;
  final String? accessToken;
  final List<PreviousDonationModel>? previousDonations;

  const UserModel({
    this.id,
    this.email,
    this.username,
    
    this.booldGroup,
    this.district,
    this.nearestCity,
    this.profileUrl,
    this.phoneNumber,
  
    this.password,
    this.refreshToken,
    this.accessToken,
    this.previousDonations,
  });

  UserModel copyWith({
    ValueGetter<String?>? id,
    ValueGetter<String?>? email,
    ValueGetter<String?>? username,
    ValueGetter<String?>? password,
 
    ValueGetter<String?>? booldGroup,
    ValueGetter<String?>? phoneNumber,
    ValueGetter<String?>? district,
    ValueGetter<String?>? nearestCity,
    ValueGetter<String?>? profileUrl,
    
    ValueGetter<String?>? refreshToken,
    ValueGetter<String?>? accessToken,
    ValueGetter<List<PreviousDonationModel>?>? previousDonations,
  }) {
    return UserModel(
      id: id != null ? id() : this.id,
      email: email != null ? email() : this.email,
      username: username != null ? username() : this.username,
      password: password != null ? password() : this.password,
      
      booldGroup: booldGroup != null ? booldGroup() : this.booldGroup,
      phoneNumber: phoneNumber != null ? phoneNumber() : this.phoneNumber,
      district: district != null ? district() : this.district,
      nearestCity: nearestCity != null ? nearestCity() : this.nearestCity,
      profileUrl: profileUrl != null ? profileUrl() : this.profileUrl,
      refreshToken: refreshToken != null ? refreshToken() : this.refreshToken,
      accessToken: accessToken != null ? accessToken() : this.accessToken,
      previousDonations: previousDonations != null
          ? previousDonations()
          : this.previousDonations,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'username': username,
      'district': district,
      'nearest_city': nearestCity,
      'profile_url': profileUrl,
      'blood_group': booldGroup,
      'phone_number': phoneNumber,
      'previous_donations': previousDonations?.map((x) => x.toJson()).toList(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'].toString(),
      email: map['email'],
      password: map['password'],
      username: map['username'],
      refreshToken: map['refresh_token'],
      accessToken: map['access_token'],
      district: map['district'],
      nearestCity: map['nearest_city'],
      profileUrl: map['profile_url'],
      booldGroup: map['blood_group'],
      phoneNumber: map['phone_number'],
      previousDonations: map['previous_donations'] != null
          ? List<PreviousDonationModel>.from(map['previous_donations']
              .map((x) => PreviousDonationModel.fromJson(x)))
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  

  static UserModel fromStorageString(String source) => UserModel.fromJson(source);

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id:$id, email: $email, username: $username, password: $password, refreshToken: $refreshToken, accessToken: $accessToken)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      email,
      username,
      password,
      refreshToken,
      accessToken,
    ];
  }
}
