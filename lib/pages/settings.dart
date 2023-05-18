import 'package:flutter/material.dart';
import 'package:number_slider/utils.dart';

// TODO: turn gamma into a settings page, figure out tracking global settings
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings")
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => returnHome(context),
              child: const Text("Home")
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("To Beta")
            ),
          ],
        ),
      ),
    );
  }
}