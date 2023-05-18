import 'package:flutter/material.dart';

const filledTileColor = Color.fromARGB(255, 64, 64, 64);
const emptyTileColor = Color.fromARGB(255, 32, 32, 32);

class NumberTile extends StatelessWidget {
  const NumberTile({
    super.key,
    required this.display,
    required this.scale,
    required this.solved
  });
  final String? display;
  final double scale;
  final bool solved;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          // transparent middle container allows GestureDetector to detect
          // swipes that occur in between tiles
          decoration: const BoxDecoration(
            color: Colors.transparent
          ),
          child: Container(
            margin: EdgeInsets.all(16 / scale),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(64 / scale),
              color: display == null
              ? emptyTileColor
              : filledTileColor,
            ),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  display ?? "",
                  style: TextStyle(
                    fontSize: 180 / scale,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}