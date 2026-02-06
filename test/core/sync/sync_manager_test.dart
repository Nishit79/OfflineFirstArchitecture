import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:offline_first_architecture/core/sync/sync_controller.dart';

class MockConnectivity extends Mock implements Connectivity {}

void main() {
  late SyncController syncManager;
  late MockConnectivity connectivity;

  setUpAll(() {
    registerFallbackValue(ConnectivityResult.none);
  });

  setUp(() {
    connectivity = MockConnectivity();
    syncManager = SyncController(
      hiveBoxName: 'users',
      baseUrl: 'https://test.com'
    );
  });

  test('trySync does nothing when offline', () async {
    // ✅ FIXED: return LIST
    when(() => connectivity.checkConnectivity())
        .thenAnswer((_) async => [ConnectivityResult.none]);

    await syncManager.requestSync();

    verify(() => connectivity.checkConnectivity()).called(1);
  });
}
