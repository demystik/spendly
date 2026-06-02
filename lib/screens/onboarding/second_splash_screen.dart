import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:spendly/themes/app_spacing.dart';
import 'package:spendly/themes/app_text_styles.dart';
import 'package:spendly/widgets/app_button.dart';
import 'package:spendly/widgets/app_chip.dart';

class SecondSplashScreen extends StatefulWidget {
  const SecondSplashScreen({super.key});

  @override
  State<SecondSplashScreen> createState() => _SecondSplashScreenState();
}

class _SecondSplashScreenState extends State<SecondSplashScreen> with SingleTickerProviderStateMixin {
  late Animation<double> _buttonSize;
  late AnimationController ctrl;
    late Animation<Offset> slider;

  @override
  void initState() {
    super.initState();

    ctrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
      );

    _buttonSize = Tween<double>(begin: 10, end: 30,).animate(
      CurvedAnimation(parent: ctrl, curve: Curves.easeIn),
    );

    slider = Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset.zero).animate(CurvedAnimation(parent: ctrl, curve: Curves.easeIn),);
    
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Skip button__________________________
                Align(
                  alignment: AlignmentGeometry.centerRight,
                  child: AppChip(
                    onTap: () => context.go("/login"),
                    label: "Skip"),
                ),
                SizedBox(height: AppSpacing.lg),
                
                //Image__________________________________
                SizedBox(
                  width: screenSize.width * 0.6,
                  height: screenSize.width * 0.6,
                  child: SvgPicture.asset("assets/animations/undraw_personal-finance_xpqg.svg"),
                ),

                //Main Text________________________________
                SlideTransition(
                  position: slider,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Manage Budgets",
                          style: AppTextStyles.displayLarge.copyWith(color: screenColorScheme.onSurface),
                        ),
                        TextSpan(
                          text: "\nSmartly",
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
                Opacity(
                  opacity: 0.7,
                  child: Text(
                    textAlign: TextAlign.center,
                    "Set custom limits for categories and get real-time alerts before you overspend.",
                    style: AppTextStyles.bodyLarge,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
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
                        main: true, size: _buttonSize.value,
                      ),
                    
                    SplashButton(
                      screenColorScheme: screenColorScheme,
                      main: false,
                    ),
                  ],
                ),
            
               //Next buttons__________________________
                AppButton(
                  label: "Continue >",
                  onPressed: () {
                    context.push("/third_splash_screen");
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
