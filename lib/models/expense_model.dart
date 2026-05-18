import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
// import 'package:spendly/constants/app_icons.dart';

class Expense {
  String id;
  String title;
  double amount;
  DateTime date;
  String note;
  String paymentType;
  Category category;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.note,
    required this.category,
    required this.paymentType,
  });
}

class Category {
  double id;
  String name;
  Color color;
  IconData icon;

  Category({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
  });
}

class RecentTransaction {
  String transactionId;
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


List<Category> categoryList = [
  Category(
    id: 32142342.342,
    name: "Transport",
    color: Colors.blue,
    icon: LucideIcons.car,
  ),
  Category(
    id: 3452342.342,
    name: "Food & Drinks",
    color: Colors.green,
    icon: LucideIcons.coffee,
  ),
  Category(
    id: 321242342.342,
    name: "Shopping",
    color: Colors.indigo,
    icon: LucideIcons.shoppingBag,
  ),
  Category(
    id: 009142342.342,
    name: "Groceries",
    color: Colors.lightBlue,
    icon: LucideIcons.utensils,
  ),
  Category(
    id: 30042342.342,
    name: "Bills",
    color: Colors.brown,
    icon: LucideIcons.wallet,
  ),
  Category(
    id: 300442,
    name: "Health",
    color: Colors.amber,
    icon: LucideIcons.heartPulse,
  ),
  Category(
    id: 300232442,
    name: "Entertainment",
    color: Colors.redAccent,
    icon: LucideIcons.gamepad2,
  ),
];
