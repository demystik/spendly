import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:spendly/providers/auth_provider.dart';
import 'package:spendly/providers/income_provider.dart';
import 'package:spendly/themes/app_spacing.dart';
import 'package:spendly/themes/app_text_styles.dart';

class IncomeOnboardingScreen extends StatefulWidget {
  const IncomeOnboardingScreen({super.key});

  @override
  State<IncomeOnboardingScreen> createState() => _IncomeOnboardingScreenState();
}

class _IncomeOnboardingScreenState extends State<IncomeOnboardingScreen> {
  late final TextEditingController incomeController;

  bool _isSaving = false;

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

  final _formatter = NumberFormat('#,##0');

  void saveIncome() async {
    final input = incomeController.text.replaceAll(',', '');
    final income = double.tryParse(input);

    if (income == null || income <= 0) {
      setState(() {
        errorText = "Enter a valid income";
      });
      return;
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    setState(() => _isSaving = true);

    try {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'incomeSet': true,
        'income': income,
      }, SetOptions(merge: true));

      if (!mounted) return;
      context.read<IncomeProvider>().setIncome(income);
      context.read<AppAuthProvider>().setIncomeDone();
      context.go('/homescreen');

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to save income. Check internet.")),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: screenSize.width * 0.6,
                height: screenSize.width * 0.6,
                child: SvgPicture.asset(
                  "assets/animations/undraw_wallet_diag.svg",
                ),
              ),

              const SizedBox(height: AppSpacing.xl),
              Column(
                children: [
                  const Text(
                    "What's your monthly income?",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  const Text(
                    'This helps Spendly personalize budgeting and savings insights.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.md),

              TextField(
                controller: incomeController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onChanged: (value) {
                  final cleaned = value.replaceAll(',', '');

                  if (cleaned.isEmpty) return;

                  final number = double.tryParse(cleaned);
                  if (number == null) return;

                  final formatted = _formatter.format(number);

                  incomeController.value = TextEditingValue(
                    text: formatted,
                    selection: TextSelection.collapsed(
                      offset: formatted.length,
                    ),
                  );

                  if (errorText != null) {
                    setState(() => errorText = null);
                  }
                },
                textAlign: TextAlign.center,
                style: AppTextStyles.displayLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  // fontSize: 42,
                ),
                enableInteractiveSelection: false,
                decoration: InputDecoration(
                  hintText: '0.00',
                  // prefixText: '₦ ',
                  errorText: errorText,
                ),
              ),

              const SizedBox(height: AppSpacing.xxxl),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: FilledButton(
                  onPressed: _isSaving ? null : saveIncome,
                  child: _isSaving
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Continue'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
