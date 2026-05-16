import 'package:flutter/material.dart';
import 'package:spendly/models/expense_model.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class ExpenseProvider with ChangeNotifier {
  final List<Expense> _expense = [];

  //getter for expense list
  List<Expense> get expense => _expense;

  //add new expense
  void addExpense(
    double amount,
    String title,
    DateTime date,
    String note,
    Category category,
  ) {
    final newExpense = Expense(
      id: uuid.v4(),
      title: title,
      amount: amount,
      date: date,
      note: note,
      category: category,
    );
    _expense.insert(0, newExpense);
    notifyListeners();
  }

  List<Expense> filteredExpense = [];
  void searchExpenseWithRange(double range) {
    filteredExpense = _expense
        .where((expense) => expense.amount <= range)
        .toList();
    notifyListeners();
  }
  void searchExpenseWithCategory(Category category) {
    filteredExpense = _expense
        .where((expense) => expense.category == category)
        .toList();
    notifyListeners();
  }
}
