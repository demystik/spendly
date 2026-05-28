import 'package:flutter/material.dart';
import 'package:spendly/services/auth_service.dart';
import '../../routes/app_router.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton.icon(
            onPressed: () async {
              await AuthService().signInWithGoogle();
              // force router reevaluation
              authProvider.refresh();
            },

            icon: const Icon(Icons.login),

            label: const Text('Continue with Google'),
          ),
        ),
      ),
    );
  }
}
