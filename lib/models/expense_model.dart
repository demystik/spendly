class Expense {
  String id;
  String title;
  double amount;
  DateTime date;
  String note;
  String paymentType;
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