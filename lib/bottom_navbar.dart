import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

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
        icon: Icon(LucideIcons.house300),
        activeIcon: Icon(LucideIcons.house300),
        label: "Home",
      ),
      BottomNavigationBarItem(
        icon: Icon(LucideIcons.chartPie300),
        activeIcon: Icon(LucideIcons.chartPie300),
        label: "Analytics",
      ),
      BottomNavigationBarItem(
        icon: Icon(LucideIcons.wallet300),
        activeIcon: Icon(LucideIcons.wallet300),
        label: "Budget",
      ),
      BottomNavigationBarItem(
        icon: Icon(LucideIcons.user300),
        activeIcon: Icon(LucideIcons.user300),
        label: "Profile",
      ),
    ],
  );
}
