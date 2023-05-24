import 'package:flutter/material.dart';
import 'package:number_slider/model/slider.dart';
import 'package:number_slider/utils.dart';
import 'package:number_slider/widgets/number_tile.dart';

class SliderGameWidget extends StatefulWidget {
  const SliderGameWidget({super.key,
    required this.size,
    required this.dateSeed,
    this.onWinCallback,
  });

  final int size;
  final DateTime dateSeed;
  final Function()? onWinCallback;

  @override
  State<SliderGameWidget> createState() => _SliderGameWidgetState();
}

class _SliderGameWidgetState extends State<SliderGameWidget> {
  late final SliderGame _game;
  bool _lock = false;
  Offset? _swipeStartOffset;
  Offset? _latestSwipeOffset;

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

  void _onSwipeStart(DragStartDetails details) {
    _swipeStartOffset = details.localPosition;
  }

  void _onSwipeUpdate(DragUpdateDetails details) {
    _latestSwipeOffset = details.localPosition;
  }

  void _onSwipeEnd(DragEndDetails details) {
    if (_swipeStartOffset == null || _latestSwipeOffset == null) {
      debugPrint("unexpected PanEnd, data was not collected for PanStart and/or PanUpdate");
      return;
    }
    if (_lock) { return; }

    final start = _swipeStartOffset!;
    final end = _latestSwipeOffset!;
    final dc = end.dx - start.dx;
    final dr = end.dy - start.dy;
    late Coord move;
    if (dr.abs() > dc.abs()) {
      move = Coord(-dr.sign.toInt(), 0);
    } else {
      move = Coord(0, -dc.sign.toInt());
    }
    setState(() => _game.move(move));

    if (_game.isSolved()) {
      _lock = true;
      widget.onWinCallback?.call();
    }

    _swipeStartOffset = null;
    _latestSwipeOffset = null;
  }

  @override
  Widget build(BuildContext context) {
    final isSolved = _game.isSolved();
    return AspectRatio(
      aspectRatio: 10 / 12,
      child: Column(
        children: [
          Expanded(
            child: Row(
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
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => setState(() {
                        if (!isSolved) _game.undo();
                      }),
                      onLongPress: () async {
                        if (!isSolved) { await showConfirmationDialog(
                          context: context,
                          title: "Reset Puzzle",
                          body: "Are you sure you want to reset the puzzle?",
                          cancelLabel: "No thanks",
                          confirmLabel: "Reset",
                          confirmAction: () => setState(() => _game.reset()),
                        );}
                      },
                      child: const Icon(Icons.replay),
                    )
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onPanStart: _onSwipeStart,
            onPanUpdate: _onSwipeUpdate,
            onPanEnd: _onSwipeEnd,
            child: Column(
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
          ),
          Expanded(
            child: Row(
              children: [
                const Spacer(),
                Expanded(
                  flex: 2,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    alignment:Alignment.center,
                    child: Text(
                      isSolved ? "You Win!" : " ",
                      style: TextStyle(
                        color: Theme.of(context).indicatorColor,
                      ),
                    ),
                  ),
                ),
                if (isSolved) Expanded(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: (){},  // TODO: upload score to firebase
                      child: const Icon(Icons.cloud_upload_outlined),
                    )
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}