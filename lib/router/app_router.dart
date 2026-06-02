import 'package:flutter_app/lesson_12/grading_page.dart';
import 'package:flutter_app/lesson_13/training.dart';
import 'package:flutter_app/lesson_18/homework_bloc/homework_bloc_screen.dart';
import 'package:flutter_app/lesson_18/homework_сubit/homework_cubit_screen.dart';
import 'package:flutter_app/lesson_18/state_managment_base_screen.dart';
import 'package:flutter_app/lesson_19/rate_app_screen.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/router/router_names.dart';
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
          name: RouteNames.widgets.name,
          builder: (context, state) => const WidgetsScreen(),
          routes: [
            GoRoute(
              path: 'gradingPage',
              name: RouteNames.gradingPage.name,
              builder: (context, state) => const GradingPage(),
            ),
            GoRoute(
              path: 'constraints',
              name: RouteNames.constraints.name,
              builder: (context, state) =>
                  const WidgetConstrainsTrainingScreen(),
            ),
          ],
        ),
        GoRoute(
          path: 'state-management',
          name: RouteNames.stateManagement.name,
          builder: (context, state) => const StateManagmentBaseScreen(),
          routes: [
            GoRoute(
              path: 'cubitCounter',
              name: RouteNames.cubitCounter.name,
              builder: (context, state) => const HomeworkCubitScreen(),
            ),
            GoRoute(
              path: 'blocCounter',
              name: RouteNames.blocCounter.name,
              builder: (context, state) => const HomeworkBlocScreen(),
            ),
          ],
        ),
        GoRoute(
          path: 'rateScreen',
          name: RouteNames.rateScreen.name,
          builder: (context, state) => const RateAppScreen(),
        ),
      ],
    ),
  ],
);
