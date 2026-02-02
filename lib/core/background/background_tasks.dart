import 'package:workmanager/workmanager.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../sync/sync_payload.dart';
import '../sync/sync_isolate.dart';

const String userSyncTask = 'userSyncTask';

@pragma('vm:entry-point') // VERY IMPORTANT
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case userSyncTask:
        final connectivity = Connectivity();
        final status = await connectivity.checkConnectivity();

        if (status.contains(ConnectivityResult.none)) {
          return true; // no internet → exit gracefully
        }

        final payload = SyncPayload(
          hiveBoxName: inputData!['boxName'],
          baseUrl: inputData['baseUrl'],
        );

        await syncIsolateEntry(payload);
        return true;

      default:
        return false;
    }
  });
}
