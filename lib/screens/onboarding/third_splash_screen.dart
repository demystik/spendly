import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:spendly/themes/app_spacing.dart';
import 'package:spendly/themes/app_text_styles.dart';
import 'package:spendly/widgets/app_button.dart';
import 'package:spendly/widgets/app_chip.dart';

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

    size = Tween<double>(begin: 10, end: 30,).animate(
      CurvedAnimation(parent: ctrl, curve: Curves.easeIn),
    );
    
    slider = Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset.zero).animate(CurvedAnimation(parent: ctrl, curve: Curves.bounceIn),);

    secondSlider = Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset.zero).animate(CurvedAnimation(parent: ctrl, curve: Curves.bounceIn),);
    
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
            builder: (context, child) =>  Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: AlignmentGeometry.centerRight,
                  child: AppChip(
                    onTap: () => context.pop(),
                    label: "Skip"),
                ),
                SizedBox(height: AppSpacing.lg),
                SizedBox(
                  width: screenSize.width * 0.6,
                  height: screenSize.width * 0.6,
                  child: SvgPicture.asset("assets/animations/online-banking.svg"),
                ),
                Spacer(),
                SlideTransition(
                    position: slider,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Visualize Spending",
                            style: AppTextStyles.displayLarge,
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
                SlideTransition(
                  position: secondSlider,
                  child: Opacity(
                    opacity: 0.7,
                    child: Text(
                      textAlign: TextAlign.center,
                      "Get clear charts and detailed reports on your monthly financial habits and savings.",
                      style: AppTextStyles.titleMedium,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
            
                Spacer(),
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
            
                SizedBox(height: AppSpacing.md),
                AppButton(
                  label: "Get Started >",
                  onPressed: () {
                    // context.go("/sign_up_screen");
                  },
                ),
            
                SizedBox(height: AppSpacing.md),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "sign in",
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: screenColorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
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
