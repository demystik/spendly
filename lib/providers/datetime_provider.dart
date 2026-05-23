import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  String get currentMonth{
    DateTime now = DateTime.now();
    return DateFormat("MMMM").format(now);
  }
}