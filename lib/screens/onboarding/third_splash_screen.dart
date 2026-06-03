import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:spendly/themes/app_spacing.dart';
import 'package:spendly/themes/app_text_styles.dart';
import 'package:spendly/widgets/app_button.dart';

class ThirdSplashScreen extends StatefulWidget {
  const ThirdSplashScreen({super.key});

  @override
  State<ThirdSplashScreen> createState() => _ThirdSplashScreenState();
}

class _ThirdSplashScreenState extends State<ThirdSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController ctrl;
  late Animation<double> size;
  late Animation<Offset> slider;
  late Animation<Offset> secondSlider;

  @override
  void initState() {
    super.initState();

    ctrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );

    size = Tween<double>(
      begin: 10,
      end: 30,
    ).animate(CurvedAnimation(parent: ctrl, curve: Curves.easeIn));

    slider = Tween<Offset>(
      begin: Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: ctrl, curve: Curves.easeIn));

    secondSlider = Tween<Offset>(
      begin: Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: ctrl, curve: Curves.easeIn));

    ctrl.forward();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenColorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: AnimatedBuilder(
            animation: ctrl,
            builder: (context, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(height: AppSpacing.lg),
                //Image__________________________________
                SizedBox(
                  width: screenSize.width * 0.6,
                  height: screenSize.width * 0.6,
                  child: SvgPicture.asset(
                    "assets/animations/undraw_financial-data_lbci.svg",
                  ),
                ),
                //Main Text________________________________
                SlideTransition(
                  position: slider,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Visualize Spending",
                          style: AppTextStyles.displayLarge.copyWith(
                            color: screenColorScheme.onSurface,
                          ),
                        ),
                        TextSpan(
                          text: "\ninsights & trends",
                          style: AppTextStyles.displayLarge.copyWith(
                            color: screenColorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: AppSpacing.md),
                //sub Text________________________________
                SlideTransition(
                  position: secondSlider,
                  child: Opacity(
                    opacity: 0.7,
                    child: Text(
                      textAlign: TextAlign.center,
                      "Get clear charts and detailed reports on your monthly financial habits and savings.",
                      style: AppTextStyles.bodyLarge,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),

                //Splash buttons___________________________
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 5,
                  children: [
                    SplashButton(
                      screenColorScheme: screenColorScheme,
                      main: false,
                    ),
                    SplashButton(
                      screenColorScheme: screenColorScheme,
                      main: false,
                    ),
                    SplashButton(
                      screenColorScheme: screenColorScheme,
                      main: true,
                      size: size.value,
                    ),
                  ],
                ),

                //Next buttons__________________________
                AppButton(
                  label: "Get Started >",
                  onPressed: () {
                    context.go("/login");
                  },
                ),

                SizedBox(height: AppSpacing.md),
              ],
            ),
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
    this.size,
  });

  final ColorScheme screenColorScheme;
  final bool main;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      width: main ? size : 8,
      decoration: BoxDecoration(
        color: main
            ? screenColorScheme.primary
            : screenColorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
    );
  }
}
