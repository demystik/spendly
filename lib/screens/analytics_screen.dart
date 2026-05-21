import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:spendly/themes/app_spacing.dart';
import 'package:spendly/themes/app_text_styles.dart';
import 'package:spendly/widgets/app_card.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme appColorScheme = Theme.of(context).colorScheme;
    return Scaffold(appBar: AppBar(
      title: Text("Analytics"),
      actions: [
        Icon(LucideIcons.share2),
        SizedBox(width: AppSpacing.md,),
        Icon(LucideIcons.download),
        SizedBox(width: AppSpacing.md,),
      ],
    ),
    body: SafeArea(child: ListView(
      padding: EdgeInsets.all(AppSpacing.md),
      children: [
      Row(
        children: [
          Container(
            width: ,
            padding: EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: appColorScheme.surfaceContainerHighest),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Text("SPENT"),
            Text("\$1,824", style: AppTextStyles.titleLarge.copyWith(height: 1.5),),
            Text("12% this month"),
          ],),),
          AppCard(
            boxshadow: [BoxShadow()],
            border: Border.all(color: appColorScheme.surfaceContainerHighest),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Text("AVG/DAY"),
            Text("\$61.40", style: AppTextStyles.titleLarge.copyWith(height: 1.5),),
            Text("5% calculated"),
          ],),),
          AppCard(
            boxshadow: [BoxShadow()],
            border: Border.all(color: appColorScheme.surfaceContainerHighest),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Text("BUDGET"),
            Text("74%", style: AppTextStyles.titleLarge.copyWith(height: 1.5),),
            Text("Used up"),
          ],),),
        ],
      ),
    ],),),
    );
  }
}