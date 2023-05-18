import 'package:flutter/material.dart';
import 'package:number_slider/pages/game.dart';
import 'package:number_slider/widgets/title.dart';
import 'package:number_slider/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DateTime chosenDate;

  @override
  void initState() {
    super.initState();
    chosenDate = DateTime.now();
  }

  Future<void> _dateDialog(BuildContext context) async {
    final choice = await showDatePicker(
      context: context,
      initialDate: chosenDate,
      firstDate: DateTime(1),
      lastDate: DateTime(9999, 12, 31),
    );
    if (choice != null) {
      setState(() {
        chosenDate = choice;
      });
    }
  }

  String _formatDate() {
    const monthDict = <int, String>{
      1: "January",
      2: "February",
      3: "March",
      4: "April",
      5: "May",
      6: "June",
      7: "July",
      8: "August",
      9: "September",
      10: "October",
      11: "November",
      12: "December",
    };
    return "${chosenDate.day} ${monthDict[chosenDate.month] ?? '?'} ${chosenDate.year}";
  }

  Widget _generatePlayButton(BuildContext context, int size) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
            Theme.of(context).colorScheme.onPrimary
          ),
        ),
        onPressed: () => goToPage(context, () =>
          GamePage(
            size: size,
            date: chosenDate,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Text(
            difficultyLabel(size),
            textScaleFactor: 1.5,
          ),
        ),
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
            const Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: TitleWidget(),
            ),
            TextButton(
              onPressed: () => _dateDialog(context),
              child: Text("Puzzles for: ${_formatDate()}")
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: List.generate(3, (index) =>
                _generatePlayButton(context, index + 3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}