import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:spendly/models/category_model.dart';
import 'package:spendly/models/expense_model.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class ExpenseProvider with ChangeNotifier {
  // final List<Expense> _expenses = [];
  final Box<Expense> _expenseBox = Hive.box<Expense>('expensesBox');

  //getter for expense list
  // final List<Expense> expenses => _expenses;
  List<Expense> get expenseBox => _expenseBox.values.toList().reversed.toList();
  
  List<Expense> get recentExpense {
    final recent = _expenseBox.values.toList();
    recent.sort(
      (a, b) => b.date.compareTo(a.date)
    );
    return recent.take(5).toList();
  } 

  //add new expense
  void addExpense  (double amount, String title, DateTime date, String note, 
  Category category, String paymentType,
  ) async {
    final newExpense = Expense(id: uuid.v4(), title: title, amount: amount,
      date: date, note: note, categoryId: category.id, paymentType: paymentType,
    );

    // _expenses.insert(0, newExpense);
    await _expenseBox.put(newExpense.id, newExpense);

    notifyListeners();
  }



  //variables for searching
  Category? selectedCategory;
  double maxAmount = 1000000;
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

   return expenseBox.where((expense) { 
    final matchesCategory = selectedCategory == null || 
    expense.categoryId == selectedCategory!.id;
    
      final matchesAmount = expense.amount <= maxAmount;
    
    final matchesSearch = searchQuery.isEmpty || 
    expense.title.toLowerCase()
    .contains(searchQuery.toLowerCase());

      return matchesAmount && matchesCategory && matchesSearch;
  }).toList();
  }
  

  //Helper method to help get category by using Id
  Category getCategoryById(String id){
    return categoryList.firstWhere((cat) => cat.id == id, orElse: () => Category(id: "Unknown", name: "Unknown", color: Colors.grey, icon: LucideIcons.helpCircle),);
  }
}
