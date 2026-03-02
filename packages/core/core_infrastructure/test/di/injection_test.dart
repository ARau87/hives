import 'package:core_infrastructure/di/injection.dart';
import 'package:core_infrastructure/di/service_locator.dart';
import 'package:core_infrastructure/event_bus/event_bus.dart';
import 'package:shared/shared.dart';
import 'package:test/test.dart';

/// Test event for injection tests
class TestDomainEvent extends DomainEvent {
  TestDomainEvent({required super.aggregateId});
}

void main() {
  group('configureInjection', () {
    setUp(() async {
      // Reset GetIt before each test
      await getIt.reset();
      // Reset EventBus to prevent state leakage
      EventBus.resetForTesting();
    });

    tearDown(() async {
      // Clean up after each test
      await getIt.reset();
      EventBus.resetForTesting();
    });

    test('registers EventBus as singleton', () {
      configureInjection();

      expect(getIt.isRegistered<EventBus>(), isTrue);

      final eventBus1 = getIt<EventBus>();
      final eventBus2 = getIt<EventBus>();

      expect(identical(eventBus1, eventBus2), isTrue);
    });

    test('EventBus from getIt is same as EventBus.instance', () {
      configureInjection();

      final fromGetIt = getIt<EventBus>();
      final fromInstance = EventBus.instance;

      expect(identical(fromGetIt, fromInstance), isTrue);
    });

    test('can be called multiple times safely', () async {
      // First call should succeed
      configureInjection();
      expect(getIt.isRegistered<EventBus>(), isTrue);
      expect(getIt<EventBus>(), isA<EventBus>());

      // Reset and call again to verify it doesn't throw
      await getIt.reset();
      EventBus.resetForTesting();

      configureInjection();
      expect(getIt.isRegistered<EventBus>(), isTrue);
      expect(getIt<EventBus>(), isA<EventBus>());
    });

    test('EventBus from DI container is functional', () async {
      configureInjection();

      final eventBus = getIt<EventBus>();
      final events = <TestDomainEvent>[];
      final subscription = eventBus.on<TestDomainEvent>().listen(events.add);

      eventBus.publish(TestDomainEvent(aggregateId: 'test-123'));
      await Future<void>.delayed(Duration.zero);

      expect(events, hasLength(1));
      expect(events.first.aggregateId, equals('test-123'));

      await subscription.cancel();
    });
  });
}
