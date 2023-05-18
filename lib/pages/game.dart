import 'package:flutter/material.dart';
import 'package:flutter_demo/utils.dart';
import 'package:flutter_demo/widgets/navbar.dart';
import 'package:flutter_demo/widgets/slider_widget.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key, required this.size, required this.date});
  final int size;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(difficultyLabel(size)),
      ),
      body: Center(
        child: SliderGameWidget(
          size: size,
          dateSeed: date,
        ),
      ),
      bottomNavigationBar: const MyNavBar(highlightedIndex: 1),
    );
  }
}