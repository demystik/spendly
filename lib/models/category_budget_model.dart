// class CategoryBudget {
//   final String month;
//   final String year;
//   final double budgetAmount;
//   final String categoryId;

import 'package:hive_flutter/adapters.dart';

part 'category_budget_model.g.dart';

@HiveType(typeId: 3)
class CategoryBudget extends HiveObject{

  @HiveField(0)
  String month;

  @HiveField(1)
  String year;

  @HiveField(2)
  double budgetAmount;


  @HiveField(3)
  String categoryId;

  CategoryBudget({
    required this.month,
    required this.year,
    required this.budgetAmount,
    required this.categoryId,
  });
}
