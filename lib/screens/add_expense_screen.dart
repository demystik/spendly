import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:spendly/models/expense_model.dart';
import 'package:spendly/themes/app_spacing.dart';
import 'package:spendly/themes/app_text_styles.dart';
import 'package:spendly/widgets/app_button.dart';
import 'package:spendly/widgets/app_chip.dart';
import 'package:spendly/widgets/app_text_field.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  int selectedCategory = -1;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        // foregroundColor: Theme.of(context).colorScheme.onPrimary,
        elevation: 4,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(LucideIcons.chevronLeft),
        ),
        title: Text("Add Expense", style: AppTextStyles.titleLarge),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          children: [
            Center(
              child: Text(
                "Amount",
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
            // Add Expense TextFeild___________________________________________
            expenseTextField(screenSize, context),

            SizedBox(height: AppSpacing.xl),

            SectionLabel(
              actualLabel: "What was this for?",
              leadingIcon: Icon(LucideIcons.tag, size: 18),
            ),

            SizedBox(height: AppSpacing.md),
            AppTextField(label: "e.g Lunch at Joe's"),

            SizedBox(height: AppSpacing.xl),

            //Category Wrap______________________________________________
            SectionLabel(
              actualLabel: "Category",
              leadingIcon: Icon(LucideIcons.fileText, size: 18),
            ),
            SizedBox(height: AppSpacing.md),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(categoryList.length, (index) {
                Category cat = categoryList[index];
                return AppChip(
                  onTap: () {
                    setState(() => selectedCategory = index);
                  },
                  selected: selectedCategory == index,
                  variant: AppChipVariant.outlined,
                  leadingIcon: Icon(cat.icon),
                  label: cat.name,
                  labelTextStyle: AppTextStyles.bodyLarge,
                );
              }),
            ),

            SizedBox(height: AppSpacing.xl),

            //Note____________________________________________________
            SectionLabel(actualLabel: "Notes (Optional)"),
            SizedBox(height: AppSpacing.md),
            AppTextField(
              label: "Add more details about this expense...",
              hint: "Add more details about this expense...",
              minLines: 5,
              maxLines: 8,
            ),
            SizedBox(height: AppSpacing.xl),
            //Save Expense Button________________________________________________
            AppButton(
              variant: AppButtonVariant.primary,
              label: "Save Expense",
              onPressed: () {},
            ),
            SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }

  Padding expenseTextField(Size screenSize, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(LucideIcons.dollarSign600, size: 35, color: Theme.of(context).colorScheme.primary),
          SizedBox(width: 10),
          SizedBox(
            width: screenSize.width * 0.5,
            child: TextFormField(
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: AppTextStyles.displayLarge.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintText: "0.00",
                hintStyle: AppTextStyles.displayLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black45,
                  fontSize: 40,
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue.shade100,
                    width: 2.0,
                  ),
                ),

                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue.shade100,
                    width: 2.0,
                  ),
                ),

                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),

                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class SectionLabel extends StatelessWidget {
  const SectionLabel({super.key, required this.actualLabel, this.leadingIcon});
  final String actualLabel;
  final Widget? leadingIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (leadingIcon != null) ...[
          leadingIcon!,
          SizedBox(width: AppSpacing.sm),
        ],
        Text(
          actualLabel,
          style: AppTextStyles.bodyLarge.copyWith(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
