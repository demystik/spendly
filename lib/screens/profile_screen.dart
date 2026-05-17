import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:spendly/shared/section_label.dart';
import 'package:spendly/themes/app_spacing.dart';
import 'package:spendly/themes/app_text_styles.dart';
import 'package:spendly/widgets/app_card.dart';
import 'package:spendly/widgets/app_chip.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Icon(LucideIcons.bell),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(15),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/profile_male.png"),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 30,
                        height: 30,
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(color: Colors.white, spreadRadius: 1.0),
                          ],
                          color: Colors.blue.shade200,
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset("assets/logos/spendly_logo1.png"),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: AppSpacing.md),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Henry Revira", style: AppTextStyles.titleLarge),
                    SizedBox(width: AppSpacing.sm),
                    Icon(
                      LucideIcons.shieldCheck,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
                Text("henry.revira@gmail.com", style: AppTextStyles.bodyMedium),
                SizedBox(height: AppSpacing.md),
                AppChip(label: "PRO MEMBER"),
                SizedBox(height: AppSpacing.xl),
              ],
            ),

            //App preferences_____________________________________________
            SectionLabel(actualLabel: "APP PREFERENCES"),
            AppCard(
              child: Column(
                children: [
                  ListTile(
                    leading: Container(
                      padding: EdgeInsets.all(5),
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                      child: Icon(LucideIcons.sunDim, color: Theme.of(context).colorScheme.primary, size: 28,),
                    ),

                    title: Text("Dark Appearance"),
                    subtitle: Text("Customize your interface"),

                    trailing: ToggleButtons(children: [], isSelected: [false]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
