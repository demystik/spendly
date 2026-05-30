import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:spendly/models/category_budget_model.dart';
import 'package:spendly/models/category_model.dart';

class CategoryBudgetProvider with ChangeNotifier {
  // final List<CategoryBudget> _categoryBudgets = [];
  final Box<CategoryBudget> _categoryBudgetBox = Hive.box<CategoryBudget>(
    'categoryBudgetBox',
  );
  List<CategoryBudget> get categoryBudgetBox =>
      _categoryBudgetBox.values.toList().reversed.toList();

  bool setCategoryBudget({
    required Category category,
    required double amount,
    required double totalBudget,
    required String month,
    required String year,
  }) {
    if (totalBudget <= 0) {
      return false;
    }

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
    final key = '${category.id}_$month/_$year';

    final newCategoryBudget = CategoryBudget(
      month: month,
      year: year,
      budgetAmount: amount,
      categoryId: category.id,
    );

    _categoryBudgetBox.put(key, newCategoryBudget);
    notifyListeners();

    return true;
  }

  //Total Amount allocated
  double allocatedBudget({required String month, required String year}) {
    return categoryBudgetBox
        .where((cat) => cat.month == month && cat.year == year)
        .fold(0, (previous, element) => previous + element.budgetAmount);
  }

  //Remaining allocatable budget
  double remainingBudget(double totalBudget, String month, String year) {
    return totalBudget - allocatedBudget(month: month, year: year);
  }

  //Category budget lookup
  double getCategoryBudget(String categoryId, String month, String year) {
    final key = '${categoryId}_$month/_$year';

    final budget = _categoryBudgetBox.get(key);

    return budget?.budgetAmount ?? 0.0;
  }
}
