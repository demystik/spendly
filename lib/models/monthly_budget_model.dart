import 'package:hive_flutter/adapters.dart';
// class MonthlyBudgetModel {
//   double monthlyBudgetAmount;
//   DateTime dateUpdated;
//   String month;
//   String year;

@HiveType(typeId: 1)
class MonthlyBudgetModel extends HiveObject {
  @HiveField(0)
  double monthlyBudgetAmount;

  @HiveField(1)
  DateTime dateUpdated;

  @HiveField(2)
  String month;

  @HiveField(3)
  String year;

  MonthlyBudgetModel({
    required this.monthlyBudgetAmount,
    required this.dateUpdated,
    required this.month,
    required this.year,
  });
}
