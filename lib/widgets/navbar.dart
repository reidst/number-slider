import 'package:flutter/material.dart';
import 'package:number_slider/pages/home.dart';
import 'package:number_slider/pages/settings.dart';
import 'package:number_slider/utils.dart';

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
            onPressed: () => goToPage(context, () => const HomePage()),
            icon: const Icon(Icons.home_outlined),
          ),
          activeIcon: const Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            onPressed: () {},
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