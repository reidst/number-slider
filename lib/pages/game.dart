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
    await showConfirmationDialog(
      context: context,
      title: "Quit Puzzle",
      body: "Are you sure you want to quit? Your progress will be lost.",
      cancelLabel: "No thanks",
      confirmLabel: "Quit",
      confirmAction: () => choice = true,
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