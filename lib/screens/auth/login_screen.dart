import 'package:flutter/material.dart';
import 'package:spendly/services/auth_service.dart';

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
            },

            icon: const Icon(Icons.login),

            label: const Text('Continue with Google'),
          ),
        ),
      ),
    );
  }
}
