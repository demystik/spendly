import 'package:flutter/material.dart';

class DatetimeProvider with ChangeNotifier {
  DateTime _currentDate = DateTime.now();
  DateTime get currentDate => _currentDate;

  void setDate (DateTime selectedDate){
    _currentDate = selectedDate;
    notifyListeners();
  }

  void resetDate(){
    _currentDate = DateTime.now();
    notifyListeners();
  }
}