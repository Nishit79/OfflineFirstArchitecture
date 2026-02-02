

import '../../features/users/domain/entities/user.dart';

/// Base class for all user states
abstract class UserState {
  const UserState();
}

/// Initial / loading state
class UserLoading extends UserState {
  const UserLoading();
}

/// Users successfully loaded from local DB
class UserLoaded extends UserState {
  final List<User> users;

  const UserLoaded(this.users);
}

/// Error state (network / db / unexpected)
class UserError extends UserState {
  final String message;

  const UserError(this.message);
}
