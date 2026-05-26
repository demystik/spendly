import 'package:flutter/material.dart';
import 'package:spendly/models/region_model.dart';

class UserRegionProvider with ChangeNotifier {
  RegionModel _selectedRegion = regions.first;
  RegionModel get selectedRegion => _selectedRegion;

  void changeRegion(String? selectregion) {
    _selectedRegion = regions.firstWhere(
      (region) => region.name == selectregion,
    );
    notifyListeners();
  }
}
