import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:spendly/models/monthly_budget_model.dart';

class BudgetProvider with ChangeNotifier{

  // final List<MonthlyBudgetModel> _monthlyBudgets = [];
  final Box<MonthlyBudgetModel> _budgetBox = Hive.box('budgetBox');

  // List<MonthlyBudgetModel> get monthlyBudgets => UnmodifiableListView(_monthlyBudgets);
  List<MonthlyBudgetModel> get budgetBox => _budgetBox.values.toList().reversed.toList();

  Future<void> addBudget(double amount) async {
    final now = DateTime.now();
    final month = DateFormat('MMMM').format(now);
    final year = DateFormat('y').format(now);
    final newbudget = MonthlyBudgetModel(monthlyBudgetAmount: amount, dateUpdated: now, month: month, year: year);

    // _budgetBox.deleteAt(0);
    // _budgetBox.values.removeWhere((element) =>
    //   element.month == month && element.year == year
    // );
    await _budgetBox.put(0, newbudget);
    // _monthlyBudgets.insert(0, newbudget);
    notifyListeners();
  }

  double get budgetAmount {
    
    final now = DateTime.now();
    final month = DateFormat('MMMM').format(now);
    final year = DateFormat('y').format(now);

    final budget = _budgetBox.values.firstWhere(
      (eachBudget) =>
      eachBudget.month == month && eachBudget.year == year,
      orElse: ()=> MonthlyBudgetModel(monthlyBudgetAmount: 0, dateUpdated: now, month: month, year: year),
    );

    return budget.monthlyBudgetAmount;
  }
}