import '../../../../core/sync/sync_controller.dart';
import '../../domain/entities/user.dart';
import '../../domain/repository/user_repository.dart';
import '../local/user_local_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource local;
  final SyncController syncController;

  UserRepositoryImpl(this.local, this.syncController);

  @override
  Stream<List<User>> watchUsers() => local.watchUsers();

  @override
  Future<void> addUser(User user) async {
    await local.insert(user);
    await syncController.requestSync();
  }

  @override
  Future<void> sync() async {
    await syncController.requestSync();
  }
}
