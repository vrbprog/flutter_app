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

class GradingPage extends StatefulWidget {
  const GradingPage({super.key});

  @override
  State<GradingPage> createState() => _GradingPageState();
}

class _GradingPageState extends State<GradingPage> {
  bool _isSettingRating = false;
  bool get isEnabledSendingData => _isSettingRating;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        //padding: EdgeInsets.all(16),
        child: Column(
          children: [
            RatingStars(
              onDataChanged: (rating) {
                setState(() {
                  _isSettingRating = rating > 0;
                });
              },
            ),
            DepartmensRatings(),
            SendingPartOfPage(isEnabled: isEnabledSendingData),
          ],
        ),
      ),
    );
  }
}

class SendingPartOfPage extends StatelessWidget {
  const SendingPartOfPage({super.key, this.isEnabled = false});

  final bool isEnabled;

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
          padding: EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 32),
          color: Colors.white, // Grey300
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isEnabled
                  ? () {
                      // Implement grading logic here
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1135BA), // Blue700
                foregroundColor: Colors.white,
                minimumSize: Size.fromHeight(48),
              ),
              child: Text('Надіслати', style: TextStyle(fontSize: 16)),
            ),
          ),
        ),
      ],
    );
  }
}

class DepartmensRatings extends StatefulWidget {
  const DepartmensRatings({super.key});

  @override
  State<DepartmensRatings> createState() => _DepartmensRatingsState();
}

class _DepartmensRatingsState extends State<DepartmensRatings> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        SizedBox(height: 4),
        const Text(
          'Яку оціночку поставите відділам?',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        CardDepartmentRating(department: 'Випічка'),
        CardDepartmentRating(department: 'Лавка традицій'),
      ],
    );
  }
}

class RatingStars extends StatefulWidget {
  const RatingStars({required this.onDataChanged, super.key});

  final ValueChanged<int> onDataChanged;

  @override
  State<RatingStars> createState() => _RatingStarsState();
}

class _RatingStarsState extends State<RatingStars> {
  int _selectedRating = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 32, bottom: 16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .1),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            spacing: 8,
            children: [
              Image.asset('assets/leading-icon.png', width: 24, height: 24),
              const Text(
                'Оцінка візиту до магазину',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              final isSelected = index < _selectedRating;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedRating = index + 1;
                    widget.onDataChanged(_selectedRating);
                  });
                },
                child: Image.asset(
                  isSelected ? 'assets/rating.png' : 'assets/rating_board.png',
                  width: 48,
                  height: 48,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class CardDepartmentRating extends StatefulWidget {
  const CardDepartmentRating({required this.department, super.key});

  final String department;

  @override
  State<CardDepartmentRating> createState() => _CardDepartmentRatingState();
}

class _CardDepartmentRatingState extends State<CardDepartmentRating> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .1),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.department,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          RatingType(type: 'Обслуговування'),
          RatingType(type: 'Асортимент'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Розкажіть докладніше',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              keyboardType: TextInputType.text,
            ),
          ),
        ],
      ),
    );
  }
}

class RatingType extends StatefulWidget {
  const RatingType({required this.type, super.key});

  final String type;

  @override
  State<RatingType> createState() => _RatingTypeState();
}

class _RatingTypeState extends State<RatingType> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFE0E5F1)),
        borderRadius: BorderRadius.circular(12),
        color: Color(0xFFF6F8FD),
      ),
      child: Row(
        spacing: 8,
        children: [
          //Image.asset('assets/leading-icon.png', width: 16, height: 16),
          Row(children: [Text(widget.type, style: TextStyle(fontSize: 16))]),
        ],
      ),
    );
  }
}
