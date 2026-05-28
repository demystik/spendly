import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:spendly/providers/income_provider.dart';

class IncomeOnboardingScreen extends StatefulWidget {
  const IncomeOnboardingScreen({super.key});

  @override
  State<IncomeOnboardingScreen> createState() => _IncomeOnboardingScreenState();
}

class _IncomeOnboardingScreenState extends State<IncomeOnboardingScreen> {
  late final TextEditingController incomeController;

  String? errorText;

  @override
  void initState() {
    super.initState();
    incomeController = TextEditingController();
  }

  @override
  void dispose() {
    incomeController.dispose();
    super.dispose();
  }

  void saveIncome() async {
    final input = incomeController.text.trim();

    final income = double.tryParse(input);

    if (income == null || income <= 0) return;

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
      'incomeSet': true,
      'income': income,
    });

    if(!mounted) return;
    context.read<IncomeProvider>().setIncome(income);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),

              const Text(
                "What's your monthly income?",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              const Text(
                'This helps Spendly personalize budgeting and savings insights.',
              ),

              const SizedBox(height: 32),

              TextField(
                controller: incomeController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  hintText: '0.00',
                  // prefixText: '₦ ',
                  errorText: errorText,
                ),
                onChanged: (_) {
                  if (errorText != null) {
                    setState(() {
                      errorText = null;
                    });
                  }
                },
              ),

              const Spacer(),

              SizedBox(
                height: 50,
                width: double.infinity,
                child: FilledButton(
                  onPressed: saveIncome,
                  child: const Text('Continue'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
