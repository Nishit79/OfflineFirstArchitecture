import '../../domain/entities/user.dart';

abstract class UserRemoteContract {
  Future<void> upload(User user);
  Future<List<User>> fetch();
}
