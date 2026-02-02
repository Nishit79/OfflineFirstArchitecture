import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:offline_first_architecture/core/sync/sync_manager.dart';



class MockConnectivity extends Mock implements Connectivity {}

void main() {
  late SyncManager syncManager;
  late MockConnectivity connectivity;

  setUpAll(() {
    registerFallbackValue(ConnectivityResult.none);
  });

  setUp(() {
    connectivity = MockConnectivity();
    syncManager = SyncManager(
      hiveBoxName: 'users',
      baseUrl: 'https://test.com',
      connectivity: connectivity,
    );
  });

  test('trySync does nothing when offline', () async {
    // ✅ FIXED: return LIST
    when(() => connectivity.checkConnectivity())
        .thenAnswer((_) async => [ConnectivityResult.none]);

    await syncManager.trySync();

    verify(() => connectivity.checkConnectivity()).called(1);
  });
}
