import 'package:connectivity_plus/connectivity_plus.dart';

/// Monitors network connectivity state.
///
/// Wraps [Connectivity] from connectivity_plus to provide a simple
/// boolean stream of connectivity changes and a one-shot check.
///
/// ```dart
/// final service = ConnectivityServiceImpl();
/// service.onConnectivityChanged.listen((isOnline) {
///   print('Online: $isOnline');
/// });
/// ```
abstract class ConnectivityService {
  /// Emits `true` when any network interface is available, `false` otherwise.
  Stream<bool> get onConnectivityChanged;

  /// Returns `true` if a network interface is currently available.
  Future<bool> get isConnected;

  /// Releases resources held by this service.
  void dispose();
}

/// Default implementation using connectivity_plus.
class ConnectivityServiceImpl implements ConnectivityService {
  /// Creates a [ConnectivityServiceImpl] with an optional [Connectivity]
  /// instance for testing.
  ConnectivityServiceImpl({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;

  @override
  Stream<bool> get onConnectivityChanged =>
      _connectivity.onConnectivityChanged.map(
        (results) => results.any((r) => r != ConnectivityResult.none),
      );

  @override
  Future<bool> get isConnected async {
    final results = await _connectivity.checkConnectivity();
    return results.any((r) => r != ConnectivityResult.none);
  }

  @override
  void dispose() {
    // connectivity_plus does not require explicit disposal,
    // but consumers should cancel their stream subscriptions.
  }
}
