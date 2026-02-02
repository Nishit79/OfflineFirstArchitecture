import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';
import 'package:offline_first_architecture/features/users/data/local/user_hive_model.dart';
import 'package:offline_first_architecture/features/users/data/local/user_local_datasource.dart';
import 'package:offline_first_architecture/features/users/domain/entities/user.dart';

void main() {
  late Box<UserHiveModel> box;
  late UserLocalDataSource local;

  setUp(() async {
    await setUpTestHive();
    Hive.registerAdapter(UserHiveModelAdapter());
    box = await Hive.openBox('users');
    local = UserLocalDataSource(box);
  });

  tearDown(() async {
    await tearDownTestHive();
  });

  test('insert & read user from hive', () async {
    final user = User(id: '1', name: 'Offline');

    await local.insert(user);

    final users = await local.watchUsers().first;

    expect(users.length, 1);
    expect(users.first.name, 'Offline');
  });

}
