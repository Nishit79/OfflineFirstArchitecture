
import '../../domain/entities/user.dart';

/// Base class for all user-related events
abstract class UserEvent {
  const UserEvent();
}

/// Triggered when UI starts listening to users
class LoadUsers extends UserEvent {
  const LoadUsers();
}

/// Add a new user (offline-first)
class AddUserEvent extends UserEvent {
  final User user;

  const AddUserEvent(this.user);
}

/// Force manual sync (optional but very useful)
class SyncUsersEvent extends UserEvent {
  const SyncUsersEvent();
}
