import 'package:flutter/material.dart';
import 'package:number_slider/pages/home.dart';

/// Navigates to the page created by `pageBuilder` without allowing the user to 
/// go back to the previous page.
/// 
/// Example usage:
/// ```dart
/// TextButton(
///   onPressed: () => goToPage(context, () => const NewPage()),
///   child: const Text("go to new page"),
/// )
/// ```
void goToPage(BuildContext context, Function() pageBuilder) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => pageBuilder(),
    ),
  );
}

void returnHome(BuildContext context) {
  Navigator.of(context)
    ..popUntil((route) => route.isFirst)
    ..pushReplacement(MaterialPageRoute(
      builder:(context) => const HomePage()
  ));
}

String difficultyLabel(int size) {
  final String suffix = "$size x $size";
  if (size < 4) {
    return "Easy - $suffix";
  } else if (size > 4) {
    return "Hard - $suffix";
  } else {
    return "Normal - $suffix";
  }
}