import 'package:flutter/material.dart';

class CurrencyProvider  with ChangeNotifier {
  String? _selectedCurrency;


  String? get selectedCurrency => _selectedCurrency;


  void changeCurrencyType(String? method){
    _selectedCurrency = method;
    notifyListeners();
  }

}