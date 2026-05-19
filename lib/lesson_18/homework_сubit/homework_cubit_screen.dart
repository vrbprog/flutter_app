import 'package:flutter/material.dart';
import 'package:flutter_app/lesson_18/homework_сubit/counter_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeworkCubitScreen extends StatelessWidget {
  const HomeworkCubitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const CubitCounter(title: 'Cubit Counter App'));
  }
}

class CubitCounter extends StatefulWidget {
  const CubitCounter({required this.title, super.key});

  final String title;
  final double _fontSize = 32.0;

  @override
  State<CubitCounter> createState() => _CubitCounterState();
}

class _CubitCounterState extends State<CubitCounter> {
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
            Image.asset('assets/flutter_cubit_full.png', width: 200),
            const SizedBox(height: 16),
            const Text('You have pushed the buttons this many times:'),
            const SizedBox(height: 16),
            BlocBuilder<CounterCubit, int>(
              builder: (context, state) {
                return AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: TextStyle(
                    fontSize: widget._fontSize + state.toDouble(),
                    color: Colors.blue,
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
            onPressed: () => BlocProvider.of<CounterCubit>(context).increment(),
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'decrement',
            onPressed: () => BlocProvider.of<CounterCubit>(context).decrement(),
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
