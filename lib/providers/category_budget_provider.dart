import 'package:flutter/material.dart';
import 'package:spendly/models/category_budget_model.dart';
import 'package:spendly/models/category_model.dart';

class CategoryBudgetProvider with ChangeNotifier {
  final List<CategoryBudget> _categoryBudget = [];
  List<CategoryBudget> get categoryBudget => _categoryBudget;

  bool setCategoryBudget({
    required Category category,
    required double amount,
    required double totalBudget,
  }) {
    final currentAllocated = allocatedBudget;

    final currentCategoryAmount = getCategoryBudget(category.id);

    final remainingBudget = totalBudget - (currentAllocated - currentCategoryAmount);

    if(amount > remainingBudget) {
      return false;
    }

    //Update Budget

    notifyListeners();

    return true;
  }

  //Total Amount allocated
  double get allocatedBudget {
    return _categoryBudget.fold(
      0,
      (previous, element) => previous + element.budgetAmount,
    );
  }

  //Remaining allocatable budget
  double remainingBudget(double totalBudget) {
    return totalBudget - allocatedBudget;
  }

  //Category budget lookup
  double getCategoryBudget(String categoryId) {
    return _categoryBudget
        .firstWhere(
          (cat) => cat.categoryId == categoryId,
          orElse: () => CategoryBudget(
            month: '',
            year: '',
            budgetAmount: 0,
            categoryId: categoryId,
          ),
        ).budgetAmount;
  }
}
