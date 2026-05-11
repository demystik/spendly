import 'package:flutter/material.dart';
import 'package:spendly/constants/app_icons.dart';

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

class Category {
  double id;
  String name;
  Color color;
  String icon;

  Category({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
  });
}

List<Category> categoryList = [
  Category(
    id: 32142342.342,
    name: "Transport",
    color: Colors.blue,
    icon: AppIcons.ic_car,
  ),
  Category(
    id: 3452342.342,
    name: "Food & Drinks",
    color: Colors.green,
    icon: AppIcons.ic_coffee,
  ),
  Category(
    id: 321242342.342,
    name: "Shopping",
    color: Colors.indigo,
    icon: AppIcons.ic_shopping,
  ),
  Category(
    id: 009142342.342,
    name: "Groceries",
    color: Colors.lightBlue,
    icon: AppIcons.ic_groceries,
  ),
  Category(
    id: 30042342.342,
    name: "Bills",
    color: Colors.brown,
    icon: AppIcons.ic_bills,
  ),
];
