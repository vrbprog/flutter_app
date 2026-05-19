import 'package:flutter/material.dart';

class StateNavigationCard extends StatelessWidget {
  const StateNavigationCard({
    required this.title,
    required this.description,
    required this.onTap,
    required this.counterValue,
    required this.imagePath,
    super.key,
  });

  final String title;
  final String description;
  final int counterValue;
  final VoidCallback onTap;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade50, Colors.blue.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(imagePath, height: 32),
                      const SizedBox(width: 8),
                      Text(
                        'Counter value: $counterValue',
                        style: TextStyle(color: Colors.blue.shade700),
                      ),
                    ],
                  ),
                  Icon(Icons.arrow_forward, color: Colors.blue.shade700),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
