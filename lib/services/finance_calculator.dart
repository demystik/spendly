import 'package:intl/intl.dart';
import 'package:spendly/models/expense_model.dart';

// Total Amount Spent_____________________________________________
double calculateAmountSpent(List<Expense> totalExpense) {
  if (totalExpense.isEmpty) return 0.0;
  final DateTime now = DateTime.now();
  double amountSpent = 0;
  for (Expense expense in totalExpense) {
    if (expense.date.month == now.month && expense.date.year == now.year) {
      amountSpent += expense.amount;
    }
  }
  return amountSpent;
}

//ExpensefInsight__________________________________
(double, String) expenseInsight(List<Expense> totalExpense) {
  final DateTime now = DateTime.now();
  double expenseThisMonth = 0;
  double expenseLastMonth = 0;
  //calculate for this month
  for (Expense expense in totalExpense) {
    if (expense.date.month == now.month && expense.date.year == now.year) {
      expenseThisMonth += expense.amount;
    }
  }
  //calculate for last month  or Last Year (New Year)
  if (now.year == 1) {
    for (Expense expense in totalExpense) {
      if (expense.date.month == 12 && expense.date.year == now.year - 1) {
        expenseThisMonth += expense.amount;
      }
    }
    //calculate for last month
  } else {
    for (Expense expense in totalExpense) {
      if (expense.date.month == now.month - 1 &&
          expense.date.year == now.year) {
        expenseThisMonth += expense.amount;
      }
    }
  }
  double difference = expenseThisMonth - expenseLastMonth;
  String percent = expenseLastMonth == 0
      ? "No expenses"
      : "${((difference / expenseLastMonth).clamp(0, double.infinity).toInt() * 100)} %";
  return (difference, percent);
}

// Calculate Average Daily Spent__________________________________________
double averageDailySpent(double totalSpent) {
  final todaysNumber = DateTime.now().day; //22
  double averageSpent = (totalSpent / todaysNumber).clamp(0, double.infinity);
  return averageSpent;
}

//Format Money from double to actual money________________________
String formatCurrency(double amount, {int decimalDigits = 2}) {
  return NumberFormat.currency(
    symbol: '₦',
    decimalDigits: decimalDigits,
  ).format(amount);
}

//Caculate Savings___________________________________
(double, int) calculateSavings(double income, double expense) {
  if (income <= 0 && expense <= 0) return (0.0, 0);
  final savings = income - expense;
  final percent = ((savings / income) * 100).toInt();
  return (savings, percent);
}

double percentbudgetHealthScore(double budget, double totalSpent) {
  // spent ÷ expected spending pace
  // Expected spending pace = (currentDay ÷ daysInMonth)× budget
  DateTime now = DateTime.now();
  final currentDay = DateTime.now().day; //22
  final int daysInMonth = DateTime(now.year, now.month + 1, 0).day;
  final expectedSpendingPace = budget <= 0
      ? (currentDay / daysInMonth) * 1
      : (currentDay / daysInMonth) * budget;
  final percentHealth = totalSpent <= 0
      ? 0.0
      : totalSpent / expectedSpendingPace * 100;
  return percentHealth;
}

String translatePercentage(double percent) {
  if (percent < 0) {
    return "Spending Health";
  } else if (percent >= 0 && percent <= 50) {
    return "Excellent";
  } else if (percent >= 51 && percent <= 100) {
    return "Good";
  } else if (percent >= 101 && percent <= 120) {
    return "Warning";
  } else {
    return "Dangerous";
  }
}

//CalcuateAmountSpent on this category________________
double categorySpent({
  required List<Expense> expenses,
  required String categoryId,
}) {
  final now = DateTime.now();

  return expenses
      .where(
        (expense) =>
            expense.category.id == categoryId &&
            expense.date.month == now.month &&
            expense.date.year == now.year,
      )
      .fold(0, (prev, item) => prev + item.amount);
}

double calculatePercentAmountSpent(double budget, double totalSpent) {
  if (totalSpent <= 0 || budget <= 0) {
    return 0;
  }
  double percent = (totalSpent / budget).clamp(0, double.infinity) * 100;

  return percent;
}

//Amount Spent in the last 7 daays____________________________________
List<double> weeklySpending({required List<Expense> expenses}) {
  final DateTime now = DateTime.now();

  // Monday -> Sunday
  List<double> weeklyTotals = List.filled(7, 0);

  for (Expense expense in expenses) {
    final difference = now.difference(expense.date).inDays;

    // only include last 7 days
    if (difference >= 0 && difference < 7) {
      // weekday:
      // Monday = 1
      // Sunday = 7
      int index = expense.date.weekday - 1;

      weeklyTotals[index] += expense.amount;
    }
  }

  return weeklyTotals;
}
