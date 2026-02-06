import 'package:hive/hive.dart';
import 'package:dio/dio.dart';
import 'package:offline_first_architecture/core/sync/sync_payload.dart';

import '../../features/users/data/local/user_hive_model.dart';

Future<void> syncIsolateEntry(SyncPayload payload) async {
  // 1. Init Hive again inside isolate
  final box = await Hive.openBox<UserHiveModel>(payload.hiveBoxName);

  // 2. Init network again
  final dio = Dio(BaseOptions(baseUrl: payload.baseUrl));

  // 3. Push unsynced → server
  final unsynced = box.values.where((e) => !e.isSynced);

  for (final user in unsynced) {
    await dio.post('/users', data: {
      'id': user.id,
      'name': user.name,
    });

    await box.put(
      user.id,
      user.copyWith(isSynced: true),
    );
  }

  // 4. Pull server → local
  final res = await dio.get('/users');
  final remoteUsers = (res.data as List)
      .map((e) => UserHiveModel.fromJson(e))
      .toList();

  for (final user in remoteUsers) {
    await box.put(user.id, user);
  }
}
