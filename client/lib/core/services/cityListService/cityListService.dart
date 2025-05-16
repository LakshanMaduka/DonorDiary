import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sri_lanka_provinces_districts_cities/models/cities.dart';

class CityListNotifier extends Notifier<List<Cities>> {
  late List<Cities> localCities;

  @override
  List<Cities> build() {
    localCities = slCities;
    // Assume `citiesList` contains all cities
    return localCities;
  }

  List<DropdownMenuEntry<Cities>> get citiesList {
    return localCities
        .map((e) => DropdownMenuEntry<Cities>(
              label: e.nameEn,
              value: e,
            ))
        .toList();
  }

  List<DropdownMenuEntry<Cities>> getCityByDistrictId(int districtId) {
    final cities = getCitiesByDistrictId(districtId);
    return cities
        .map((e) => DropdownMenuEntry<Cities>(
              label: e.nameEn,
              value: e,
            ))
        .toList();
  }
}

final cityListNotifierProvider =
    NotifierProvider<CityListNotifier, List<Cities>>(
  () => CityListNotifier(),
);