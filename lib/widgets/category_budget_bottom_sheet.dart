import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:spendly/models/category_model.dart';
import 'package:spendly/providers/budget_provider.dart';
import 'package:spendly/providers/category_budget_provider.dart';
import 'package:spendly/themes/app_spacing.dart';
import 'package:spendly/themes/app_text_styles.dart';
import 'package:spendly/widgets/app_button.dart';
import 'package:spendly/widgets/app_text_field.dart';

Future<void> showCategoryBudgetBottomSheet({
  required BuildContext context,
  required Category category,
}) async {
  final amountController = TextEditingController();

  String? errorText;

  final appColorScheme = Theme.of(context).colorScheme;

  final now = DateTime.now();

  final month = DateFormat("MMMM").format(now);

  final year = DateFormat("y").format(now);

  final categoryBudgetProvider = context.read<CategoryBudgetProvider>();

  final budgetProvider = context.read<BudgetProvider>();

  final totalBudget = budgetProvider.budgetAmount;

  final existingBudget = categoryBudgetProvider.getCategoryBudget(
    category.id,
    month,
    year,
  );

  if (existingBudget > 0) {
    amountController.text = existingBudget.toString();
  }

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: appColorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setModalState) {
          final allocated = categoryBudgetProvider.allocatedBudget(
            month: month,
            year: year,
          );

          final remaining = totalBudget - allocated + existingBudget;

          return Padding(
            padding: EdgeInsets.only(
              left: AppSpacing.md,
              right: AppSpacing.md,
              top: AppSpacing.md,
              bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.lg,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: category.color.withValues(alpha: 0.15),
                      child: Icon(category.icon, color: category.color),
                    ),

                    const SizedBox(width: AppSpacing.md),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category.name,
                            style: AppTextStyles.titleLarge.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(
                            existingBudget > 0
                                ? "Edit category budget"
                                : "Set category budget",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.xl),

                Text("Remaining Budget", style: AppTextStyles.labelMedium),

                const SizedBox(height: AppSpacing.xs),

                Text(
                  NumberFormat.currency(
                    symbol: "₦",
                    decimalDigits: 2,
                  ).format(remaining),
                  style: AppTextStyles.displayLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                Text("Budget Amount", style: AppTextStyles.labelMedium),

                const SizedBox(height: AppSpacing.sm),

                AppTextField(
                  controller: amountController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  label: "0.00",
                  prefixIcon: Icon(Icons.currency_exchange),
                  errorText: errorText,
                  onChanged: (_) {
                    if (errorText != null) {
                      setModalState(() {
                        errorText = null;
                      });
                    }
                  },
                ),

                const SizedBox(height: AppSpacing.lg),

                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    label: existingBudget > 0 ? "Update Budget" : "Save Budget",
                    onPressed: () {
                      final input = amountController.text.trim();

                      if (input.isEmpty) {
                        setModalState(() {
                          errorText = "Budget amount cannot be empty";
                        });
                        return;
                      }

                      final amount = double.tryParse(input);

                      if (amount == null || amount <= 0) {
                        setModalState(() {
                          errorText = "Enter valid amount";
                        });
                        return;
                      }

                      final success = categoryBudgetProvider.setCategoryBudget(
                        category: category,
                        amount: amount,
                        totalBudget: totalBudget,
                        month: month,
                        year: year,
                      );

                      if (!success) {
                        setModalState(() {
                          errorText =
                              "Exceeds remaining budget of ${NumberFormat.currency(symbol: "₦").format(remaining)}";
                        });
                        return;
                      }

                      Navigator.pop(context);
                    },
                  ),
                ),

                const SizedBox(height: AppSpacing.md),
              ],
            ),
          );
        },
      );
    },
  );
}
