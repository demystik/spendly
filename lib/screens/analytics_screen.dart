import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:spendly/models/category_model.dart';
import 'package:spendly/providers/budget_provider.dart';
import 'package:spendly/providers/expense_provider.dart';
import 'package:spendly/providers/user_region_provider.dart';
import 'package:spendly/services/finance_calculator.dart';
import 'package:spendly/themes/app_spacing.dart';
import 'package:spendly/themes/app_text_styles.dart';
import 'package:spendly/widgets/weekly_spending_bar_chat.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme appColorScheme = Theme.of(context).colorScheme;
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Analytics"),
        actions: [
          Icon(LucideIcons.share2),
          SizedBox(width: AppSpacing.md),
          Icon(LucideIcons.download),
          SizedBox(width: AppSpacing.md),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(AppSpacing.md),
          children: [

          //Upper label___________________________________________
          UpperLabel(appColorScheme: appColorScheme),
          SizedBox(height: AppSpacing.md),



            AnalyticUpperCards(screenSize: screenSize, appColorScheme: appColorScheme),

            SizedBox(height: AppSpacing.lg),
            // Chart_______________________________________________
            // Chart_______________________________________________
            Text("Spending by Category", style: AppTextStyles.titleMedium,),
            Text("Distribution of your top expenses"),
            SizedBox(height: AppSpacing.lg),
            PieChartWidget(),


            //Category Wrap __________________________________________
            SizedBox(height: AppSpacing.md),
            CategoryWrap(),
            SizedBox(height: AppSpacing.md),


            Padding(padding: EdgeInsets.all(AppSpacing.lg), child: Divider(height: 1,),),

            //Weekly Spending Chat Wrap __________________________________________
            Text("Weekly Spending", style: AppTextStyles.titleMedium,),
            Text("Activity over the last 7 days"),
            SizedBox(height: AppSpacing.xl),
            WeeklySpendingChart(),
            Padding(padding: EdgeInsets.all(AppSpacing.lg), child: Divider(height: 1,),),
            Text("Smart Insights", style: AppTextStyles.titleMedium,),
          ],
        ),
      ),
    );
  }
}

class PieChartWidget extends StatelessWidget {
  const PieChartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final expenseList = context.watch<ExpenseProvider>().expenseBox;
    final totalSpent = calculateAmountSpent(expenseList);
    return expenseList.isEmpty ? SizedBox() : SizedBox(
      height: 250,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PieChart(
          PieChartData(
            centerSpaceRadius: double.infinity,
            sectionsSpace: 4,
            sections: List.generate((categoryList.length), (index) {
              Category cat = categoryList[index];
              double amountSpentOnCat = categorySpent(expenses: expenseList, categoryId: cat.id);
              final value = amountSpentOnCat <= 0 || totalSpent <= 0 ? 0.0 : (amountSpentOnCat / totalSpent) * 360;
              return  PieChartSectionData(
                color: cat.color,
                radius: 40,
                showTitle: false,
                value: value,
              );
            }),
          ),
        ),
      ),
    );
  }
}

class CategoryWrap extends StatelessWidget{
  const CategoryWrap({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final expenseList = context.watch<ExpenseProvider>().expenseBox;
    final appCurrency = context.watch<UserRegionProvider>().selectedRegion;
    Size screenSize = MediaQuery.of(context).size;
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List.generate(
      categoryList.length, (index){
        Category cat = categoryList[index];
        double amountSpentOnCat = categorySpent(expenses: expenseList, categoryId: cat.id);
      return SizedBox(
        width: screenSize.width * 0.43,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(cat.name, style: AppTextStyles.bodySmall.copyWith(color: cat.color, fontWeight: FontWeight.w600),),
            Text(formatCurrency(amountSpentOnCat, appCurrency.currency, decimalDigits: 0),style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w400),),
          ],
        ),
      );
    } ),);
  }
}

class AnalyticUpperCards extends StatelessWidget {
  const AnalyticUpperCards({
    super.key,
    required this.screenSize,
    required this.appColorScheme,
  });

  final Size screenSize;
  final ColorScheme appColorScheme;

  @override
  Widget build(BuildContext context) {
        final budget = context.select(
      (BudgetProvider budget) => budget.budgetAmount,
    );
    final expenseList = context.select(
      (ExpenseProvider expense) => expense.expenseBox,
    );
    final totalSpent = calculateAmountSpent(expenseList);
    final percentSpent = calculatePercentAmountSpent(budget, totalSpent);
    final dailySpent = averageDailySpent(totalSpent);
    final curr = context.watch<UserRegionProvider>().selectedRegion;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AnalyticSubHeadingCard(
          screenSize: screenSize,
          appColorScheme: appColorScheme,
          headString: "SPENT",
          title: formatCurrency(totalSpent, curr.currency, decimalDigits: 0).length > 7 ?
          formatCurrency(totalSpent, curr.currency, decimalDigits: 0).replaceRange(3, null, "K")
          :formatCurrency(totalSpent, curr.currency, decimalDigits: 0),
          subheading: "Amount spent so far",
        ),
        AnalyticSubHeadingCard(
          screenSize: screenSize,
          appColorScheme: appColorScheme,
          headString: "AVG/DAY",
          title: formatCurrency(dailySpent, curr.currency, decimalDigits: 0),
          subheading: "Daily spent on average",
        ),
        AnalyticSubHeadingCard(
          screenSize: screenSize,
          appColorScheme: appColorScheme,
          headString: "BUDGET",
          title: "${percentSpent.toInt()}%",
          subheading: "Used up",
        ),
      ],
    );
  }
}

class UpperLabel extends StatelessWidget {
  const UpperLabel({
    super.key,
    required this.appColorScheme,
  });

  final ColorScheme appColorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: AppRadius.sm * 0.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.md),
        color: appColorScheme.surfaceContainerHighest.withValues(alpha: 0.7),
      ),
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm * 0.7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.md),
            color: appColorScheme.onSecondary,
          ),
          child: Text("Monthly Analytics", style: AppTextStyles.bodyLarge,),
        ),
      ),
    );
  }
}
class AnalyticSubHeadingCard extends StatelessWidget {
  const AnalyticSubHeadingCard({
    super.key,
    required this.screenSize,
    required this.appColorScheme,
    required this.headString,
    required this.title,
    required this.subheading,
  });

  final Size screenSize;
  final ColorScheme appColorScheme;
  final String headString;
  final String title;
  final String subheading;

  @override
  Widget build(BuildContext context) {

    return Container(
      width: screenSize.width * 0.28,
      padding: EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: appColorScheme.surfaceContainerHighest),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(headString),
          Text(title, style: AppTextStyles.titleLarge.copyWith(height: 1.5)),
          Text(
            subheading,
            style: AppTextStyles.bodySmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
