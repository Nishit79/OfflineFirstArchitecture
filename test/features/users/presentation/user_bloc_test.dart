import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:offline_first_architecture/features/users/domain/entities/user.dart';
import 'package:offline_first_architecture/features/users/domain/repository/user_repository.dart';
import 'package:offline_first_architecture/presentation/bloc/user_bloc.dart';
import 'package:offline_first_architecture/presentation/bloc/user_event.dart';
import 'package:offline_first_architecture/presentation/bloc/user_state.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late UserBloc bloc;
  late MockUserRepository repository;

  setUp(() {
    repository = MockUserRepository();
    bloc = UserBloc(repository);
  });

  blocTest<UserBloc, UserState>(
    'emits UserLoaded when users stream emits data',
    build: () {
      when(() => repository.watchUsers())
          .thenAnswer((_) => Stream.value([User(id: '1', name: 'Test')]));
      return bloc;
    },
    act: (bloc) => bloc.add(const LoadUsers()),
    expect: () => [
      UserLoaded([User(id: '1', name: 'Test')]),
    ],
  );
}
