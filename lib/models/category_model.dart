import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class Category {
  double id;
  String name;
  Color color;
  IconData icon;
  double amountToSpend;

  Category({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
    required this.amountToSpend,
  });
}


List<Category> categoryList = [
  Category(
    id: 32142342.342,
    name: "Transport",
    color: Colors.blue,
    icon: LucideIcons.car,
    amountToSpend: 0.0,
  ),
  Category(
    id: 3452342.342,
    name: "Food & Drinks",
    color: Colors.green,
    icon: LucideIcons.coffee,
    amountToSpend: 0.0,
  ),
  Category(
    id: 321242342.342,
    name: "Shopping",
    color: Colors.indigo,
    icon: LucideIcons.shoppingBag,
    amountToSpend: 0.0,
  ),
  Category(
    id: 009142342.342,
    name: "Groceries",
    color: Colors.lightBlue,
    icon: LucideIcons.utensils,
    amountToSpend: 0.0,
  ),
  Category(
    id: 30042342.342,
    name: "Bills",
    color: Colors.brown,
    icon: LucideIcons.wallet,
    amountToSpend: 0.0,
  ),
  Category(
    id: 300442,
    name: "Health",
    color: Colors.amber,
    icon: LucideIcons.heartPulse,
    amountToSpend: 0.0,
  ),
  Category(
    id: 300232442,
    name: "Entertainment",
    color: Colors.redAccent,
    icon: LucideIcons.gamepad2,
    amountToSpend: 0.0,
  ),
];