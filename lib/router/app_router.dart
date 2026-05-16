import 'package:flutter_app/lesson_12/grading_page.dart';
import 'package:flutter_app/lesson_13/training.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/widgets_main_screen.dart';
import 'package:go_router/go_router.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
      routes: [
        GoRoute(
          path: 'widgets',
          builder: (context, state) => const WidgetsScreen(),
          routes: [
            GoRoute(
              path: 'gradingPage',
              builder: (context, state) => const GradingPage(),
            ),
            GoRoute(
              path: 'constraints',
              builder: (context, state) => 
              const WidgetConstrainsTrainingScreen(),
            ),
          ],
        ),
      ]
    ),
  ],
);
