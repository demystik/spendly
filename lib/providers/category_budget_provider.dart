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
    required String month,
    required String year,
  }) {
    //get current budget for all categories
    final currentAllocated = allocatedBudget(month: month, year: year);

    //get budget for this actual category
    final currentCategoryAmount = getCategoryBudget(category.id, month, year);

    // get remaining category allocatable budget
    final remainingBudget =
        totalBudget - (currentAllocated - currentCategoryAmount);

    if (amount > remainingBudget) {
      return false;
    }

    //Update Budget for this category
    //find the category i want to update
    final index = _categoryBudget.indexWhere(
      (cat) =>
          cat.categoryId == category.id &&
          cat.month == month &&
          cat.year == year,
    );

    if (index != -1) {
      //if found, update it
      _categoryBudget[index] = CategoryBudget(
        month: month,
        year: year,
        budgetAmount: amount,
        categoryId: category.id,
      );
    } else {
      //create new category budget
      _categoryBudget.add(
        CategoryBudget(
          month: month,
          year: year,
          budgetAmount: amount,
          categoryId: category.id,
        ),
      );
    }

    notifyListeners();

    return true;
  }

  //Total Amount allocated
  double allocatedBudget({required String month, required String year}) {
    return _categoryBudget
        .where((cat) => cat.month == month && cat.year == year)
        .fold(0, (previous, element) => previous + element.budgetAmount);
  }

  //Remaining allocatable budget
  double remainingBudget(double totalBudget, String month, String year) {
    return totalBudget - allocatedBudget(month: month, year: year);
  }

  //Category budget lookup
  double getCategoryBudget(String categoryId, String month, String year) {
    return _categoryBudget
        .firstWhere(
          (cat) =>
              cat.categoryId == categoryId &&
              cat.month == month &&
              cat.year == year,
          orElse: () => CategoryBudget(
            month: month,
            year: year,
            budgetAmount: 0,
            categoryId: categoryId,
          ),
        )
        .budgetAmount;
  }
}
