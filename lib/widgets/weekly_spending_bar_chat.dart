import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spendly/providers/expense_provider.dart';
import 'package:spendly/services/finance_calculator.dart';
// import 'package:spendly/models/expense_model.dart';
import 'package:spendly/themes/app_spacing.dart';

class WeeklySpendingChart extends StatelessWidget {
  const WeeklySpendingChart({super.key});

  @override
  Widget build(BuildContext context) {
    final weeklyData = weeklySpending(
      expenses: context.watch<ExpenseProvider>().expense,
    );
    return SizedBox(
      height: 250,
      child: BarChart(
        BarChartData(
          borderData: FlBorderData(show: false),

          gridData: FlGridData(show: true),

          titlesData: FlTitlesData(
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),

            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),

            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  const days = [
                    'Mon',
                    'Tue',
                    'Wed',
                    'Thu',
                    'Fri',
                    'Sat',
                    'Sun',
                  ];

                  return Text(days[value.toInt()]);
                },
              ),
            ),
          ),

          barGroups: List.generate(
            weeklyData.length,
            (index) => makeGroup(index, weeklyData[index]),
          ),
        ),
      ),
    );
  }

  BarChartGroupData makeGroup(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          width: AppSpacing.lg,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.md),
          ),
        ),
      ],
    );
  }
}
