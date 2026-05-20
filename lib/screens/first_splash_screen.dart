import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:spendly/themes/app_spacing.dart';
import 'package:spendly/themes/app_text_styles.dart';
import 'package:spendly/widgets/app_button.dart';
import 'package:spendly/widgets/app_chip.dart';

class FirstSplashScreen extends StatelessWidget {
  const FirstSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenColorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: AlignmentGeometry.centerRight,
                child: AppChip(label: "Skip"),
              ),
              SizedBox(height: AppSpacing.lg),
              SizedBox(
                width: screenSize.width * 0.6,
                height: screenSize.width * 0.6,
                child: SvgPicture.asset("assets/animations/online-banking.svg"),
              ),
              Spacer(),
              Text("Track expenses easily", style: AppTextStyles.displayLarge),
              SizedBox(height: AppSpacing.md),
              Opacity(
                opacity: 0.7,
                child: Text(
                  "Log your daily spending in seconds with our intuitive interface. Simple, fast, and precise.",
                  style: AppTextStyles.titleMedium,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 5,
                children: [
                  SplashButton(
                    screenColorScheme: screenColorScheme,
                    main: true,
                  ),
                  SplashButton(
                    screenColorScheme: screenColorScheme,
                    main: false,
                  ),
                  SplashButton(
                    screenColorScheme: screenColorScheme,
                    main: false,
                  ),
                ],
              ),

              SizedBox(height: AppSpacing.md),
              AppButton(
                label: "Continue >",
                onPressed: () {
                  context.push("/second_splash_screen");
                },
              ),

              SizedBox(height: AppSpacing.md),
            ],
          ),
        ),
      ),
    );
  }
}

class SplashButton extends StatelessWidget {
  const SplashButton({
    super.key,
    required this.screenColorScheme,
    required this.main,
  });

  final ColorScheme screenColorScheme;
  final bool main;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      width: main ? 30 : 8,
      decoration: BoxDecoration(
        color: main
            ? screenColorScheme.primary
            : screenColorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
    );
  }
}
