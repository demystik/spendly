import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:spendly/models/expense_model.dart';
import 'package:spendly/providers/budget_provider.dart';
import 'package:spendly/providers/datetime_provider.dart';
import 'package:spendly/providers/expense_provider.dart';
import 'package:spendly/providers/income_provider.dart';
import 'package:spendly/providers/user_region_provider.dart';
import 'package:spendly/services/date_calculator.dart';
import 'package:spendly/services/finance_calculator.dart';
import 'package:spendly/shared/no_expense.dart';
import 'package:spendly/shared/transaction_list_tiles.dart';
import 'package:spendly/themes/app_spacing.dart';
import 'package:spendly/themes/app_text_styles.dart';
import 'package:spendly/widgets/app_button.dart';
import 'package:spendly/widgets/app_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: const CircleBorder(),
        onPressed: () {
          context.push("/add_expense_screen");
        },
        child: const Icon(LucideIcons.plus400, color: Colors.white70, size: 30),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Header Part_____________________________________________
            HeaderPart(),
            Divider(height: 1),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppSpacing.sm),
                    Text("Hello Yinka!", style: AppTextStyles.displayMedium),
                    Consumer<DatetimeProvider>(
                      builder: (context, value, child) => Text(
                        "Here is your financial summary for ${value.currentMonth}",
                        style: AppTextStyles.bodyMedium,
                      ),
                    ),
                    SizedBox(height: AppSpacing.md),

                    //Balance Card______________________________________
                    BalanceCard(),

                    SizedBox(height: AppSpacing.md),

                    //_____Quick Insights_____________________________________________________
                    Text("Quick Insights", style: AppTextStyles.titleMedium),
                    SizedBox(height: AppSpacing.md),

                    //_____Quick Insight Cards_____________________________________________________
                    QuickIncomeCard(
                      goal: "INCOME",
                      amount: formatCurrency(
                        context.watch<IncomeProvider>().monthlyIncome,
                        context
                            .watch<UserRegionProvider>()
                            .selectedRegion
                            .currency,
                      ),
                      caption: "Your monthly income",
                      icon: LucideIcons.arrowDown,
                    ),
                    SizedBox(height: AppSpacing.md),
                    Consumer<IncomeProvider>(
                      builder: (context, provider, child) {
                        final expenseList = context.select(
                          (ExpenseProvider expense) => expense.expense,
                        );
                        final totalSpent = calculateAmountSpent(expenseList);
                        var (savings, percent) = calculateSavings(
                          provider.monthlyIncome,
                          totalSpent,
                        );
                        var (expenseDiff, expensePercent) = expenseInsight(
                          expenseList,
                        );

                        final curr = context
                            .watch<UserRegionProvider>()
                            .selectedRegion;
                        return Row(
                          children: [
                            QuickInsightCard(
                              goal: "EXPENSES",
                              amount: formatCurrency(
                                expenseDiff,
                                curr.currency,
                                decimalDigits: 0,
                              ),
                              caption: "$expensePercent from last month",
                              icon: LucideIcons.trendingDown,
                            ),
                            SizedBox(width: AppSpacing.md),
                            QuickInsightCard(
                              goal: "SAVINGS",
                              amount: formatCurrency(
                                savings,
                                curr.currency,
                                decimalDigits: 0,
                              ),
                              caption: "$percent% of monthly goal",
                              icon: LucideIcons.trendingUp,
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: AppSpacing.xl),

                    //___Recent Transactions_________________________________________________________
                    middleRowHeader(
                      context,
                      "Recent Transactions",
                      "Search",
                      () => context.push("/search_and_filter_screen"),
                    ),
                    SizedBox(height: AppSpacing.md),

                    //___Recent Transactions List_______________________________________________________
                    context.watch<ExpenseProvider>().expense.isEmpty
                        ? NoExpense()
                        : ListView.builder(
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: context
                                .watch<ExpenseProvider>()
                                .expense
                                .length,
                            itemBuilder: (context, index) {
                              Expense recentTrans = context
                                  .watch<ExpenseProvider>()
                                  .expense[index];
                              return RecentTransactionListTiles(
                                recentTrans: recentTrans,
                                isSearchScreen: false,
                              );
                            },
                          ),

                    SizedBox(height: AppSpacing.md),
                    AppButton(
                      variant: AppButtonVariant.outlined,
                      label: "See Detailed Analytics",
                      onPressed: () {},
                    ),
                    SizedBox(height: AppSpacing.xxxl),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row middleRowHeader(
    BuildContext context,
    String leftText,
    String rightText,
    VoidCallback onTap,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(leftText, style: AppTextStyles.titleMedium),
        GestureDetector(
          onTap: onTap,
          child: Text(
            rightText,
            style: AppTextStyles.bodyMedium.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}

class QuickInsightCard extends StatelessWidget {
  final String goal;
  final String amount;
  final String caption;
  final IconData icon;
  const QuickInsightCard({
    super.key,
    required this.goal,
    required this.amount,
    required this.caption,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AppCard(
        child: Column(
          spacing: AppSpacing.sm,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
              ),
              child: Icon(icon),
            ),
            Text(goal, style: AppTextStyles.bodyMedium),
            Text(amount, style: AppTextStyles.displayMedium),
            Text(caption, style: AppTextStyles.labelMedium),
          ],
        ),
      ),
    );
  }
}

class QuickIncomeCard extends StatelessWidget {
  final String goal;
  final String amount;
  final String caption;
  final IconData icon;
  const QuickIncomeCard({
    super.key,
    required this.goal,
    required this.amount,
    required this.caption,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: // SizedBox(width: double.infinity,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(goal, style: AppTextStyles.bodyMedium),
              Container(
                padding: EdgeInsets.all(AppSpacing.sm),
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                ),
                child: Icon(icon),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(caption, style: AppTextStyles.labelMedium),
              SizedBox(height: AppSpacing.sm),
              Text(amount, style: AppTextStyles.displayMedium),
            ],
          ),
        ],
      ),
    );
  }
}

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final budget = context.select(
      (BudgetProvider budget) => budget.budgetAmount,
    );
    final expenseList = context.select(
      (ExpenseProvider expense) => expense.expense,
    );
    final totalSpent = calculateAmountSpent(expenseList);
    final amountLeft = (budget - totalSpent);
    final dailyAverage = averageDailySpent(totalSpent);
    final daysLeft = calculateDaysLeft();
    final progress = budget <= 0
        ? 0.0
        : (totalSpent / budget).clamp(0, double.infinity);

    final currency = context
        .watch<UserRegionProvider>()
        .selectedRegion
        .currency;
    return AppCard(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      boxshadow: [BoxShadow()],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "MONTHLY BUDGET",
            style: AppTextStyles.titleMedium.copyWith(letterSpacing: 1.4),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            formatCurrency(budget, currency),
            style: AppTextStyles.displayLarge,
          ),
          SizedBox(height: AppSpacing.sm),
          LinearProgressIndicator(
            value: progress.toDouble(),
            minHeight: 7,
            borderRadius: BorderRadius.circular(AppRadius.md),
            backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
          ),
          SizedBox(height: AppSpacing.sm),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${formatCurrency(totalSpent, currency)} Spent",
                style: AppTextStyles.bodyMedium,
              ),

              Text(
                amountLeft >= 0
                    ? "${formatCurrency(amountLeft, currency)} Left"
                    : "${formatCurrency(amountLeft.abs(), currency)} Overspent",
                style: AppTextStyles.bodyMedium,
              ),
            ],
          ),

          SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("DAILY AVERAGE", style: AppTextStyles.labelMedium),
                    Text(
                      formatCurrency(dailyAverage, currency),
                      style: AppTextStyles.titleLarge,
                    ),
                  ],
                ),
              ),
              // SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("DAYS LEFT", style: AppTextStyles.labelMedium),
                    Text(
                      "$daysLeft ${daysLeft == 1 ? 'Day' : 'Days'}",
                      style: AppTextStyles.titleLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HeaderPart extends StatelessWidget {
  const HeaderPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            "assets/logos/spendly_logo2.png",
            width: 40,
            height: 40,
            fit: BoxFit.contain,
          ),

          Row(
            children: [
              IconButton(
                onPressed: () {
                  context.push("/income_onboarding_screen");
                },
                icon: Icon(LucideIcons.bell400, size: 28),
              ),
              SizedBox(width: 10),
              CircleAvatar(
                radius: 15,
                foregroundImage: AssetImage("assets/images/profile_male.png"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
