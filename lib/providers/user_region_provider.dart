import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:spendly/models/region_model.dart';

class UserRegionProvider with ChangeNotifier {
  final Box _settingsBox = Hive.box('settingsBox');

  // RegionModel _selectedRegion = regions.first;
  RegionModel get selectedRegion {
    final regionId = _settingsBox.get('region_id', defaultValue: '₦');
    return regions.firstWhere((region) => region.currency == regionId);
  }

  // String currencySymbol = '₦';

  void changeRegion(RegionModel selectregion) {
    // _selectedRegion = selectregion;
    _settingsBox.put('region_id', selectregion.currency);

    notifyListeners();
  }
}
