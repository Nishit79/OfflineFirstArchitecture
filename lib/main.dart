import 'package:flutter/material.dart';
import 'package:offline_first_architecture/presentation/user_page.dart';
import 'package:workmanager/workmanager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/background/background_tasks.dart';
import 'core/di/injector.dart';
import 'features/users/data/local/user_hive_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Hive
  await Hive.initFlutter();
  Hive.registerAdapter(UserHiveModelAdapter());

  // DI
  await setupDI();

  // WorkManager
  Workmanager().initialize(
    callbackDispatcher
  );

  runApp(const UserPage());
}
