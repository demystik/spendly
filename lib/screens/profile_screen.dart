import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:spendly/models/region_model.dart';
import 'package:spendly/providers/income_provider.dart';
import 'package:spendly/providers/theme_mode_provider.dart';
import 'package:spendly/providers/user_region_provider.dart';
import 'package:spendly/services/auth_service.dart';
import 'package:spendly/shared/section_label.dart';
import 'package:spendly/themes/app_spacing.dart';
import 'package:spendly/themes/app_text_styles.dart';
import 'package:spendly/widgets/app_button.dart';
import 'package:spendly/widgets/app_card.dart';
import 'package:spendly/widgets/app_chip.dart';
import 'package:spendly/widgets/app_text_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final TextEditingController amountInputController;
  String? errorText;

  @override
  void initState() {
    amountInputController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    amountInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorsScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: Text("Profile"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: const Icon(LucideIcons.bell),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(15),
          children: [
            //Header Section_____________________________________________
            HeaderSection(),

            //App preferences_____________________________________________
            SectionLabel(
              actualLabel: "PREFERENCES",
              textStyle: AppTextStyles.bodyMedium.copyWith(
                color: colorsScheme.onSurfaceVariant,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.8,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            preferences(context, colorsScheme),
            const SizedBox(height: AppSpacing.xl),

            //SECURITY & ALERTS_____________________________________________
            SectionLabel(
              actualLabel: "SECURITY & ALERTS",
              textStyle: AppTextStyles.bodyMedium.copyWith(
                color: colorsScheme.onSurfaceVariant,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.8,
              ),
            ),

            const SizedBox(height: AppSpacing.md),
            SecurityAndAlerts(),

            //DATA MANAGEMENT_____________________________________________
            const SizedBox(height: AppSpacing.xl),
            SectionLabel(
              actualLabel: "DATA MANAGEMENT",
              textStyle: AppTextStyles.bodyMedium.copyWith(
                color: colorsScheme.onSurfaceVariant,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.8,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            AppCard(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              border: Border.all(color: colorsScheme.surfaceContainerHighest),
              child: Column(
                children: [
                  ProfileListTileWidget(
                    title: "Export Statement",
                    subTitle: "Download your data in CSV or PDF",
                    leadingIcon: LucideIcons.download,
                    trailingWidget: Icon(LucideIcons.chevronRight),
                  ),
                ],
              ),
            ),
            //LOG OUT_____________________________________________
            const SizedBox(height: AppSpacing.xl),
            LogOutButton(),
            const SizedBox(height: AppSpacing.xl),
            //note_____________________________________________
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Spendly V0.0.1"),
                Text(
                  "Made with ❤️ for financial freedom by Demystik",
                  style: AppTextStyles.labelMedium,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
        ),
      ),
    );
  }

  AppCard preferences(BuildContext context, ColorScheme colorsScheme) {
    return AppCard(
      border: Border.all(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      child: Column(
        children: [
          ProfileListTileWidget(
            title: "Dark Appearance",
            subTitle: "Customize your interface",
            leadingIcon: LucideIcons.sunDim,
            trailingWidget: ThemeSwitcher(),
          ),
          Divider(color: Theme.of(context).colorScheme.surfaceContainerHighest),
          ProfileListTileWidget(
            title: "Income",
            subTitle: "Update your income",
            leadingIcon: LucideIcons.banknote,
            trailingWidget: FilledButton(
              onPressed: () =>
                  showIncomeBottomSheetMethod(context, colorsScheme),
              child: Text("Edit"),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> showIncomeBottomSheetMethod(
    BuildContext context,
    ColorScheme appColorScheme,
  ) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.lg),
          bottom: Radius.zero,
        ),
      ),
      isScrollControlled: true,

      backgroundColor: appColorScheme.onPrimary,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, modalSetState) => SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            "Update Income",
                            textAlign: TextAlign.center,
                            style: AppTextStyles.titleLarge.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          amountInputController.clear();
                          context.pop();
                        },
                        icon: Icon(LucideIcons.x),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.sm),
                  Text("Update your income for this month"),
                  SizedBox(height: AppSpacing.md),
                  Text("Your Income:"),
                  SizedBox(height: AppSpacing.sm),
                  AppTextField(
                    controller: amountInputController,
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    label: context
                        .read<IncomeProvider>()
                        .monthlyIncome
                        .toString(),
                    errorText: errorText,
                    onChanged: (_) {
                      if (errorText != null) {
                        modalSetState(() {
                          errorText = null;
                        });
                      }
                    },
                  ),
                  SizedBox(height: AppSpacing.lg),
                  SizedBox(
                    child: AppButton(
                      label: "Save",
                      onPressed: () {
                        final error = _validator(amountInputController);

                        modalSetState(() {
                          errorText = error;
                        });

                        if (error != null) return;

                        final double amount = double.parse(
                          amountInputController.text.trim(),
                        );
                        context.read<IncomeProvider>().setIncome(amount);
                        amountInputController.clear();

                        modalSetState(() {
                          errorText = null;
                        });

                        context.pop();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(AppRadius.lg),
          ),
        ),
      ),
      onPressed: () async {
        await AuthService().signOut();
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              LucideIcons.logOut,
              size: 22,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              "Log Out",
              style: AppTextStyles.bodyMedium.copyWith(
                color: Theme.of(context).colorScheme.error,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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

        const SizedBox(height: AppSpacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Henry Revira", style: AppTextStyles.titleLarge),
            const SizedBox(width: AppSpacing.sm),
            Icon(
              LucideIcons.shieldCheck,
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
        Text("henry.revira@gmail.com", style: AppTextStyles.bodyMedium),
        const SizedBox(height: AppSpacing.md),
        AppChip(label: "PRO MEMBER"),
        const SizedBox(height: AppSpacing.xl),
      ],
    );
  }
}

class SecurityAndAlerts extends StatelessWidget {
  const SecurityAndAlerts({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      border: Border.all(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      child: Column(
        children: [
          ProfileListTileWidget(
            title: "Push Notifications",
            subTitle: "Alerts for budgets & spending",
            leadingIcon: LucideIcons.bell,
            trailingWidget: NotificationSwitcher(),
          ),
          Divider(color: Theme.of(context).colorScheme.surfaceContainerHighest),
          ProfileListTileWidget(
            title: "Privacy & Security",
            subTitle: "Biometric Login & 2FA",
            leadingIcon: LucideIcons.lock,
            trailingWidget: Icon(LucideIcons.chevronRight),
          ),
          Divider(color: Theme.of(context).colorScheme.surfaceContainerHighest),
          Consumer<UserRegionProvider>(
            builder: (context, value, child) => ProfileListTileWidget(
              title: "Region",
              subTitle: value.selectedRegion.name,
              leadingIcon: LucideIcons.globe,
              trailingWidget: UserRegionDropDown(),
            ),
          ),
        ],
      ),
    );
  }
}

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModeProvider>(
      builder: (context, themeProvider, child) {
        return Switch(
          trackOutlineWidth: WidgetStateProperty.resolveWith((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.disabled)) {
              return 5;
            }
            return null;
          }),
          activeTrackColor: Theme.of(
            context,
          ).colorScheme.surfaceContainerHighest,
          inactiveTrackColor: Colors.grey.shade300,
          inactiveThumbColor: Colors.white,
          activeThumbColor: Theme.of(context).colorScheme.primary,
          value: themeProvider.darkMode,
          onChanged: (val) {
            themeProvider.changeMode(val);
          },
        );
      },
    );
  }
}

class NotificationSwitcher extends StatefulWidget {
  const NotificationSwitcher({super.key});

  @override
  State<NotificationSwitcher> createState() => _NotificationSwitcherState();
}

class _NotificationSwitcherState extends State<NotificationSwitcher> {

  bool notif = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      trackOutlineWidth: WidgetStateProperty.resolveWith((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.disabled)) {
          return 5;
        }
        return null;
      }),
      activeTrackColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      inactiveTrackColor: Colors.grey.shade300,
      inactiveThumbColor: Colors.white,
      activeThumbColor: Theme.of(context).colorScheme.primary,
      value: notif,
      onChanged: (val) {
        setState(() {
          notif = val;
        });
      },
    );
  }
}

class ProfileListTileWidget extends StatelessWidget {
  const ProfileListTileWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.leadingIcon,
    required this.trailingWidget,
  });
  final String title;
  final String subTitle;
  final IconData leadingIcon;
  final Widget trailingWidget;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(5),
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Icon(
          leadingIcon,
          color: Theme.of(context).colorScheme.primary,
          size: 28,
        ),
      ),

      title: Text(title, style: AppTextStyles.titleMedium),
      subtitle: Text(subTitle, style: AppTextStyles.bodySmall),
      contentPadding: EdgeInsets.all(0),
      trailing: trailingWidget,
    );
  }
}

class UserRegionDropDown extends StatelessWidget {
  const UserRegionDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<RegionModel>(
      focusColor: Colors.transparent,
      // value: userRegion.selectedRegion,
      isDense: true,
      borderRadius: BorderRadius.circular(AppRadius.md),
      underline: const SizedBox(),
      icon: const Icon(LucideIcons.chevronRight),
      items: regions.map((item) {
        return DropdownMenuItem<RegionModel>(
          value: item,
          child: Text(item.name, style: AppTextStyles.bodyLarge),
        );
      }).toList(),
      onChanged: (region) {
        context.read<UserRegionProvider>().changeRegion(region!);
      },
    );
  }
}

String? _validator(TextEditingController amountController) {
  final String inputAmount = amountController.text.trim();
  if (inputAmount.isEmpty) {
    return "Budget amount cannot be empty";
  }
  final double? amount = double.tryParse(inputAmount);

  if (amount == null) {
    return "Enter a valid number";
  }

  if (amount <= 0) {
    return "Budget must be greater than 0";
  }

  if (amount > 100000000) {
    return "Too much, please enter valid budget";
  }

  return null;
}
