import 'package:flutter/material.dart';
import 'package:flutter_app/lesson_18/state_navigation_card.dart';
import 'package:go_router/go_router.dart';

class StateManagmentBaseScreen extends StatelessWidget {
  const StateManagmentBaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('State Management'),
        backgroundColor: Colors.blue.shade100,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StateNavigationCard(
              title: 'Cubit State Management',
              description: 'Counter App with Cubit',
              onTap: () => context.go('/state-management/cubitCounter'),
            ),
            StateNavigationCard(
              title: 'Bloc State Management',
              description: 'Counter App with Bloc',
              onTap: () => context.go('/state-management/blocCounter'),
            ),
            Image.asset('assets/state_management.png', width: 300),
          ],
        ),
      ),
    );
  }
}
