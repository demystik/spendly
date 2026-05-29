import 'package:spendly/models/category_model.dart';

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