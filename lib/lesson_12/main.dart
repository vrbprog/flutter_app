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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: GradingPage(),
    );
  }
}

class GradingPage extends StatelessWidget {
  const GradingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        //padding: EdgeInsets.all(16),
        child: SendingPartOfPage(),
      ),
    );
  }
}

class SendingPartOfPage extends StatelessWidget {
  const SendingPartOfPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Є що додати?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Поділіться загальним враженням',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.text,
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          color: Colors.white, // Grey300
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1135BA), // Blue700
                foregroundColor: Colors.white,
                minimumSize: Size.fromHeight(48),
              ),
              onPressed: () {
                // Implement grading logic here
              },
              child: Text('Надіслати', style: TextStyle(fontSize: 16)),
            ),
          ),
        ),
      ],
    );
  }
}
