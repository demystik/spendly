import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spendly/models/monthly_budget_model.dart';

class BudgetProvider with ChangeNotifier{
  final List<MonthlyBudgetModel> _monthlyBudgets = [];

  List<MonthlyBudgetModel> get monthlyBudgets => UnmodifiableListView(_monthlyBudgets);

  void addBudget(double amount){
    final now = DateTime.now();
    final month = DateFormat('MMMM').format(now);
    final year = DateFormat('y').format(now);
    final newbudget = MonthlyBudgetModel(monthlyBudgetAmount: amount, dateUpdated: now, month: month, year: year);

    _monthlyBudgets.removeWhere((element) =>
      element.month == month && element.year == year
    );
    _monthlyBudgets.insert(0, newbudget);
    notifyListeners();
  }

  String get budgetAmount {
    
    final now = DateTime.now();
    final month = DateFormat('MMMM').format(now);
    final year = DateFormat('y').format(now);

    final budget = _monthlyBudgets.firstWhere(
      (eachBudget) =>
      eachBudget.month == month && eachBudget.year == year,
      orElse: ()=> MonthlyBudgetModel(monthlyBudgetAmount: 0, dateUpdated: now, month: month, year: year),
    );

    return NumberFormat.currency(
      symbol: '',
      decimalDigits: 2,
    ).format(budget.monthlyBudgetAmount);
  }
}