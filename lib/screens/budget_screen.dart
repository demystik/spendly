import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
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
            Text(
              "Monthly Spending Goal",
              style: AppTextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: AppSpacing.md,),
            AppCard(
            boxshadow: [BoxShadow(
              color: appColorScheme.surfaceContainerHighest,
            )],
            border: Border.all(),
              child: Row(
                children: [
                  Icon(LucideIcons.dollarSign500, color: appColorScheme.primary,),
                  Text("4500", style: AppTextStyles.displayMedium,),
                  Spacer(),
                  AppChip(label: "Current Goal", labelTextStyle: AppTextStyles.bodySmall.copyWith(color: appColorScheme.tertiary),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
