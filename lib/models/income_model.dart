// class IncomeModel {
//   final double amount;
//   final DateTime updatedAt;

import 'package:hive_flutter/adapters.dart';

@HiveType(typeId: 2)
class IncomeModel extends HiveObject{

  @HiveField(0)
  double amount;

  @HiveField(1)
  DateTime updatedAt;

  IncomeModel({
    required this.amount,
    required this.updatedAt,
  });
}