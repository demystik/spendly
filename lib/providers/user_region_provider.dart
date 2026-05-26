import 'package:flutter/material.dart';
import 'package:spendly/models/region_model.dart';
import 'package:spendly/services/region_services.dart';

class UserRegionProvider with ChangeNotifier {
  RegionModel _selectedRegion = regions.first;
  RegionModel get selectedRegion => _selectedRegion;
  String currencySymbol = '₦';

  void changeRegion(RegionModel selectregion) {
    _selectedRegion = selectregion;

    //Update Global region service method
    RegionServices.updateRegion(
      newLocale: _selectedRegion.code,
      newCurrencySymbol: _selectedRegion.currency,
    );

    notifyListeners();
  }
}
