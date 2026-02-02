import '../../../../core/sync/sync_manager.dart';
import '../../domain/entities/user.dart';
import '../../domain/repository/user_repository.dart';
import '../local/user_local_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource local;
  final SyncManager syncManager;

  UserRepositoryImpl(this.local, this.syncManager);

  @override
  Stream<List<User>> watchUsers() => local.watchUsers();

  @override
  Future<void> addUser(User user) async {
    await local.insert(user);
    syncManager.trySync();
  }

  @override
  Future<void> sync() => syncManager.performSync();
}
