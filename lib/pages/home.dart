import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/game.dart';
import 'package:flutter_demo/utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  TextButton _generatePlayButton(BuildContext context,int size) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          Theme.of(context).buttonTheme.colorScheme?.background
        ),
      ),
      onPressed: () => goToPage(context, () =>
        GamePage(size: size),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Text(
          difficultyLabel(size),
          textScaleFactor: 1.5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home")
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: List.generate(3, (index) =>
            _generatePlayButton(context, index + 3),
          ),
        ),
      ),
    );
  }
}