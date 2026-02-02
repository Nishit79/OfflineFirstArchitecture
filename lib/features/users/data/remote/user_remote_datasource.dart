import 'user_remote_contract.dart';
import '../../domain/entities/user.dart';
import '../../../../core/network/api_client.dart';

class UserRemoteDataSource implements UserRemoteContract {
  final ApiClient client;

  UserRemoteDataSource(this.client);

  @override
  Future<void> upload(User user) async {
    await client.dio.post('/users', data: {
      'id': user.id,
      'name': user.name,
    });
  }

  @override
  Future<List<User>> fetch() async {
    final res = await client.dio.get('/users');
    return (res.data as List)
        .map((e) => User(id: e['id'], name: e['name']))
        .toList();
  }
}
