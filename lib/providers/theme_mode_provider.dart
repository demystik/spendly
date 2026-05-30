import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeModeProvider with ChangeNotifier{
  final Box _settingsBox = Hive.box("settingsBox");
  // bool _darkMode = false;
  bool get darkMode => _settingsBox.get("dark_mode",
  defaultValue: false);

  void changeMode(bool mode){
    _settingsBox.put("dark_mode", !darkMode);
    notifyListeners();
  }
}