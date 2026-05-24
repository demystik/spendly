import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:spendly/models/category_model.dart';
import 'package:spendly/providers/budget_provider.dart';
import 'package:spendly/providers/expense_provider.dart';
import 'package:spendly/services/date_calculator.dart';
import 'package:spendly/services/finance_calculator.dart';
import 'package:spendly/shared/middle_section_header.dart';
import 'package:spendly/shared/section_label.dart';
import 'package:spendly/themes/app_spacing.dart';
import 'package:spendly/themes/app_text_styles.dart';
import 'package:spendly/widgets/app_button.dart';
import 'package:spendly/widgets/app_card.dart';
import 'package:spendly/widgets/app_chip.dart';
import 'package:spendly/widgets/app_text_field.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  late final TextEditingController amountInputController;
  String? errorText;

  @override
  void initState() {
    super.initState();
    amountInputController = TextEditingController();
  }

  @override
  void dispose() {
    amountInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text("Budget Plan"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.md),
            child: IconButton(
              onPressed: () => showBottomSheetMethod(context, appColorScheme),
              icon: Icon(LucideIcons.circlePlus),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(AppSpacing.md),
          children: [
            //Monthly Spending goal____________________________________________
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Monthly Spending Goal",
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                FilledButton(
                  child: Text(
                    "Set Budget",
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: appColorScheme.onPrimary,
                    ),
                  ),
                  onPressed: () {
                    showBottomSheetMethod(context, appColorScheme);
                  },
                ),
              ],
            ),
            SizedBox(height: AppSpacing.lg),
            // Current Goal Card_______________________________________
            CurrentGoalCard(appColorScheme: appColorScheme),

            SizedBox(height: AppSpacing.lg),
            //Remaining Balance___________________________________________
            RemainingBalance(appColorScheme: appColorScheme),

            SizedBox(height: AppSpacing.lg),

            //Spending Health___________________________________________
            SpendingHealthRange(appColorScheme: appColorScheme),

            SizedBox(height: AppSpacing.lg),
            //Category Budgets___________________________________________
            SectionLabel(
              leadingIcon: Icon(LucideIcons.folderKanban),
              actualLabel: "Category Budgets",
            ),
            SizedBox(height: AppSpacing.md),

            Column(
              spacing: AppSpacing.sm,
              children: List.generate(categoryList.length, (index) {
                final cat = categoryList[index];
                return CategoryBudgetCard(
                  appColorScheme: appColorScheme,
                  cat: cat,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showBottomSheetMethod(
    BuildContext context,
    ColorScheme appColorScheme,
  ) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.lg),
          bottom: Radius.zero,
        ),
      ),
      isScrollControlled: true,

      backgroundColor: appColorScheme.onPrimary,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, modalSetState) => SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            "Set Budget",
                            textAlign: TextAlign.center,
                            style: AppTextStyles.titleLarge.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          amountInputController.clear();
                          context.pop();
                        },
                        icon: Icon(LucideIcons.check),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.sm),
                  Text("Define your budget for this month"),
                  SizedBox(height: AppSpacing.md),
                  Text("Set Amount:"),
                  SizedBox(height: AppSpacing.sm),
                  AppTextField(
                    prefixIcon: Text("₦"),
                    controller: amountInputController,
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    label: "0.00",
                    errorText: errorText,
                    onChanged: (_) {
                      if (errorText != null) {
                        modalSetState(() {
                          errorText = null;
                        });
                      }
                    },
                  ),
                  SizedBox(height: AppSpacing.lg),
                  SizedBox(
                    child: AppButton(
                      label: "Save",
                      onPressed: () {
                        final error = _validator(amountInputController);

                        modalSetState(() {
                          errorText = error;
                        });

                        if (error != null) return;

                        final double amount = double.parse(
                          amountInputController.text.trim(),
                        );
                        context.read<BudgetProvider>().addBudget(amount);
                        amountInputController.clear();

                        modalSetState(() {
                          errorText = null;
                        });

                        context.pop();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class SpendingHealthRange extends StatelessWidget {
  const SpendingHealthRange({super.key, required this.appColorScheme});

  final ColorScheme appColorScheme;

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
      builder: (context, value, child) {
        final budget = context.read<BudgetProvider>().budgetAmount;
        final totalSpent = calculateAmountSpent(value.expense);
        double percent = percentbudgetHealthScore(budget, totalSpent);
        final linearPercent = percent <= 0 ? 0.0 : percent / 100;
        return Column(
          children: [
            MiddleSectionHeader(
              leftText: "Spending Health",
              rightText: "${percent.toStringAsFixed(1)}% of total",
              onTap: () {},
            ),
            SizedBox(height: AppSpacing.md),
            LinearProgressIndicator(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              minHeight: 12,
              value: linearPercent >= 1.0 ? 1.0 : linearPercent,
            ),
            SizedBox(height: AppSpacing.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "SAFE",
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${translatePercentage(percent)} (${percent.toInt()}%)",
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "CRITICAL",
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                    color: appColorScheme.error,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class CurrentGoalCard extends StatelessWidget {
  const CurrentGoalCard({super.key, required this.appColorScheme});

  final ColorScheme appColorScheme;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      boxshadow: [BoxShadow(color: appColorScheme.surfaceContainerHighest)],
      border: Border.all(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Consumer<BudgetProvider>(
            builder: (context, value, child) => Text(
              formatCurrency(value.budgetAmount, decimalDigits: 0),
              style: AppTextStyles.displayMedium,
            ),
          ),
          AppChip(
            label: "Current Goal",
            labelTextStyle: AppTextStyles.bodySmall.copyWith(
              color: appColorScheme.tertiary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

String? _validator(TextEditingController amountController) {
  final String inputAmount = amountController.text.trim();
  if (inputAmount.isEmpty) {
    return "Budget amount cannot be empty";
  }
  final double? amount = double.tryParse(inputAmount);

  if (amount == null) {
    return "Enter a valid number";
  }

  if (amount <= 0) {
    return "Budget must be greater than 0";
  }

  if (amount > 100000000) {
    return "Too much, please enter valid budget";
  }

  return null;
}

class CategoryBudgetCard extends StatelessWidget {
  const CategoryBudgetCard({
    super.key,
    required this.appColorScheme,
    required this.cat,
  });

  final ColorScheme appColorScheme;
  final Category cat;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      border: Border.all(color: appColorScheme.surfaceContainerHighest),
      boxshadow: [BoxShadow()],
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    padding: EdgeInsets.all(AppSpacing.md),
                    child: Icon(cat.icon, color: cat.color),
                  ),
                  Column(children: [Text(cat.name), Text("YY% used")]),
                ],
              ),
              Column(children: [Text("DDD"), Text("of RRR")]),
            ],
          ),
          LinearProgressIndicator(
            borderRadius: BorderRadius.circular(AppRadius.md),
            value: 0.5,
            color: cat.color,
          ),
        ],
      ),
    );
  }
}

class RemainingBalance extends StatelessWidget {
  const RemainingBalance({super.key, required this.appColorScheme});
  final ColorScheme appColorScheme;
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
    final toSpendDaily = amountLeft / calculateDaysLeft();
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSpacing.md),
      child: AppCard(
        padding: EdgeInsets.all(0),
        boxshadow: [BoxShadow()],
        color: appColorScheme.surfaceContainerHighest,
        child: Stack(
          children: [
            Positioned(
              right: -30,
              top: -30,
              child: Opacity(
                opacity: 0.3,
                child: SvgPicture.asset(
                  width: 120,
                  height: 120,
                  "assets/icons/wallet.svg",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(LucideIcons.trendingDown, size: 17),
                            SizedBox(width: AppSpacing.sm),
                            Text(
                              "Remaining Balance",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),

                      AppChip(
                        selected: true,
                        label: "SAFE",
                        labelTextStyle: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.4,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.md),
                  Text(
                    formatCurrency(amountLeft, decimalDigits: 0),
                    style: AppTextStyles.displayLarge,
                  ),
                  Text(
                    "Your can spend ~${formatCurrency(toSpendDaily, decimalDigits: 0)} per day for the rest of the month",
                  ),
                  SizedBox(height: AppSpacing.sm),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
