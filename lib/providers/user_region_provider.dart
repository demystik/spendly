import 'package:flutter/material.dart';
import 'package:spendly/models/region_model.dart';

class UserRegionProvider with ChangeNotifier {
  RegionModel _selectedRegion = regions.first;
  RegionModel get selectedRegion => _selectedRegion;
  String currencySymbol = '₦';

  void changeRegion(RegionModel selectregion) {
    _selectedRegion = selectregion;

    notifyListeners();
  }
}
