import '../entities/user.dart';

abstract class UserRepository {
  Stream<List<User>> watchUsers();
  Future<void> addUser(User user);
  Future<void> sync();
}
