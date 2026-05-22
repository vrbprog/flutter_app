import 'package:flutter_bloc/flutter_bloc.dart';

class RateAppCubit extends Cubit<RateAppState> {
  RateAppCubit() : super(RateAppState());

  void rateApp(int rating, String comment) {
    emit(RateAppState(rating: rating, isSendingRate: true, comment: comment));
  }

  void resetRating() {
    emit(RateAppState(rating: 0, isSendingRate: false, comment: ''));
  }
}

class RateAppState {
  RateAppState({
    this.rating = 0,
    this.isSendingRate = false,
    this.comment = '',
  });

  final int rating;
  final bool isSendingRate;
  final String comment;
}
