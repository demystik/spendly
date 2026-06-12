import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
import 'package:spendly/screens/onboarding/privacy_policy_screen.dart';
import 'package:spendly/screens/onboarding/term_of_services.dart';
import 'package:spendly/services/auth_service.dart';
import 'package:spendly/themes/app_spacing.dart';
import 'package:spendly/themes/app_text_styles.dart';
import '../../routes/app_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isSigningIn = false;

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
              Image.asset("assets/logos/spendly_logo2.png", width: 100),
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
                    padding: EdgeInsets.all(AppSpacing.sm),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                  ),
                  onPressed: _isSigningIn
                      ? null
                      : () async {
                          setState(() {
                            _isSigningIn = true;
                          });

                          try {
                            await AuthService().signInWithGoogle();
                            authProvider.refresh();
                          } catch (e) {
                            if (!mounted) return;
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())),
                            );
                          } finally {
                            if (mounted) {
                              setState(() {
                                _isSigningIn = false;
                              });
                            }
                          }
                        },

                  icon: const Icon(Icons.g_mobiledata, size: 35),

                  label: _isSigningIn
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text(
                          "Continue with Google",
                          style: AppTextStyles.bodyLarge,
                        ),
                ),
              ),
              SizedBox(height: screenSize.height * 0.04),
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  style: AppTextStyles.bodySmall,
                  children: [
                    TextSpan(text: "By continuing, you agree with our "),
                    TextSpan(
                      text: "Terms of Service",
                      style: const TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // context.push('/terms_of_services');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const TermsOfServices(),
                            ),
                          );
                        },
                    ),
                    TextSpan(text: " and "),
                    TextSpan(
                      text: "Privacy Policy",
                      style: const TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const PrivacyPolicyScreen(),
                            ),
                          );
                          // context.push('/privacy_policy_screen');
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
