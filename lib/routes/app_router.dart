import 'package:go_router/go_router.dart';
import 'package:spendly/bottom_navbar.dart';
import 'package:spendly/models/expense_model.dart';
import 'package:spendly/screens/add_expense_screen.dart';
import 'package:spendly/screens/analytics_screen.dart';
import 'package:spendly/screens/budget_screen.dart';
import 'package:spendly/screens/expense_details.dart';
import 'package:spendly/screens/first_splash_screen.dart';
import 'package:spendly/screens/home_screen.dart';
import 'package:spendly/screens/profile_screen.dart';
import 'package:spendly/screens/search_and_filter_screen.dart';
import 'package:spendly/screens/second_splash_screen.dart';
import 'package:spendly/screens/third_splash_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/homescreen',

  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScreen(navigationShell: navigationShell);
      },

      branches: [
        //Home Tab, Tab 0_____________________________________
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: "/homescreen",
              builder: (context, state) => HomeScreen(),
            ),
          ],
        ),

        //Analytics Tab, Tab 1 ___________________________________________
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: "/analyticsscreen",
              builder: (context, state) => AnalyticsScreen(),
            ),
          ],
        ),

        //Budget Tab, Tab 2 ___________________________________________
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: "/budgetscreen",
              builder: (context, state) => BudgetScreen(),
            ),
          ],
        ),

        //Profile Tab, Tab 3 ___________________________________________
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: "/profilescreen",
              builder: (context, state) => ProfileScreen(),
            ),
          ],
        ),
      ],
    ),



    //Other screens_________________________________________________
    GoRoute(
      path: "/add_expense_screen",
      builder: (context, index) => const AddExpenseScreen(),
    ),
    GoRoute(
      path: "/search_and_filter_screen",
      builder: (context, index) => const SearchAndFilterScreen(),
    ),
    GoRoute(
      path: "/expense_details_screen",
      builder: (context, state) {
        final expense = state.extra as Expense;
        return ExpenseDetailsScreen(expense: expense);
      },
    ),
    GoRoute(
      path: "/first_splash_screen",
      builder: (context, index) => const FirstSplashScreen(),
      ),
    GoRoute(
      path: "/second_splash_screen",
      builder: (context, index) => const SecondSplashScreen(),
      ),
    GoRoute(
      path: "/third_splash_screen",
      builder: (context, index) => const ThirdSplashScreen(),
      ),
  ],
);
