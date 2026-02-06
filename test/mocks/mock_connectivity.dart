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
    registerFallbackValue(<ConnectivityResult>[ConnectivityResult.none]);
  });

  setUp(() {
    connectivity = MockConnectivity();

    when(() => connectivity.checkConnectivity())
        .thenAnswer((_) async => <ConnectivityResult>[ConnectivityResult.none]);

    when(() => connectivity.onConnectivityChanged)
        .thenAnswer(
          (_) => Stream.value(<ConnectivityResult>[ConnectivityResult.none]),
    );

    syncManager = SyncController(
      hiveBoxName: 'users',
      baseUrl: 'https://test.com'
    );
  });

  test('trySync does nothing when offline', () async {
    await syncManager.requestSync();

    verify(() => connectivity.checkConnectivity()).called(1);
  });
}
