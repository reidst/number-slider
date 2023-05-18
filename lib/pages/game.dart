import 'package:flutter/material.dart';
import 'package:number_slider/utils.dart';
import 'package:number_slider/widgets/slider_widget.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key, required this.size, required this.date});
  final int size;
  final DateTime date;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  bool canLeaveWithoutConfirm = false;

  Future<bool> _onWillPop(BuildContext context) async {
    if (canLeaveWithoutConfirm) { return true; }
    bool choice = false;
    await showDialog(
      context: context,
      builder:(context) =>
        AlertDialog(
          title: const Text("Quit Puzzle"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Are you sure you want to quit? Your progress will be lost."),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("No thanks"),
                  ),
                  TextButton(
                    onPressed: () {
                      choice = true;
                      Navigator.of(context).pop();
                    },
                    child: const Text("Quit"),
                  ),
                ],
              ),
            ],
          ),
        ),
    );
    return choice;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(difficultyLabel(widget.size)),
              Text(formatDate(widget.date)),
            ],
          ),
        ),
        body: Center(
          child: SliderGameWidget(
            size: widget.size,
            dateSeed: widget.date,
            onWinCallback: () => setState(() => canLeaveWithoutConfirm = true),
          ),
        ),
      ),
    );
  }
}