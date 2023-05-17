import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/navbar.dart';
import 'package:flutter_demo/widgets/slider_widget.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key, required this.username, required this.size});

  final String username;
  final int size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Beta")
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Your username: $username"),
            const SizedBox(height: 20.0),
            SliderGameWidget(size: size, shuffleStrength: 100),
          ],
        ),
      ),
      bottomNavigationBar: const MyNavBar(highlightedIndex: 1),
    );
  }
}