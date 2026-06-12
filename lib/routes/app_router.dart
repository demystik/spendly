import 'package:go_router/go_router.dart';
import 'package:spendly/bottom_navbar.dart';
import 'package:spendly/models/expense_model.dart';
import 'package:spendly/screens/add_expense_screen.dart';
import 'package:spendly/screens/analytics_screen.dart';
import 'package:spendly/screens/auth/login_screen.dart';
import 'package:spendly/screens/budget_screen.dart';
import 'package:spendly/screens/expense_details.dart';
import 'package:spendly/screens/onboarding/app_splash_screen.dart';
import 'package:spendly/screens/onboarding/first_splash_screen.dart';
import 'package:spendly/screens/home_screen.dart';
import 'package:spendly/screens/onboarding/income_screen.dart';
import 'package:spendly/screens/onboarding/privacy_policy_screen.dart';
import 'package:spendly/screens/onboarding/term_of_services.dart';
import 'package:spendly/screens/profile_screen.dart';
import 'package:spendly/screens/search_and_filter_screen.dart';
import 'package:spendly/screens/onboarding/second_splash_screen.dart';
import 'package:spendly/screens/onboarding/third_splash_screen.dart';
import 'package:spendly/providers/auth_provider.dart';

final authProvider = AppAuthProvider();

final splashRoutes = {
  '/first_splash_screen',
  '/second_splash_screen',
  '/third_splash_screen',
};

final GoRouter appRouter = GoRouter(
  refreshListenable: authProvider,

  initialLocation: '/',

  redirect: (context, state) {
    final loc = state.uri.path;
    final status = authProvider.status;

    if (status == AppStatus.loading) return '/';

    // NOT logged in → onboarding + login allowed
    if (status == AppStatus.unauthenticated) {
      if (loc == '/login' || splashRoutes.contains(loc)) return null;
      return '/first_splash_screen';
    }

    // logged in but no income
    if (status == AppStatus.needsIncome) {
      if (loc == '/income_onboarding_screen') {
        return null;
      }
      return '/income_onboarding_screen';
    }

    // fully ready user
    if (status == AppStatus.authenticated) {
      if (loc == '/login' ||
          loc == '/income_onboarding_screen' ||
          splashRoutes.contains(loc)) {
        return '/homescreen';
      }
    }

    return null;
  },

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
    GoRoute(
      path: "/income_onboarding_screen",
      builder: (context, index) => const IncomeOnboardingScreen(),
    ),
    GoRoute(path: "/login", builder: (context, index) => const LoginScreen()),
    GoRoute(path: "/", builder: (context, index) => const AppSplashScreen()),
    GoRoute(path: "/terms_of_services", builder: (context, index) => const TermsOfServices()),
    GoRoute(path: "/privacy_policy_screen", builder: (context, index) => const PrivacyPolicyScreen()),
  ],
);
