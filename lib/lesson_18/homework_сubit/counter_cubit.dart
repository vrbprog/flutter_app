import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(10);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}

// class CounterState {
//   CounterState({required this.counter});
//   final int counter;
// }
