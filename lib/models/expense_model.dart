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
