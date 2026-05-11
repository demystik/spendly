import 'package:go_router/go_router.dart';
import 'package:spendly/bottom_navbar.dart';
import 'package:spendly/screens/analytics_screen.dart';
import 'package:spendly/screens/budget_screen.dart';
import 'package:spendly/screens/home_screen.dart';
import 'package:spendly/screens/profile_screen.dart';

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
  ],
);
