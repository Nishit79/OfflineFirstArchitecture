import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../../features/users/data/local/user_hive_model.dart';
import '../../features/users/data/local/user_local_datasource.dart';
import '../../features/users/data/remote/user_remote_datasource.dart';
import '../../features/users/data/remote/user_repository_impl.dart';
import '../../features/users/domain/repository/user_repository.dart';
import '../../features/users/presentation/bloc/user_bloc.dart';
import '../network/api_client.dart';
import '../sync/sync_controller.dart';

final sl = GetIt.instance;

Future<void> setupDI() async {
  // Hive
  final userBox = await Hive.openBox<UserHiveModel>('users');

  // Core
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => ApiClient('https://dummyjson.com/users'));

  // Data sources
  sl.registerLazySingleton(() => UserLocalDataSource(userBox));
  sl.registerLazySingleton(
        () => UserRemoteDataSource(sl<ApiClient>()),
  );

  // Sync controller
  sl.registerLazySingleton(
        () => SyncController(
      hiveBoxName: 'users',
      baseUrl: 'https://dummyjson.com'
    ),
  );

  // Repository
  sl.registerLazySingleton<UserRepository>(
        () => UserRepositoryImpl(
      sl<UserLocalDataSource>(),
      sl<SyncController>(),
    ),
  );

  // Bloc
  sl.registerFactory(() => UserBloc(sl<UserRepository>()));
}
