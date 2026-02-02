import '../../features/users/data/local/user_local_datasource.dart';
import '../../features/users/data/local/user_hive_model.dart';
import '../../features/users/domain/entities/user.dart';
import '../../features/users/data/remote/user_remote_contract.dart';

class UserSyncService {
  final UserLocalDataSource local;
  final UserRemoteContract remote;

  UserSyncService({
    required this.local,
    required this.remote,
  });

  Future<void> sync() async {
    // push local → remote
    final List<UserHiveModel> unsynced = local.unsynced();

    for (final user in unsynced) {
      await remote.upload(
        User(id: user.id, name: user.name),
      );
      await local.markSynced(user.id);
    }

    // pull remote → local
    final remoteUsers = await remote.fetch();
    for (final user in remoteUsers) {
      await local.insert(user);
    }
  }
}
