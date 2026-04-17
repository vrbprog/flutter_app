import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Scaffold(body: Subtask2()),
    );
  }
}

class MyCard extends StatelessWidget {
  const MyCard({
    super.key,
    this.color = Colors.blue,
    this.label,
    this.colorStar = Colors.transparent,
    this.mainAlig = MainAxisAlignment.end,
    this.crossAlig = CrossAxisAlignment.end,
  });

  final Color color;
  final String? label;
  final Color colorStar;
  final MainAxisAlignment mainAlig;
  final CrossAxisAlignment crossAlig;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      width: 300,
      height: 150,
      child: Row(
        mainAxisAlignment: mainAlig,
        crossAxisAlignment: crossAlig,
        spacing: 10,
        children: [
          Icon(Icons.star, color: colorStar, size: 24),
          Text(
            label ?? '',
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
          Icon(Icons.star, color: colorStar, size: 24),
        ],
      ),
    );
  }
}

class Subtask1 extends StatelessWidget {
  const Subtask1({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: MyCard());
  }
}

class Subtask2 extends StatelessWidget {
  const Subtask2({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MyCard(label: 'Привіт Flutter!', colorStar: Colors.yellow),
    );
  }
}
