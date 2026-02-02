import 'package:offline_first_architecture/features/users/data/remote/user_remote_contract.dart';
import 'package:offline_first_architecture/features/users/domain/entities/user.dart';

class FakeUserRemoteDataSource implements UserRemoteContract {
  final List<User> remoteStore = [];

  @override
  Future<void> upload(User user) async {
    remoteStore.add(user);
  }

  @override
  Future<List<User>> fetch() async {
    return List<User>.from(remoteStore);
  }
}
