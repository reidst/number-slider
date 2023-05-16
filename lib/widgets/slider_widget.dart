import 'package:flutter/material.dart';
import 'package:flutter_demo/model/slider.dart';

class SliderGameWidget extends StatefulWidget {
  const SliderGameWidget({super.key,
    required this.size,
    required this.shuffleStrength,
  });

  final int size;
  final int shuffleStrength;

  @override
  State<SliderGameWidget> createState() => _SliderGameWidgetState();
}

class _SliderGameWidgetState extends State<SliderGameWidget> {
  late final SliderGame _game;

  @override
  void initState() {
    super.initState();
    _game = SliderGame(size: widget.size);
    _game.randomMove(widget.shuffleStrength);
  }

  @override
  Widget build(BuildContext context) {
    return Text("$_game",
      style: const TextStyle(fontSize: 24.0),
    );
  }
}