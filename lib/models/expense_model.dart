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

class RecentTransaction {
  int transactionId;
  Category transactionCategory;
  DateTime transactionTime;
  double transactionAmount;
  String transactionNote;
  RecentTransaction({
    required this.transactionId,
    required this.transactionCategory,
    required this.transactionTime,
    required this.transactionAmount,
    required this.transactionNote,
  });
}

List<RecentTransaction> recentTransactions = [
  RecentTransaction(transactionId: DateTime.now().millisecondsSinceEpoch, transactionCategory: categoryList[0], transactionTime: DateTime.now(), transactionAmount: 25.50, transactionNote: "Uber Ride"),
  RecentTransaction(transactionId: DateTime.now().millisecondsSinceEpoch, transactionCategory: categoryList[1], transactionTime: DateTime.now(), transactionAmount: 18.50, transactionNote: "Starbucks Coffee"),
  RecentTransaction(transactionId: DateTime.now().millisecondsSinceEpoch, transactionCategory: categoryList[2], transactionTime: DateTime.now(), transactionAmount: 43.00, transactionNote: "Apple Store"),
  RecentTransaction(transactionId: DateTime.now().millisecondsSinceEpoch, transactionCategory: categoryList[3], transactionTime: DateTime.now(), transactionAmount: 72.00, transactionNote: "Whole Food Market"),
  RecentTransaction(transactionId: DateTime.now().millisecondsSinceEpoch, transactionCategory: categoryList[4], transactionTime: DateTime.now(), transactionAmount: 37.0, transactionNote: "Netflix Subsciption"),
];

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
