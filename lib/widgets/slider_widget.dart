import 'package:flutter/material.dart';
import 'package:number_slider/model/slider.dart';
import 'package:number_slider/widgets/number_tile.dart';

class SliderGameWidget extends StatefulWidget {
  const SliderGameWidget({super.key,
    required this.size,
    required this.dateSeed,
  });

  final int size;
  final DateTime dateSeed;

  @override
  State<SliderGameWidget> createState() => _SliderGameWidgetState();
}

class _SliderGameWidgetState extends State<SliderGameWidget> {
  late final SliderGame _game;
  bool _lock = false;

  @override
  void initState() {
    super.initState();
    _game = SliderGame(size: widget.size);
    _game.shuffleByDate(widget.dateSeed);
  }

  String? _display(int row, int col) =>
    Coord(row, col) == _game.space
      ? null
      : (_game[Coord(row, col)] + 1).toString();

  void _onVerticalSwipe(DragEndDetails details) {
    if (_lock) { return; }
    if (details.primaryVelocity == null) {
      return;
    } else {
      final sign = details.primaryVelocity!.sign.toInt();
      setState(() {
        _game.move(Coord(-sign, 0));
      });
      if (_game.isSolved()) {
        _lock = true;
      }
    }
  }

  void _onHorizontalSwipe(DragEndDetails details) {
    if (_lock) { return; }
    if (details.primaryVelocity == null) {
      return;
    } else {
      final sign = details.primaryVelocity!.sign.toInt();
      setState(() {
        _game.move(Coord(0, -sign));
      });
      if (_game.isSolved()) {
        _lock = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSolved = _game.isSolved();
    return GestureDetector(
      onVerticalDragEnd: _onVerticalSwipe,
      onHorizontalDragEnd: _onHorizontalSwipe,
      child: AspectRatio(
        aspectRatio: 11 / 12,
        child: Column(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: List<Widget>.generate(
                widget.size,
                (rowIndex) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List<Widget>.generate(
                    widget.size,
                    (colIndex) => NumberTile(
                      display: _display(rowIndex, colIndex),
                      scale: widget.size / 1.0,
                      solved: isSolved,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Row( // used to be inside FittedBox(cover)
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      alignment: Alignment.centerLeft,
                      child: Text("Moves: ${_game.playerMoveCount}"),
                    ),
                  ),
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      alignment:Alignment.centerRight,
                      child: Text(
                        isSolved ? "You Win!" : " ",
                        style: TextStyle(
                          color: Theme.of(context).indicatorColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}