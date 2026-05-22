import 'package:intl/intl.dart';
import 'package:spendly/models/expense_model.dart';


// Total Amount Spent_____________________________________________
double calculateAmountSpent(List<Expense> totalExpense) {
  final DateTime now = DateTime.now();
  double amountSpent = 0;
    for(Expense expense in totalExpense){
      if(expense.date.month == now.month && expense.date.year == now.year){
        amountSpent += expense.amount;
      }
    }
  return amountSpent;
}

// String calculateAmountSaved(){

// }

//Format Money from double to actual money________________________
String formatCurrency(double amount){
  return NumberFormat.currency(
    symbol: '',
    decimalDigits: 2
  ).format(amount);
}
