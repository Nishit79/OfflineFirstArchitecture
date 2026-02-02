import 'package:mocktail/mocktail.dart';
import 'package:offline_first_architecture/core/sync/sync_manager.dart';
import 'package:offline_first_architecture/features/users/data/local/user_local_datasource.dart';

class MockLocalDS extends Mock implements UserLocalDataSource {}
class MockSyncManager extends Mock implements SyncManager {}
