import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/home.dart';
import 'package:flutter_demo/pages/game.dart';
import 'package:flutter_demo/pages/settings.dart';
import 'package:flutter_demo/utils.dart';

class MyNavBar extends StatelessWidget {
  const MyNavBar({super.key, required this.highlightedIndex});
  final int highlightedIndex;

  void _pushPage(BuildContext context, Function() pageBuilder) {
    Navigator.push(
      context, MaterialPageRoute(
        builder: (context) => pageBuilder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: highlightedIndex,
      items: [
        BottomNavigationBarItem(
          icon: IconButton(
            onPressed: () => goToPage(context, () => HomePage()),
            icon: const Icon(Icons.home_outlined),
          ),
          activeIcon: const Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            onPressed: () => goToPage(context, () => const GamePage(
              username: "fromNavBar",
              size: 4
            )),
            icon: const Icon(Icons.cake_outlined),
          ),
          activeIcon: const Icon(Icons.cake),
          label: "Content",
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            onPressed: () => _pushPage(context, () => const SettingsPage()),
            icon: const Icon(Icons.settings_outlined),
          ),
          activeIcon: const Icon(Icons.settings),
          label: "Settings",
        ),
      ],
    );
  }
}