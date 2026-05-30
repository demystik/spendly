import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:spendly/models/expense_model.dart';
import 'package:spendly/models/monthly_budget_model.dart';
import 'package:spendly/providers/amount_range_provider.dart';
import 'package:spendly/providers/budget_provider.dart';
import 'package:spendly/providers/category_budget_provider.dart';
import 'package:spendly/providers/category_provider.dart';
import 'package:spendly/providers/currency_providers.dart';
import 'package:spendly/providers/datetime_provider.dart';
import 'package:spendly/providers/expense_provider.dart';
import 'package:spendly/providers/income_provider.dart';
import 'package:spendly/providers/payment_method.dart';
import 'package:spendly/providers/theme_mode_provider.dart';
import 'package:spendly/providers/user_region_provider.dart';
import 'package:spendly/routes/app_router.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(ExpenseAdapter());
  await Hive.openBox<Expense>('expensesBox');
  Hive.registerAdapter(MonthlyBudgetModelAdapter());
  await Hive.openBox<MonthlyBudgetModel>('monthlyBudgetBox');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PaymentProvider()),
        ChangeNotifierProvider(create: (_) => ExpenseProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => DatetimeProvider()),
        ChangeNotifierProvider(create: (_) => AmountRangeProvider()),
        ChangeNotifierProvider(create: (_) => ThemeModeProvider()),
        ChangeNotifierProvider(create: (_) => CurrencyProvider()),
        ChangeNotifierProvider(create: (_) => BudgetProvider()),
        ChangeNotifierProvider(create: (_) => IncomeProvider()),
        ChangeNotifierProvider(create: (_) => CategoryBudgetProvider()),
        ChangeNotifierProvider(create: (_) => UserRegionProvider()),
      ],
      child: const MyApp(),
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
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      darkTheme: ThemeData(brightness: Brightness.dark),
      // themeMode: ThemeMode.dark,
      themeMode: context.watch<ThemeModeProvider>().darkMode ? ThemeMode.dark : ThemeMode.light,
      routerConfig: appRouter,
    );
  }
}
