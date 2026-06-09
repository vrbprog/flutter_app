import 'package:flutter_app/lesson_22/data/repository/entity/user_entity.dart';
import 'package:flutter_app/lesson_22/data/repository/fake_user_repository.dart';
import 'package:flutter_app/lesson_22/presentation/cubit/user_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit(this.repository) : super(UserProfileLoading());

  final FakeUserRepository repository;

  Future<void> loadUserProfile({bool shouldFail = true}) async {
    emit(UserProfileLoading());

    UserEntity user;

    try {
      user = await repository.getUserProfile(shouldFail);
    } on CustomServerError {
      emit(UserProfileServerError());
      return;
    } on Exception catch (e) {
      print('Unknown exception: $e');
      return;
    } catch (e) {
      print('Something really unknown: $e');
      return;
    }

    emit(UserProfileLoaded(user));
  }
}
