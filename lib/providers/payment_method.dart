import 'package:flutter/material.dart';

class PaymentMethodProvider  with ChangeNotifier {
  String? _selectedMethod;
  int? _selectedCategory;

  String? get selectedMethod => _selectedMethod;
  int? get selectedCategory => _selectedCategory;

  void changePaymentMethod(String? method){
    _selectedMethod = method;
    notifyListeners();
  }

  void changeCategory(int? category){
    _selectedCategory = category;
    notifyListeners();
  }

}