import 'package:flutter/material.dart';
import 'package:spendly/services/auth_service.dart';
import 'package:spendly/themes/app_spacing.dart';
import 'package:spendly/themes/app_text_styles.dart';
import '../../routes/app_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Image.asset("assets/logos/spendly_logo2.png", width: 100,),
              SizedBox(height: screenSize.height * 0.04),

              Text("Get started", style: AppTextStyles.displayMedium),
              SizedBox(height: screenSize.height * 0.01),
              Text(
                "Join Spendly to start tracking your daily expenses and reach your financial goals.",
                textAlign: TextAlign.center,
                maxLines: 3,
              ),
              SizedBox(height: screenSize.height * 0.04),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(AppSpacing.md),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    )
                  ),
                  onPressed: () async {
                    await AuthService().signInWithGoogle();
                    // force router reevaluation
                    authProvider.refresh();
                  },
                
                  icon: const Icon(Icons.g_mobiledata, size: 35,),
                
                  label: const Text('Continue with Google', style: AppTextStyles.bodyLarge,),
                ),
              ),
              SizedBox(height: screenSize.height * 0.04),
              Opacity(
                opacity: 0.7,
                child: Text(
                  "By continuing, you agree with our Terms of Service and Privacy Policy.",
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  style: AppTextStyles.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
