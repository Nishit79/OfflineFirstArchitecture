import 'dart:isolate';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:offline_first_architecture/core/sync/sync_isolate.dart';
import 'package:offline_first_architecture/core/sync/sync_payload.dart';

class SyncManager {
  final String hiveBoxName;
  final String baseUrl;
  final Connectivity connectivity;

  SyncManager({
    required this.hiveBoxName,
    required this.baseUrl,
    required this.connectivity,
  });

  Future<void> trySync() async {
    final status = await connectivity.checkConnectivity();
    if (status != ConnectivityResult.none) {
      await performSync();
    }
  }

  Future<void> performSync() async {
    await Isolate.run(
          () => syncIsolateEntry(
        SyncPayload(
          hiveBoxName: hiveBoxName,
          baseUrl: baseUrl,
        ),
      ),
    );
  }
}
