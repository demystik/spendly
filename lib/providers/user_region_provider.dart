import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:spendly/models/region_model.dart';

class UserRegionProvider with ChangeNotifier {
  final Box _settingsBox = Hive.box('settingsBox');

  // RegionModel _selectedRegion = regions.first;
  RegionModel get selectedRegion => _settingsBox.get(

    defaultValue: ''
  );
  String currencySymbol = '₦';

  void changeRegion(RegionModel selectregion) {
    _selectedRegion = selectregion;

    notifyListeners();
  }
}
