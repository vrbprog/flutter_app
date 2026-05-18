import 'package:flutter_app/lesson_12/grading_page.dart';
import 'package:flutter_app/lesson_13/training.dart';
import 'package:flutter_app/lesson_18/homework_bloc/homework_bloc_screen.dart';
import 'package:flutter_app/lesson_18/homework_сubit/homework_cubit_screen.dart';
import 'package:flutter_app/lesson_18/state_managment_base_screen.dart';
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
        GoRoute(
          path: 'state-management',
          builder: (context, state) => const StateManagmentBaseScreen(),
          routes: [
            GoRoute(
              path: 'cubitCounter',
              builder: (context, state) => const HomeworkCubitScreen(),
            ),
            GoRoute(
              path: 'blocCounter',
              builder: (context, state) => const HomeworkBlocScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
