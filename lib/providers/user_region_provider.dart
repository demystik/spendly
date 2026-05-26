import 'package:flutter/material.dart';
import 'package:spendly/constants/regions_list.dart';

class UserRegionProvider with ChangeNotifier{
  String? _selectedRegion = userRegion[0];
  String? get selectedRegion => _selectedRegion;

  void changeRegion(String? region){
    _selectedRegion = region;
    notifyListeners();
  }
}