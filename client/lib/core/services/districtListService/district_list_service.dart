import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sri_lanka_provinces_districts_cities/sri_lanka_provinces_districts_cities.dart';

class DistrictListNotifier extends Notifier<List<District>> {
  late List<District> localDistricts;
  
  @override
  List<District> build() {
    localDistricts = slDistricts;
    // Assume `districtsList` contains all districts
    return localDistricts;
  }

  List<DropdownMenuEntry<District>> get districtsList {
    return localDistricts
        .map((e) => DropdownMenuEntry<District>(
              label: e.nameEn,
              value: e,
            ))
        .toList();
  }
}

final districtListNotifierProvider =
    NotifierProvider<DistrictListNotifier, List<District>>(
  () => DistrictListNotifier(),
);