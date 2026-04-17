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
      home: const Scaffold(body: Subtask4()),
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

class Subtask3 extends StatelessWidget {
  const Subtask3({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          MyCard(label: 'Привіт Flutter!', colorStar: Colors.yellow),
          MyCard(
            label: 'Привіт Flutter!',
            color: Colors.lightGreen,
            colorStar: Colors.yellow,
          ),
          MyCard(
            label: 'Привіт Flutter!',
            color: Colors.red,
            colorStar: Colors.yellow,
          ),
        ],
      ),
    );
  }
}

class Subtask4 extends StatelessWidget {
  const Subtask4({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 180.0),
        child: Column(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Expanded(
              flex: 1,
              child: MyCard(
                label: 'Привіт Flutter!',
                colorStar: Colors.yellow,
                mainAlig: MainAxisAlignment.start,
                crossAlig: CrossAxisAlignment.start,
              ),
            ),
            MyCard(
              label: 'Привіт Flutter!',
              color: Colors.lightGreen,
              colorStar: Colors.yellow,
              mainAlig: MainAxisAlignment.center,
              crossAlig: CrossAxisAlignment.center,
            ),
            MyCard(
              label: 'Привіт Flutter!',
              color: Colors.red,
              colorStar: Colors.yellow,
            ),
          ],
        ),
      ),
    );
  }
}
