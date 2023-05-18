import 'package:flutter/material.dart';
import 'package:number_slider/pages/home.dart';

void returnHome(BuildContext context) {
  Navigator.of(context)
    ..popUntil((route) => route.isFirst)
    ..pushReplacement(MaterialPageRoute(
      builder:(context) => const HomePage()
  ));
}

String difficultyLabel(int size) {
  final String suffix = "$size x $size";
  if (size < 4) {
    return "Easy - $suffix";
  } else if (size > 4) {
    return "Hard - $suffix";
  } else {
    return "Normal - $suffix";
  }
}

String formatDate(DateTime date) {
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
  return "${date.day} ${monthDict[date.month] ?? '?'} ${date.year}";
}