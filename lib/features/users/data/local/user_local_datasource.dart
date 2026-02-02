import 'package:hive/hive.dart';
import 'package:offline_first_architecture/features/users/data/local/user_hive_model.dart';

import '../../domain/entities/user.dart';

class UserLocalDataSource {
  final Box<UserHiveModel> box;

  UserLocalDataSource(this.box);

  Stream<List<User>> watchUsers() async* {
    yield _map(box.values.toList());
    yield* box.watch().map((_) => _map(box.values.toList()));
  }

  Future<void> insert(User user) async {
    await box.put(
      user.id,
      UserHiveModel(
        id: user.id,
        name: user.name,
        isSynced: false,
        updatedAt: DateTime.now(),
      ),
    );
  }

  List<UserHiveModel> unsynced() =>
      box.values.where((e) => !e.isSynced).toList();

  Future<void> markSynced(String id) async {
    final user = box.get(id);
    if (user != null) {
      await user.save();
    }
  }

  List<User> _map(List<UserHiveModel> models) =>
      models.map((e) => User(id: e.id, name: e.name)).toList();
}
