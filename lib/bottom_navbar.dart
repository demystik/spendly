import 'package:flutter/material.dart';
import 'package:spendly/screens/analytics_screen.dart';
import 'package:spendly/screens/budget_screen.dart';
import 'package:spendly/screens/home_screen.dart';
import 'package:spendly/screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _navigatorBottomBar(int index) {
    setState(() => _selectedIndex = index);
  }

  final List<Widget> _screens = const [
    HomeScreen(),
    AnalyticsScreen(),
    BudgetScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: _bottomNavigationBar(
        _selectedIndex,
        _navigatorBottomBar,
      ),
    );
  }
}

BottomNavigationBar _bottomNavigationBar(
  int selectedIndex,
  ValueChanged<int> navigatorBottomBar,
) {
  return BottomNavigationBar(
    selectedFontSize: 12,
    unselectedFontSize: 12,
    
    currentIndex: selectedIndex,
    type: BottomNavigationBarType.fixed,
    onTap:  navigatorBottomBar,
    items: [
      BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        activeIcon: Icon(Icons.home_filled),
        label: "Home",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.analytics_outlined),
        activeIcon: Icon(Icons.analytics_rounded),
        label: "Analytics",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.account_balance_wallet_outlined),
        activeIcon: Icon(Icons.account_balance_wallet_rounded),
        label: "Budget",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person_3_outlined),
        activeIcon: Icon(Icons.person_3_rounded),
        label: "Profile",
      ),
    ],
  );
}
