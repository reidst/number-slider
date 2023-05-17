import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/game.dart';
import 'package:flutter_demo/utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  ButtonStyle _buttonStyle(BuildContext context) {
    return ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(
        Theme.of(context)
        .buttonTheme
        .colorScheme
        ?.background
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: List.generate(3, (index) =>
                TextButton(
                  style: _buttonStyle(context),
                  onPressed: () => goToPage(context, () =>
                    GamePage(size: index + 3)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      difficultyLabel(index + 3),
                      textScaleFactor: 1.5,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}