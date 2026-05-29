import 'package:spendly/models/category_model.dart';
// import '../database/app_database.dart';

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

  // factory Expense.fromDatabase(
  //   ExpenseTableData data,
  // ) {
  //   final category = categoryList.firstWhere(
  //     (cat) => cat.id == data.categoryId,
  //   );

  //   return Expense(
  //     id: data.id,
  //     title: data.title,
  //     amount: data.amount,
  //     date: data.date,
  //     note: data.note ?? '',
  //     category: category,
  //     paymentType: data.paymentType,
  //   );
  // }
}