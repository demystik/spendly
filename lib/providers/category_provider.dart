import 'package:flutter/widgets.dart';
import 'package:spendly/models/category_model.dart';

class CategoryProvider with ChangeNotifier{

  final List<Category> _budgetCategories = List.from(categoryList);

  List<Category> get budgetCategories => _budgetCategories;

  void updateBudgetCategories(double budgetAmount, Category category){
    budgetCategories.firstWhere((cat) => cat.id == category.id).amountToSpend = budgetAmount;
    notifyListeners();
  }

  Category? _selectedCategory;

  Category? get selectedCategory => _selectedCategory;

  
  void changeCategory(Category? category){
    _selectedCategory = category;
    notifyListeners();
  }

  void resetCategory(){
    _selectedCategory = null;
    notifyListeners();
  }
}