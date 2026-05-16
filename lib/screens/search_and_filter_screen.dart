import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:spendly/constants/time_period.dart';
// import 'package:provider/provider.dart';
import 'package:spendly/models/expense_model.dart';
import 'package:spendly/providers/amount_range_provider.dart';
import 'package:spendly/providers/category_provider.dart';
import 'package:spendly/providers/expense_provider.dart';
// import 'package:spendly/providers/category_provider.dart';
import 'package:spendly/shared/section_label.dart';
import 'package:spendly/shared/transaction_list_tiles.dart';
import 'package:spendly/themes/app_spacing.dart';
import 'package:spendly/themes/app_text_styles.dart';
import 'package:spendly/widgets/app_chip.dart';
import 'package:spendly/widgets/app_text_field.dart';

class SearchAndFilterScreen extends StatefulWidget {
  const SearchAndFilterScreen({super.key});

  @override
  State<SearchAndFilterScreen> createState() => _SearchAndFilterScreenState();
}

class _SearchAndFilterScreenState extends State<SearchAndFilterScreen> {
  TextEditingController searchTextController = TextEditingController();

  @override
  void dispose() {
    searchTextController.dispose();
    context.read<ExpenseProvider>().resetFilters();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //APPBAR_________________________________________________
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: () {
                context.read<ExpenseProvider>().resetFilters();
              },
              child: Text(
                "reset",
                style: AppTextStyles.bodyLarge.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
        title: Text("Search & Filter"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            //Filter Search Textfield______________________________________________
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 10,
              ),
              child: AppTextField(
                onChanged: (text) {
                  context.read<ExpenseProvider>().setSearchQuery(text);
                },
                controller: searchTextController,
                prefixIcon: Icon(LucideIcons.search),
                label: "Search transactions...",
              ),
            ),
            SizedBox(height: AppSpacing.md),

            // Filter Category_________________________________________
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: SectionLabel(actualLabel: "Category"),
            ),

            SizedBox(
              height: 55,
              child: ListView.builder(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: categoryList.length,
                itemBuilder: (context, index) {
                  Category cat = categoryList[index];
                  final provider = context.watch<CategoryProvider>();
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: AppChip (
                        leadingIcon: Icon(cat.icon),
                        onTap: (){
                          provider.changeCategory(cat);
                          context.read<ExpenseProvider>().setCategory(cat);
                        },
                        selected: provider.selectedCategory == cat,
                        label: cat.name,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: AppSpacing.md),


            //Filter Time Period____________________________________________
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: SectionLabel(actualLabel: "Time Period"),
            ),
            SizedBox(height: AppSpacing.md),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(timePeriodList.length, (index) {
                  String time = timePeriodList[index];
                  return AppChip(
                    // onTap: () {
                    //   categoryProvider.changeCategory(cat);
                    // },
                    // selected: categoryProvider.selectedCategory == cat,
                    variant: AppChipVariant.filled,
                    label: time,
                    labelTextStyle: AppTextStyles.bodyMedium,
                  );
                }),
              ),
            ),
            SizedBox(height: AppSpacing.xl),

            //Filter Amount Range Indicator______________________________________________
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Amount Range", style: AppTextStyles.titleMedium),
                  Consumer<AmountRangeProvider>(
                    builder: (context, value, child) => AppChip(
                      label: "up to ${value.amountValue.toStringAsFixed(0)}",
                      labelTextStyle: AppTextStyles.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSpacing.md),

            AmountRangeSlider(),
            SizedBox(height: AppSpacing.md),

            //Divider______________________________________________
            Divider(),
            SizedBox(height: AppSpacing.xl),

            //RECENT RESULTS______________________________________________
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SectionLabel(
                    leadingIcon: Icon(
                      LucideIcons.funnel,
                      size: 18,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    actualLabel: "RECENT RESULTS",
                  ),
                  AppChip(variant: AppChipVariant.outlined, label: "${context.watch<ExpenseProvider>().filteredExpenses.length.toString()} FOUND"),
                ],
              ),
            ),
            SizedBox(height: AppSpacing.md),

            ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15),
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: context.watch<ExpenseProvider>().filteredExpenses.length,
              itemBuilder: (context, index) {
                Expense recentTrans = context
                    .watch<ExpenseProvider>()
                    .filteredExpenses[index];
                return Column(
                  children: [
                    RecentTransactionListTiles(recentTrans: recentTrans, isSearchScreen: true,),
                    ...[if(index < context.watch<ExpenseProvider>().filteredExpenses.length - 1)
                      Divider(),
                      ]
                  ],
                );


              },
            ),
            SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}

class AmountRangeSlider extends StatelessWidget {
  const AmountRangeSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
        ),
        child: Column(
          children: [
            Slider(
              min: 0,
              max: 2000,
              thumbColor: Theme.of(context).colorScheme.onSecondary,
              value: context.watch<AmountRangeProvider>().amountValue,
              onChanged: (newValue) {
                context.read<AmountRangeProvider>().changeValue(newValue);
                context.read<ExpenseProvider>().setMaxAmount(newValue);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("\$0", style: AppTextStyles.bodySmall),
                  Text("\$2,000+", style: AppTextStyles.bodySmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
