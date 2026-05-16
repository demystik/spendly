import 'package:flutter/material.dart';

class AmountRangeProvider with ChangeNotifier{
  double _amountValue = 0;
  double get amountValue => _amountValue;

  void changeValue(double newValue){
    _amountValue = newValue;
    notifyListeners();
  }
}