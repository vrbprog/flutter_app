import 'package:flutter/material.dart';
import 'package:flutter_app/lesson_18/homework_bloc/counter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeworkBlocScreen extends StatelessWidget {
  const HomeworkBlocScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const BlocCounter(title: 'Bloc Counter App'));
  }
}

class BlocCounter extends StatefulWidget {
  const BlocCounter({required this.title, super.key});

  final String title;
  final double _fontSize = 32.0;

  @override
  State<BlocCounter> createState() => _BlocCounterState();
}

class _BlocCounterState extends State<BlocCounter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/bloc.png', width: 200),
            const SizedBox(height: 16),
            const Text('You have pushed the buttons this many times:'),
            const SizedBox(height: 16),
            BlocBuilder<CounterBloc, int>(
              builder: (context, state) {
                return AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: TextStyle(
                    fontSize: widget._fontSize + state.toDouble(),
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                  child: Text('$state'),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'increment',
            onPressed: () => context.read<CounterBloc>().add(IncrementEvent()),
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'decrement',
            onPressed: () => context.read<CounterBloc>().add(DecrementEvent()),
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
