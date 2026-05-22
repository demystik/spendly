import 'package:flutter/material.dart';
import 'package:spendly/models/category_model.dart';
import 'package:spendly/models/expense_model.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class ExpenseProvider with ChangeNotifier {
  final List<Expense> _expenses = [];

  //getter for expense list
  List<Expense> get expense => _expenses;

  //add new expense
  void addExpense(double amount, String title, DateTime date, String note, 
  Category category, String paymentType,
  ) {
    final newExpense = Expense(id: uuid.v4(), title: title, amount: amount,
      date: date, note: note, category: category, paymentType: paymentType,
    );
    _expenses.insert(0, newExpense);

    notifyListeners();
  }



  //variables for searching
  Category? selectedCategory;
  double maxAmount = 2000;
  String searchQuery = "";

  //Set category to what user click
  void setCategory(Category? category){
    selectedCategory = category;
    notifyListeners();
  }

  //Set maximum amount
  void setMaxAmount(double amount){
    maxAmount = amount;
    notifyListeners();
  }

  //Set search query
  void setSearchQuery(String query){
    searchQuery = query;
    notifyListeners();
  }

//Reset filter when user leave the page
  void resetFilters(){
    selectedCategory = null;
    searchQuery = "";
    maxAmount = 2000;
    notifyListeners();
  }

  List<Expense> get filteredExpenses {

   return _expenses.where((expense) { 
    final matchesCategory = selectedCategory == null || 
    expense.category == selectedCategory;
    
      final matchesAmount = expense.amount <= maxAmount;
    
    final matchesSearch = searchQuery.isEmpty || 
    expense.title.toLowerCase()
    .contains(searchQuery.toLowerCase());

      return matchesAmount && matchesCategory && matchesSearch;
  }).toList();
  }
  
}
