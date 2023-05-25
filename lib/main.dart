import 'package:flutter/material.dart';
import 'package:number_slider/pages/home.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    theme: ThemeData(
      colorScheme: const ColorScheme.dark(),
    ),
    home: const HomePage(),
  ));
}