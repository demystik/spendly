import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:spendly/themes/app_spacing.dart';
import 'package:spendly/themes/app_text_styles.dart';


class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme appColorScheme = Theme.of(context).colorScheme;
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Analytics"),
        actions: [
          Icon(LucideIcons.share2),
          SizedBox(width: AppSpacing.md),
          Icon(LucideIcons.download),
          SizedBox(width: AppSpacing.md),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(AppSpacing.md),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnalyticSubHeadingCard(screenSize: screenSize, appColorScheme: appColorScheme, headString: "SPENT", title:  "\$1,824", subheading: "12% this month"),
                AnalyticSubHeadingCard(screenSize: screenSize, appColorScheme: appColorScheme, headString: "AVG/DAY", title:  "\$61.40", subheading: "5% calculated"),
                AnalyticSubHeadingCard(screenSize: screenSize, appColorScheme: appColorScheme, headString: "BUDGET", title:  "74%", subheading: "Used up"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AnalyticSubHeadingCard extends StatelessWidget {
  const AnalyticSubHeadingCard({
    super.key,
    required this.screenSize,
    required this.appColorScheme, 
    required this.headString, 
    required this.title, 
    required this.subheading,
  });

  final Size screenSize;
  final ColorScheme appColorScheme;
  final String headString;
  final String title;
  final String subheading;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenSize.width * 0.28,
      padding: EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: appColorScheme.surfaceContainerHighest,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(headString),
          Text(
           title,
            style: AppTextStyles.titleLarge.copyWith(height: 1.5),
          ),
          Text(subheading,style: AppTextStyles.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis,),
        ],
      ),
    );
  }
}
