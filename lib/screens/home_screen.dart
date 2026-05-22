import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:spendly/constants/app_icons.dart';
import 'package:spendly/models/expense_model.dart';
import 'package:spendly/providers/budget_provider.dart';
import 'package:spendly/providers/expense_provider.dart';
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
                    Text("Hello, Henry!", style: AppTextStyles.displayMedium),
                    Text(
                      "Here is your financial summary for March",
                      style: AppTextStyles.bodyMedium,
                    ),
                    SizedBox(height: AppSpacing.md),

                    //Balance Card______________________________________
                    BalanceCard(),

                    SizedBox(height: AppSpacing.md),

                    //_____Quick Insights_____________________________________________________
                    middleRowHeader(
                      context,
                      "Quick Insights",
                      "view all",
                      () {},
                    ),
                    SizedBox(height: AppSpacing.md),

                    //_____Quick Insight Cards_____________________________________________________
                    Row(
                      children: [
                        QuickInsightCard(
                          goal: "SAVINGS",
                          amount: "\$850",
                          caption: "85% of monthly goal",
                          iconPath: AppIcons.ic_arrow_up,
                        ),
                        SizedBox(width: AppSpacing.md),
                        QuickInsightCard(
                          goal: "EXPENSES",
                          amount: "\$43.30",
                          caption: "+12% from last month",
                          iconPath: AppIcons.ic_arrow_down,
                        ),
                      ],
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
  final String iconPath;
  const QuickInsightCard({
    super.key,
    required this.goal,
    required this.amount,
    required this.caption,
    required this.iconPath,
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
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.brown.shade100,
              ),
              child: SvgPicture.asset(iconPath),
            ),
            Text(goal, style: AppTextStyles.bodyMedium),
            Text(amount, style: AppTextStyles.titleLarge),
            Text(caption, style: AppTextStyles.labelMedium),
          ],
        ),
      ),
    );
  }
}

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final budget = context.watch<BudgetProvider>().budgetAmount;
    final expenseList = context.watch<ExpenseProvider>().expense;
    final totalSpent = calculateAmountSpent(expenseList);
    final saved = (budget - totalSpent).clamp(0, double.infinity);
    final dailyAverage = averageDailySpent(totalSpent);
    final daysLeft = calculateDaysLeft();
    return AppCard(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      boxshadow: [BoxShadow()],
      child: Column(
        spacing: AppSpacing.sm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "MONTHLY BUDGET",
            style: AppTextStyles.titleMedium.copyWith(letterSpacing: 1.4),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(formatCurrency(budget), style: AppTextStyles.displayLarge),
          LinearProgressIndicator(
            value: totalSpent / budget,
            minHeight: 7,
            borderRadius: BorderRadius.circular(AppRadius.md),
            backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${formatCurrency(totalSpent)} Spent",
                style: AppTextStyles.bodyMedium,
              ),

              Text(
                "${formatCurrency(saved.toDouble())} Saved",
                style: AppTextStyles.bodyMedium,
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            child: Row(
              spacing: AppSpacing.xxl,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("DAILY AVERAGE", style: AppTextStyles.labelMedium),
                    Text(formatCurrency(dailyAverage), style: AppTextStyles.titleLarge),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("DAYS LEFT", style: AppTextStyles.labelMedium),
                    Text("$daysLeft DAYS", style: AppTextStyles.titleLarge),
                  ],
                ),
              ],
            ),
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
                  context.push("/first_splash_screen");
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
