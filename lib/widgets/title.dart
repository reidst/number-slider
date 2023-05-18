import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("- Number Slider -",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 40,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}