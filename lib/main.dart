import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/home.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      colorScheme: const ColorScheme.dark(),
    ),
    home: const HomePage(),
  ));
}