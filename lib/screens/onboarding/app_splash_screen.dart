import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:spendly/providers/auth_provider.dart';

class AppSplashScreen extends StatefulWidget {
  const AppSplashScreen({super.key});

  @override
  State<AppSplashScreen> createState() => _AppSplashScreenState();
}

class _AppSplashScreenState extends State<AppSplashScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AppAuthProvider>();

    WidgetsBinding.instance.addPostFrameCallback((_) {

      switch (authProvider.status) {
        case AppStatus.unauthenticated:
          context.go('/first_splash_screen');
          break;

        case AppStatus.needsIncome:
          context.go('/income_onboarding_screen');
          break;

        case AppStatus.authenticated:
          context.go('/homescreen');
          break;

        case AppStatus.loading:
          break;
      }
    });
  
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logos/spendly_logo.png', height: 120),
            const SizedBox(height: 20),

            const Text(
              'Spendly',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
