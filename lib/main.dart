import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spendly/providers/expense_provider.dart';
import 'package:spendly/routes/app_router.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpenseProvider(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
      
        theme: ThemeData(
         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark
        ),
        themeMode: ThemeMode.light,
      
        routerConfig: appRouter,
      ),
    );
  }
}


