import 'package:offline_first_architecture/core/sync/sync_scheduler.dart';

import 'sync_payload.dart';
import 'sync_isolate.dart';

class SyncController {
  final String hiveBoxName;
  final String baseUrl;

  SyncController({
    required this.hiveBoxName,
    required this.baseUrl,
  });

  /// Fire-and-forget sync request
  Future<void> requestSync() async {
    // Foreground immediate sync
    await syncIsolateEntry(
      SyncPayload(
        hiveBoxName: hiveBoxName,
        baseUrl: baseUrl,
      ),
    );

    // Also schedule background retry if needed
    await SyncScheduler.scheduleUserSync(
      boxName: hiveBoxName,
      baseUrl: baseUrl,
    );
  }
}
