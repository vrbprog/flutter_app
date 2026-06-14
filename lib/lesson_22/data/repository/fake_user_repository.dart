import 'package:flutter_app/lesson_22/data/repository/entity/user_entity.dart';

class FakeUserRepository {
  Future<UserEntity> getUserProfile(bool shouldFail) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    if (shouldFail) {
      try {
        throw Exception('Server is temporarily unavailable');
      } on Exception catch (error) {
        if (error.toString().contains('Server is temporarily unavailable')) {
          throw CustomServerError('Server is temporarily unavailable');
        } else {
          rethrow;
        }
      }
    }
    return UserEntity(id: '1', name: 'Test User');
  }
}

class CustomServerError implements Exception {
  CustomServerError(this.message);

  final String message;

  @override
  String toString() => 'CustomServerError: $message';
}
