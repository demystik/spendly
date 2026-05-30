import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:spendly/models/income_model.dart';

class IncomeProvider with ChangeNotifier {
  // IncomeModel? _income;
  final Box<IncomeModel> _incomeBox = Hive.box<IncomeModel>('incomeBox');

  IncomeModel? get _income => _incomeBox.get("current_income");

  double get monthlyIncome {
    return _income?.amount ?? 0;
  }

  bool get hasIncome {
    return _income != null;
  }

  void setIncome(double amount) {
    final newIncome = IncomeModel(
      id: "current_income",
      amount: amount,
      updatedAt: DateTime.now(),
    );
    _incomeBox.put('current_income', newIncome);

    notifyListeners();
  }

  void clearIncome() {
    _incomeBox.delete('current_income');
    notifyListeners();
  }
}