import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:spendly/models/expense_model.dart';
import 'package:spendly/themes/app_spacing.dart';

class WeeklySpendingChart extends StatelessWidget {
  const WeeklySpendingChart({super.key});

  @override
  Widget build(BuildContext context) {
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

          barGroups: [
            makeGroup(0, 45),
            makeGroup(1, 52),
            makeGroup(2, 38),
            makeGroup(3, 65),
            makeGroup(4, 48),
            makeGroup(5, 84),
            makeGroup(6, 32),
          ],
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
          borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.md)),
        ),
      ],
    );
  }
}


