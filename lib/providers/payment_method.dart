import 'package:flutter/material.dart';

class PaymentMethodProvider  with ChangeNotifier {
  String? _selectedMethod;

  String? get selectedMethod => _selectedMethod;

  void changePaymentMethod(String? method){
    _selectedMethod = method;
    notifyListeners();
  }

}