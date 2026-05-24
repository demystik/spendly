import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class Category {
  String id;
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


List<Category> categoryList = [
  Category(
    id: "transport",
    name: "Transport",
    color: Colors.blue,
    icon: LucideIcons.car,
  ),
  Category(
    id: "food_and_drinks",
    name: "Food & Drinks",
    color: Colors.green,
    icon: LucideIcons.coffee,
  ),
  Category(
    id: "shopping",
    name: "Shopping",
    color: Colors.indigo,
    icon: LucideIcons.shoppingBag,
  ),
  Category(
    id: "groceries",
    name: "Groceries",
    color: Colors.lightBlue,
    icon: LucideIcons.utensils,
  ),
  Category(
    id: "bills",
    name: "Bills",
    color: Colors.brown,
    icon: LucideIcons.wallet,
  ),
  Category(
    id: "health",
    name: "Health",
    color: Colors.amber,
    icon: LucideIcons.heartPulse,
  ),
  Category(
    id: "entertainment",
    name: "Entertainment",
    color: Colors.redAccent,
    icon: LucideIcons.gamepad2,
  ),
];