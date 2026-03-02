import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core_data/network/connectivity_service.dart';
import 'package:flutter_test/flutter_test.dart';

/// Fake [Connectivity] for testing.
class FakeConnectivity implements Connectivity {
  final StreamController<List<ConnectivityResult>> _controller =
      StreamController<List<ConnectivityResult>>.broadcast();

  List<ConnectivityResult> _currentResult = [ConnectivityResult.wifi];

  void emitConnectivity(List<ConnectivityResult> results) {
    _currentResult = results;
    _controller.add(results);
  }

  @override
  Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      _controller.stream;

  @override
  Future<List<ConnectivityResult>> checkConnectivity() async {
    return _currentResult;
  }

  void dispose() {
    _controller.close();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  group('ConnectivityServiceImpl', () {
    late FakeConnectivity fakeConnectivity;
    late ConnectivityServiceImpl service;

    setUp(() {
      fakeConnectivity = FakeConnectivity();
      service = ConnectivityServiceImpl(connectivity: fakeConnectivity);
    });

    tearDown(() {
      fakeConnectivity.dispose();
      service.dispose();
    });

    test('isConnected returns true when wifi is available', () async {
      fakeConnectivity._currentResult = [ConnectivityResult.wifi];

      final connected = await service.isConnected;
      expect(connected, isTrue);
    });

    test('isConnected returns true when cellular is available', () async {
      fakeConnectivity._currentResult = [ConnectivityResult.mobile];

      final connected = await service.isConnected;
      expect(connected, isTrue);
    });

    test('isConnected returns false when no connectivity', () async {
      fakeConnectivity._currentResult = [ConnectivityResult.none];

      final connected = await service.isConnected;
      expect(connected, isFalse);
    });

    test('onConnectivityChanged emits true when connected', () async {
      final results = <bool>[];
      final subscription =
          service.onConnectivityChanged.listen(results.add);

      fakeConnectivity.emitConnectivity([ConnectivityResult.wifi]);
      await Future<void>.delayed(Duration.zero);

      expect(results, [true]);

      await subscription.cancel();
    });

    test('onConnectivityChanged emits false when disconnected', () async {
      final results = <bool>[];
      final subscription =
          service.onConnectivityChanged.listen(results.add);

      fakeConnectivity.emitConnectivity([ConnectivityResult.none]);
      await Future<void>.delayed(Duration.zero);

      expect(results, [false]);

      await subscription.cancel();
    });

    test('onConnectivityChanged handles multiple transitions', () async {
      final results = <bool>[];
      final subscription =
          service.onConnectivityChanged.listen(results.add);

      fakeConnectivity.emitConnectivity([ConnectivityResult.wifi]);
      await Future<void>.delayed(Duration.zero);

      fakeConnectivity.emitConnectivity([ConnectivityResult.none]);
      await Future<void>.delayed(Duration.zero);

      fakeConnectivity.emitConnectivity([ConnectivityResult.mobile]);
      await Future<void>.delayed(Duration.zero);

      expect(results, [true, false, true]);

      await subscription.cancel();
    });

    test('isConnected returns true with multiple interfaces', () async {
      fakeConnectivity._currentResult = [
        ConnectivityResult.wifi,
        ConnectivityResult.mobile,
      ];

      final connected = await service.isConnected;
      expect(connected, isTrue);
    });
  });
}
