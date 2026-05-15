import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:spendly/constants/time_period.dart';
// import 'package:provider/provider.dart';
import 'package:spendly/models/expense_model.dart';
// import 'package:spendly/providers/category_provider.dart';
import 'package:spendly/shared/section_label.dart';
import 'package:spendly/themes/app_spacing.dart';
import 'package:spendly/themes/app_text_styles.dart';
import 'package:spendly/widgets/app_card.dart';
import 'package:spendly/widgets/app_chip.dart';
import 'package:spendly/widgets/app_text_field.dart';

class SearchAndFilterScreen extends StatelessWidget {
  const SearchAndFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Text("reset"),
          ),
        ],
        title: Text("Search & Filter"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 10,
              ),
              child: AppTextField(
                prefixIcon: Icon(LucideIcons.search),
                label: "Search transactions...",
              ),
            ),
            SizedBox(height: AppSpacing.md),

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
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: AppChip(
                      leadingIcon: Icon(cat.icon),
                      label: cat.name,
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: AppSpacing.md),

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
                  labelTextStyle: AppTextStyles.bodyLarge,
                );
              }),
            ),
         ),
            SizedBox(height: AppSpacing.xl),

  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0),
    child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Amount Range", style: AppTextStyles.titleMedium),
          AppChip(label: "up to 5000", labelTextStyle: AppTextStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onSecondary),),
        ],
    ),
  ),


  AppCard(child: Column(
    children: [
      RangeSlider(values: RangeValues(40, 50), onChanged: (value){})
    ],

  ),),

          ],
        ),
      ),
    );
  }
}




