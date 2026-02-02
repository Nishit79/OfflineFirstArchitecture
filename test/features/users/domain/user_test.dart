import 'package:flutter_test/flutter_test.dart';
import 'package:offline_first_architecture/features/users/domain/entities/user.dart';


void main() {
  test('User should hold correct values', () {
    final user = User(id: '1', name: 'Alice');

    expect(user.id, '1');
    expect(user.name, 'Alice');
  });
}
