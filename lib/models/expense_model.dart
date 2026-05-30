import 'package:hive/hive.dart';

part 'expense_model.g.dart';

// class Expense {
//   String id;
//   String title;
//   double amount;
//   DateTime date;
//   String note;
//   String paymentType;
//   String categoryId;

@HiveType(typeId: 0)
class Expense extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  double amount;

  @HiveField(3)
  DateTime date;

  @HiveField(4)
  String note;

  @HiveField(5)
  String paymentType;

  @HiveField(6)
  String categoryId;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.note,
    required this.paymentType,
    required this.categoryId,
  });
}
