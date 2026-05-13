import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
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
  DateTime currentDate = DateTime.now();
  final TextEditingController _amountController = TextEditingController();

  Future<void> _showDatePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2027),
    );

    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        currentDate = pickedDate;
      });
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // foregroundColor: Theme.of(context).colorScheme.onPrimary,
        elevation: 4,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(LucideIcons.chevronLeft),
        ),
        title: Text("Add Expense", style: AppTextStyles.titleLarge),
      ),
      body: SafeArea(
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          children: [
            Text(
              "Amount",
              style: AppTextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            // Add Expense TextFeild___________________________________________
            ExpenseTextField(context: context, amountController:  _amountController),

            SizedBox(height: AppSpacing.xl),

            SectionLabel(
              actualLabel: "What was this for?",
              leadingIcon: const Icon(LucideIcons.tag, size: 18),
            ),

            SizedBox(height: AppSpacing.md),
            AppTextField(label: "e.g Lunch at Joe's"),

            SizedBox(height: AppSpacing.xl),

            //Category Wrap______________________________________________
            SectionLabel(
              actualLabel: "Category",
              leadingIcon: const Icon(LucideIcons.fileText, size: 18),
            ),
            SizedBox(height: AppSpacing.md),

            categoryWrap(),

            SizedBox(height: AppSpacing.xl),

            //Date and Payment method_________________________________________
            Row(
              children: [
                dateMethod(context),
              ],
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

  Expanded dateMethod(BuildContext context) {
    return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionLabel(
                      actualLabel: "Date",
                      leadingIcon: const Icon(LucideIcons.calendar, size: 18),
                    ),
                    SizedBox(height: AppSpacing.sm),
                    GestureDetector(
                      onTap: _showDatePicker,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                        child: Text(
                              DateFormat("MMMM d, y").format(currentDate),
                              style: AppTextStyles.bodyLarge,
                            ),
                      ),
                    ),
                  ],
                ),
              );
  }

  Wrap categoryWrap() {
    return Wrap(
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
    );
  }
}

class ExpenseTextField extends StatelessWidget {
  const ExpenseTextField({
    super.key,
    required this.context,
    required TextEditingController amountController,
  }) : _amountController = amountController;

  final BuildContext context;
  final TextEditingController _amountController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            LucideIcons.dollarSign600,
            size: 35,
            color: Theme.of(context).colorScheme.primary,
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              textAlign: TextAlign.center,
              style: AppTextStyles.displayLarge.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 42,
              ),
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintText: "0.00",
                hintStyle: AppTextStyles.displayLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 42,
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
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
