import 'package:flutter_bloc/flutter_bloc.dart';

class RateAppCubit extends Cubit<RateAppState> {
  RateAppCubit() : super(RateAppState());

  void updateComment(String comment) {
    emit(state.copyWith(comment: comment, state: RateAppActionState.editing));
  }

  void setRating(int rating) {
    emit(state.copyWith(rating: rating, state: RateAppActionState.editing));
  }

  void onStarTapped(int starIndex) {
    setRating(starIndex);
    triggerStarPulse(starIndex);
  }

  Future<void> submitRating() async {
    emit(state.copyWith(state: RateAppActionState.loading));
    await Future<void>.delayed(const Duration(seconds: 1));

    emit(state.copyWith(state: RateAppActionState.success));
  }

  void resetRating() {
    emit(
      state.copyWith(rating: 0, state: RateAppActionState.initial, comment: ''),
    );
  }

  void triggerStarPulse(int starIndex) {
    emit(state.copyWith(animatedStarIndex: starIndex, isScaledUp: true));

    Future<void>.delayed(const Duration(milliseconds: 200), () {
      emit(state.copyWith(isScaledUp: false));
    });

    Future<void>.delayed(const Duration(milliseconds: 400), () {
      emit(state.copyWith(animatedStarIndex: null));
    });
  }
}

class RateAppState {
  RateAppState({
    this.rating = 0,
    this.state = RateAppActionState.initial,
    this.comment = '',
    this.animatedStarIndex,
    this.isScaledUp = false,
  });

  final int rating;
  final RateAppActionState state;
  final String comment;
  final int? animatedStarIndex;
  final bool isScaledUp;

  RateAppState copyWith({
    int? rating,
    RateAppActionState? state,
    String? comment,
    bool? isSubmitting,
    int? animatedStarIndex,
    bool? isScaledUp,
  }) {
    return RateAppState(
      rating: rating ?? this.rating,
      state: state ?? this.state,
      comment: comment ?? this.comment,
      animatedStarIndex: animatedStarIndex ?? this.animatedStarIndex,
      isScaledUp: isScaledUp ?? this.isScaledUp,
    );
  }
}

enum RateAppActionState { initial, editing, loading, success, error }
