import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:spendly/models/expense_model.dart';
import 'package:spendly/services/finance_calculator.dart';
import 'package:spendly/themes/app_spacing.dart';
import 'package:spendly/themes/app_text_styles.dart';
import 'package:spendly/widgets/app_chip.dart';

class RecentTransactionListTiles extends StatelessWidget {
  const RecentTransactionListTiles({
    super.key,
    required this.recentTrans,
    required this.isSearchScreen,
  });

  final Expense recentTrans;
  final bool isSearchScreen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: isSearchScreen
          ? SizedBox(
              child: MyListTile(
                isSearchScreen: isSearchScreen,
                recentTrans: recentTrans,
              ),
            )
          : Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(12),
                side: BorderSide(width: 1, color: Colors.grey.shade300),
              ),

              child: MyListTile(
                isSearchScreen: isSearchScreen,
                recentTrans: recentTrans,
              ),
            ),
    );
  }
}

class MyListTile extends StatelessWidget {
  const MyListTile({
    super.key,
    required this.isSearchScreen,
    required this.recentTrans,
  });

  final bool isSearchScreen;
  final Expense recentTrans;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push("/expense_details_screen", extra: recentTrans),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(AppSpacing.sm),
          width: 50,
          height: 50,
          decoration: isSearchScreen
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  color: recentTrans.category.color,
                )
              : BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade200,
                ),
          child: Icon(
            recentTrans.category.icon,
            color: isSearchScreen ? Colors.white : Colors.blue.shade400,
          ),
        ),
        title: Text(recentTrans.title, style: AppTextStyles.titleMedium),
        subtitle: Text(
          "${recentTrans.category.name} . ${DateFormat("MMMM d, y").format(recentTrans.date)}",
          style: AppTextStyles.bodySmall,
        ),
        trailing: Column(
          spacing: 5,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "-${formatCurrency(recentTrans.amount, decimalDigits: 0)}",
              style: AppTextStyles.titleMedium,
            ),
            isSearchScreen
                ? SizedBox()
                : AppChip(
                    label: "completed",
                    labelTextStyle: TextStyle(fontSize: 10),
                    variant: AppChipVariant.outlined,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  ),
          ],
        ),
      ),
    );
  }
}
