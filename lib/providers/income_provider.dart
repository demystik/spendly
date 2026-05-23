import 'package:flutter/material.dart';
import 'package:spendly/models/income_model.dart';

class IncomeProvider with ChangeNotifier {
  IncomeModel? _income;

  IncomeModel? get income => _income;

  double get monthlyIncome {
    return _income?.amount ?? 0;
  }

  bool get hasIncome {
    return _income != null;
  }

  void setIncome(double amount) {
    _income = IncomeModel(
      amount: amount,
      updatedAt: DateTime.now(),
    );

    notifyListeners();
  }

  void clearIncome() {
    _income = null;
    notifyListeners();
  }
}