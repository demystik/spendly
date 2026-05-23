//Calculate Days left___________________________________________
import 'package:intl/intl.dart';

int calculateDaysLeft() {
  DateTime now = DateTime.now();
  final int currentMonthDays = DateTime(now.year, now.month + 1, 0).day;
  final todaysNumber = DateTime.now().day; //22
  return currentMonthDays - todaysNumber;
}

String currentMonth(){
  DateTime now = DateTime.now();
  final month = DateFormat("MMMM").format(now);
  return month;
}