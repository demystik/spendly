import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:spendly/models/expense_model.dart';
import 'package:spendly/themes/app_spacing.dart';
import 'package:spendly/themes/app_text_styles.dart';
import 'package:spendly/widgets/app_chip.dart';

class ExpenseDetailsScreen extends StatelessWidget {
  const ExpenseDetailsScreen({super.key, required this.expense});
  final Expense expense;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("Expense details")),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: AppSpacing.lg),
            SizedBox(
              width: screenSize.width * 0.4,
              height: screenSize.width * 0.4,
              child: SvgPicture.asset("assets/animations/online-banking.svg"),
            ),
            Opacity(
              opacity: 0.7,
              child: Text("AMOUNT SPENT", style: AppTextStyles.titleMedium),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  LucideIcons.dollarSign400,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Text(
                  expense.amount.toStringAsFixed(2),
                  style: AppTextStyles.displayLarge,
                ),
              ],
            ),
            SizedBox(height: AppSpacing.md),

            AppChip(label: expense.category.name),

            SizedBox(height: AppSpacing.md),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Divider(),
            ),
            SizedBox(height: AppSpacing.md),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BatchCard(icon: LucideIcons.card, type: "Payment", value: expense.category.),
                    BatchCard(icon: LucideIcons.clock, type: "Time", value: "02:51 PM"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BatchCard(icon: LucideIcons.calendar, type: "Date", value:  DateFormat("MMMM d, y").format(expense.date)),
                    BatchCard(icon: LucideIcons.clock, type: "Time", value: "02:51 PM"),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BatchCard extends StatelessWidget {
  const BatchCard({
    super.key,
    required this.icon,
    required this.type,
    required this.value,
  });
  final IconData icon;
  final String type;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 18,),
            SizedBox(width: AppSpacing.sm),
            Text(type, style: AppTextStyles.bodyMedium),
          ],
        ),
        Text(value, style: AppTextStyles.titleMedium),
      ],
    );
  }
}
