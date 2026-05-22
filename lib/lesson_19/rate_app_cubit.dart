import 'package:flutter_bloc/flutter_bloc.dart';

class RateAppCubit extends Cubit<RateAppState> {
  RateAppCubit() : super(RateAppState(0, false, 'Add a comment'));

  void rateApp(int rating, String comment) {
    emit(RateAppState(rating, true, comment));
  }

  void resetRating() {
    emit(RateAppState(0, false, 'Add a comment'));
  }

  // void setStateSendingRate(bool stateSendingRate) {
  //   emit(RateAppState(state.rating, stateSendingRate, state.comment));
  // }
}

class RateAppState {
  RateAppState(this.rating, this.isSendingRate, this.comment);

  final int rating;
  final bool isSendingRate;
  final String comment;
}
