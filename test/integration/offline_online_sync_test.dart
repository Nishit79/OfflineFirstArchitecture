import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';
import 'package:offline_first_architecture/core/sync/user_sync_service.dart';
import 'package:offline_first_architecture/features/users/data/local/user_hive_model.dart';
import 'package:offline_first_architecture/features/users/data/local/user_local_datasource.dart';
import 'package:offline_first_architecture/features/users/domain/entities/user.dart';

import '../fakes/fake_user_remote_datasource.dart';

void main() {
  late Box<UserHiveModel> box;
  late UserLocalDataSource local;
  late FakeUserRemoteDataSource remote;
  late UserSyncService syncService;

  setUp(() async {
    await setUpTestHive();
    Hive.registerAdapter(UserHiveModelAdapter());

    box = await Hive.openBox<UserHiveModel>('users');
    local = UserLocalDataSource(box);
    remote = FakeUserRemoteDataSource();

    syncService = UserSyncService(
      local: local,
      remote: remote,
    );
  });

  tearDown(() async {
    await tearDownTestHive();
  });

  test('offline user is uploaded when sync runs', () async {
    // GIVEN offline user
    await local.insert(User(id: '1', name: 'OfflineUser'));

    // WHEN sync runs
    await syncService.sync();

    // THEN remote has user
    expect(remote.remoteStore.length, 1);
    expect(remote.remoteStore.first.name, 'OfflineUser');

    // AND local user is marked synced
    final users = await local.watchUsers().first;
    expect(users.length, 1);
  });
}
