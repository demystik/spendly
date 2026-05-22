import 'package:intl/intl.dart';
import 'package:spendly/models/expense_model.dart';

// Total Amount Spent_____________________________________________
double calculateAmountSpent(List<Expense> totalExpense) {
  final DateTime now = DateTime.now();
  double amountSpent = 0;
  for (Expense expense in totalExpense) {
    if (expense.date.month == now.month && expense.date.year == now.year) {
      amountSpent += expense.amount;
    }
  }
  return amountSpent;
}

// Calculate Average Daily Spent__________________________________________
double averageDailySpent(double totalSpent) {
  final todaysNumber = DateTime.now().day; //22
  double averageSpent = totalSpent / todaysNumber;
  return averageSpent;
}

//Calculate Days left___________________________________________
int calculateDaysLeft() {
  DateTime now = DateTime.now();
  final int currentMonthDays = DateTime(now.year, now.month + 1, 0).day;
  final todaysNumber = DateTime.now().day; //22
  return currentMonthDays - todaysNumber;
}

//Format Money from double to actual money________________________
String formatCurrency(double amount) {
  return NumberFormat.currency(symbol: '', decimalDigits: 2).format(amount);
}
