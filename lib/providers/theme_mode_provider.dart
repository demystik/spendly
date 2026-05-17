import 'package:flutter/material.dart';

class ThemeModeProvider with ChangeNotifier{
  bool _darkMode = true;
  bool get darkMode => _darkMode;

  void changeMode(bool mode){
    _darkMode = mode;
    notifyListeners();
  }
}