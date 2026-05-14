import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:spendly/shared/circle_with_icon.dart';
import 'package:spendly/themes/app_spacing.dart';
import 'package:spendly/themes/app_text_styles.dart';
import 'package:spendly/widgets/app_button.dart';
import 'package:spendly/widgets/app_card.dart';

class NoExpense extends StatelessWidget {
  const NoExpense({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      border: Border.all(color: Theme.of(context).colorScheme.surfaceContainerHighest),
      child: Column(
        spacing: AppSpacing.sm,
        children: [
          CircleWithIcon(icon: LucideIcons.plus300),
          Text("No Expense Found", style: AppTextStyles.titleLarge,),
          Text(
            "You haven't added any transaction yet. Start tracking your budget today",
            textAlign: TextAlign.center,
            maxLines: 3,
            
          ),
          SizedBox(height: AppSpacing.sm,),
          AppButton(
            label: "Add First Expense",
            variant: AppButtonVariant.outlined,
            onPressed: () {
              context.push("/add_expense_screen");
            },
          ),
        ],
      ),
    );
  }
}
