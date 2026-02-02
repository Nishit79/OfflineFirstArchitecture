import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/users/domain/repository/user_repository.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repository;
  StreamSubscription? _subscription;

  UserBloc(this.repository) : super(const UserLoading()) {
    on<LoadUsers>(_onLoadUsers);
    on<AddUserEvent>(_onAddUser);
    on<SyncUsersEvent>(_onSyncUsers);
  }

  void _onLoadUsers(
      LoadUsers event,
      Emitter<UserState> emit,
      ) {
    _subscription?.cancel();

    _subscription = repository.watchUsers().listen(
          (users) => emit(UserLoaded(users)),
      onError: (e) => emit(UserError(e.toString())),
    );
  }

  Future<void> _onAddUser(
      AddUserEvent event,
      Emitter<UserState> emit,
      ) async {
    await repository.addUser(event.user);
  }

  Future<void> _onSyncUsers(
      SyncUsersEvent event,
      Emitter<UserState> emit,
      ) async {
    try {
      await repository.sync();
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
