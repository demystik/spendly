
import 'package:intl/intl.dart';

(String month, String year) currentMonthAndYear(DateTime currentDate){
  String currentMonth = DateFormat("MMMM").format(currentDate);
  String currentYear = DateFormat("y").format(currentDate);
  return(currentMonth, currentYear);
}

void main(){
var date = currentMonthAndYear(DateTime.now());
var (month, year) = date;
print("$month, $year");
}