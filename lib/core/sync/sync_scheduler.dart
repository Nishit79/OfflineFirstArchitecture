import 'package:workmanager/workmanager.dart';
import '../background/background_tasks.dart';

class SyncScheduler {
  static Future<void> scheduleUserSync({
    required String boxName,
    required String baseUrl,
  }) async {
    await Workmanager().registerOneOffTask(
      'userSyncOnReconnect',
      userSyncTask,
      inputData: {
        'boxName': boxName,
        'baseUrl': baseUrl,
      },
      existingWorkPolicy: ExistingWorkPolicy.replace,
    );
  }
}
