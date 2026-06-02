import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:spendly/models/expense_model.dart';
import 'package:spendly/providers/expense_provider.dart';
import 'package:spendly/providers/user_region_provider.dart';
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
        child: ListView(
          padding: EdgeInsets.all(15.0),
          children: [
            SizedBox(height: AppSpacing.sm),
            SizedBox(
              width: screenSize.width * 0.3,
              height: screenSize.width * 0.3,
              child: SvgPicture.asset("assets/animations/undraw_budgeting_klon.svg"),
            ),
            Column(
              children: [
                SizedBox(height: AppSpacing.md),
                Opacity(
                  opacity: 0.7,
                  child: Text("AMOUNT SPENT", style: AppTextStyles.titleMedium),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer<UserRegionProvider>(
                      builder: (context, value, child) =>  Text(value.selectedRegion.currency, style: AppTextStyles.displayLarge,)),
                    Text(
                      expense.amount.toStringAsFixed(2),
                      style: AppTextStyles.displayLarge.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.md),

                AppChip(label: context.watch<ExpenseProvider>().getCategoryById(expense.categoryId).name),
                SizedBox(height: AppSpacing.md),
                Text(expense.title),
              ],
            ),
            SizedBox(height: AppSpacing.md),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Divider(),
            ),
            SizedBox(height: AppSpacing.md),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BatchCard(
                          icon: LucideIcons.calendar,
                          type: "Date",
                          value: DateFormat("MMMM d, y").format(expense.date),
                        ),
                    SizedBox(height: AppSpacing.md),
                        BatchCard(
                          icon: LucideIcons.clock,
                          type: "Time",
                          value: DateFormat("h:mm a").format(expense.date),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: AppSpacing.xxl),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BatchCard(
                          icon: LucideIcons.creditCard,
                          type: "Payment",
                          value: expense.paymentType,
                        ),
                    SizedBox(height: AppSpacing.md),
                        BatchCard(
                          icon: LucideIcons.tag,
                          type: "ID",
                          value: "TXN-${expense.id.substring(0, 7)}",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSpacing.md),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Divider(),
            ),
            SizedBox(height: AppSpacing.md),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  BatchCard(icon: LucideIcons.fileText, type: "Note"),
            SizedBox(height: AppSpacing.sm),
                  Text(expense.note, textAlign: TextAlign.justify,),
                ],
              ),
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
    this.value,
  });
  final IconData icon;
  final String type;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Opacity(
          opacity: 0.7,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, size: 18),
              SizedBox(width: AppSpacing.sm),
              Text(type, style: AppTextStyles.bodyMedium),
            ],
          ),
        ),
        ...[if (value != null) Text(value!, style: AppTextStyles.titleMedium)],
      ],
    );
  }
}
