import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

typedef ConnectivityCallback = void Function();

class NetworkConnectivityService {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _subscription;

  bool _wasOffline = false;

  void startListening(ConnectivityCallback onConnected) {
    _subscription = _connectivity.onConnectivityChanged.listen((result) {
      final isOffline = result == ConnectivityResult.none;

      // Detect OFFLINE ➜ ONLINE transition
      if (_wasOffline && !isOffline) {
        onConnected();
      }

      _wasOffline = isOffline;
    }) as StreamSubscription<ConnectivityResult>?;
  }

  void dispose() {
    _subscription?.cancel();
  }
}
