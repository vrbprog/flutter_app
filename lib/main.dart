import 'package:flutter/material.dart';
import 'package:flutter_app/lesson_18/homework_bloc/counter_bloc.dart';
import 'package:flutter_app/lesson_18/homework_сubit/counter_cubit.dart';
import 'package:flutter_app/lesson_19/rate_app_cubit.dart';
import 'package:flutter_app/router/app_router.dart';
import 'package:flutter_app/router/router_names.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const FlutterWidgetsApp());
}

class FlutterWidgetsApp extends StatelessWidget {
  const FlutterWidgetsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterCubit>(create: (context) => CounterCubit()),
        BlocProvider<CounterBloc>(create: (context) => CounterBloc()),
        BlocProvider<RateAppCubit>(create: (context) => RateAppCubit()),
      ],
      child: MaterialApp.router(routerConfig: router),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Lab'),
        backgroundColor: Colors.blue.shade100,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FeatureCard(
              title: 'Widgets',
              onTap: () => context.goNamed(RouteNames.widgets.name),
            ),
            FeatureCard(
              title: 'State management',
              onTap: () => context.goNamed(RouteNames.stateManagement.name),
            ),
            FeatureCard(
              title: 'HW-19  Rate screen',
              onTap: () async {
                final result = await context.pushNamed(
                  RouteNames.rateScreen.name,
                );

                if (result is String && context.mounted) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(_createSnackBar(context, result));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

SnackBar _createSnackBar(BuildContext context, String result) {
  return SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.star, color: Colors.white),
        const SizedBox(width: 12),
        Text(result, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 12),
        const Icon(Icons.star, color: Colors.white),
      ],
    ),
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 4),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(6)),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    dismissDirection: DismissDirection.none,
  );
}

class FeatureCard extends StatelessWidget {
  const FeatureCard({required this.title, required this.onTap, super.key});

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey.shade600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
