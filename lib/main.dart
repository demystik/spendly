import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spendly/providers/expense_provider.dart';
import 'package:spendly/providers/payment_method.dart';
import 'package:spendly/routes/app_router.dart';

void main() {
  runApp(
    
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PaymentMethodProvider()
          ),
        ChangeNotifierProvider(
          create: (_) => ExpenseProvider()
          ),
      ],
    child: const MyApp()
    ),   
    );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Spendly",
      debugShowCheckedModeBanner: false,
    
      theme: ThemeData(
       colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark
      ),
      themeMode: ThemeMode.light,
    
      routerConfig: appRouter,
    );
  }
}


