import 'package:flutter/material.dart';
import 'package:flutter_demo/utils.dart';
import 'package:flutter_demo/widgets/navbar.dart';
import 'package:flutter_demo/widgets/slider_widget.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key, required this.size});
  final int size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(difficultyLabel(size)),
      ),
      body: Center(
        child: SliderGameWidget(
          size: size,
          shuffleStrength: size * size * 100
        ),
      ),
      bottomNavigationBar: const MyNavBar(highlightedIndex: 1),
    );
  }
}