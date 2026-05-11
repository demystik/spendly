import 'package:flutter/material.dart';
import 'package:go_router/src/route.dart';

class MainScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const MainScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: _bottomNavigationBar(navigationShell),
    );
  }
}

BottomNavigationBar _bottomNavigationBar(
  StatefulNavigationShell navigationShell,
) {
  return BottomNavigationBar(
    selectedFontSize: 12,
    unselectedFontSize: 12,

    currentIndex: navigationShell.currentIndex,
    type: BottomNavigationBarType.fixed,
    onTap: (index) {
      navigationShell.goBranch(index);
    },
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
