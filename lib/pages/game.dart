import 'package:flutter/material.dart';
import 'package:number_slider/utils.dart';
import 'package:number_slider/widgets/navbar.dart';
import 'package:number_slider/widgets/slider_widget.dart';

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