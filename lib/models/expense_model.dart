import 'package:flutter/material.dart';

class ExpenseModel {
  double id;
  String title;
  double amount;
  DateTime date;
  String note;
  Category category;

  ExpenseModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.note,
    required this.category,
  });
}

class Category{
  double id;
  String name;
  Color color;

  Category({
    required this.id,
    required this.name,
    required this.color,
  });
}