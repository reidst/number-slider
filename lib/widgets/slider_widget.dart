import 'package:flutter/material.dart';
import 'package:flutter_demo/model/slider.dart';

const filledTileColor = Color.fromARGB(255, 64, 64, 64);
const emptyTileColor = Color.fromARGB(255, 32, 32, 32);

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

  String? _display(int row, int col) =>
    Coord(row, col) == _game.space
      ? null
      : (_game[Coord(row, col)] + 1).toString();

  @override
  Widget build(BuildContext context) {
    return Column(  // TODO: could this be replaced with a GridView?
      mainAxisSize: MainAxisSize.min,
      children: List<Widget>.generate(
        widget.size,
        (rowIndex) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List<Widget>.generate(
              widget.size,
              (colIndex) => NumberTile(
                display: _display(rowIndex, colIndex),
                scale: widget.size / 1.0
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NumberTile extends StatelessWidget {
  const NumberTile({super.key, required this.display, required this.scale});
  final String? display;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          margin: EdgeInsets.all(16 / scale),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(64 / scale),
            color: display == null ? emptyTileColor : filledTileColor,
          ),
          child: Center(
            child: Text(
              display ?? "",
              style: TextStyle(
                fontSize: 180 / scale,
              ),
            ),
          ),
        ),
      ),
    );
  }
}