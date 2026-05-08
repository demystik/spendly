import 'package:flutter/material.dart';

class ExpenseModel {
  double id;
  String title;
  double amount;
  DateTime date;
  String note;

  ExpenseModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.note,
  });
}

class Category{
  double id;
  String name;
  Colors color;

  Category({
    required this.id,
    required this.name,
    required this.color,
  });
}