import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:spendly/shared/circle_with_icon.dart';
import 'package:spendly/themes/app_spacing.dart';
import 'package:spendly/themes/app_text_styles.dart';
import 'package:spendly/widgets/app_card.dart';

class NoSearchFound extends StatelessWidget {
  const NoSearchFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AppCard(
        border: Border.all(color: Theme.of(context).colorScheme.surfaceContainerHighest),
        child: Column(
          spacing: AppSpacing.sm,
          children: [
            CircleWithIcon(icon: LucideIcons.search),
            Text("Not Found", style: AppTextStyles.titleLarge,),
            Text(
              "Try another search.",
              textAlign: TextAlign.center,
              maxLines: 3,
              
            ),
            SizedBox(height: AppSpacing.sm,),
          ],
        ),
      ),
    );
  }
}