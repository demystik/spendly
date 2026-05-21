import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:spendly/themes/app_spacing.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text("Analytics"),,
      actions: [
        Icon(LucideIcons.share2),
        SizedBox(width: AppSpacing.md,),
        Icon(LucideIcons.download),
        SizedBox(width: AppSpacing.md,),
      ],
    ),);
  }
}