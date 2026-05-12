import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:spendly/themes/app_text_styles.dart';

class AddExpenseScreen extends StatelessWidget {
  const AddExpenseScreen({super.key});

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

            expenseTextField(screenSize, context),
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
                Icon(LucideIcons.dollarSign, size: 35, color: Colors.blue),
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
