import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:spendly/models/expense_model.dart';
import 'package:spendly/shared/middle_section_header.dart';
import 'package:spendly/shared/section_label.dart';
import 'package:spendly/themes/app_spacing.dart';
import 'package:spendly/themes/app_text_styles.dart';
import 'package:spendly/widgets/app_card.dart';
import 'package:spendly/widgets/app_chip.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appColorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text("Budget Plan"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.md),
            child: Icon(LucideIcons.circlePlus),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(AppSpacing.md),
          children: [
            //Monthly Spending goal____________________________________________
            Text(
              "Monthly Spending Goal",
              style: AppTextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: AppSpacing.md),
            AppCard(
              boxshadow: [
                BoxShadow(color: appColorScheme.surfaceContainerHighest),
              ],
              border: Border.all(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [

                  Icon(
                    LucideIcons.dollarSign500,
                    color: appColorScheme.primary,
                  ),
                  Text("4500", style: AppTextStyles.displayMedium),
                  ],),
                  AppChip(
                    label: "Current Goal",
                    labelTextStyle: AppTextStyles.bodySmall.copyWith(
                      color: appColorScheme.tertiary,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.md),
            //Remaining Balance___________________________________________
            RemainingBalance(appColorScheme: appColorScheme),

            SizedBox(height: AppSpacing.md),
            MiddleSectionHeader(
              leftText: "Spending Health",
              rightText: "72.9% of total",
              onTap: () {},
            ),
            SizedBox(height: AppSpacing.md),
            LinearProgressIndicator(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              minHeight: 12,
              value: 0.85,
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
                  "CAUTION (85%)",
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

            SizedBox(height: AppSpacing.lg),
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
            value: 0.5, color: cat.color),
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
                      Row(children: [
                      Icon(LucideIcons.trendingDown, size: 17),
                      SizedBox(width: AppSpacing.sm),
                      Text("Remaining Balance", maxLines: 2, overflow: TextOverflow.ellipsis,),
                      ],),

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
                  Row(
                    children: [
                      Icon(LucideIcons.dollarSign500),
                      Text("4500", style: AppTextStyles.displayLarge),
                    ],
                  ),
                  Text(
                    "Your can spend ~\$200 per day for the rest of the month",
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
