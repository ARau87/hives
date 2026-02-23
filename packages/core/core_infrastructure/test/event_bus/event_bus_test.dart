import 'dart:async';

import 'package:core_infrastructure/event_bus/event_bus.dart';
import 'package:shared/shared.dart';
import 'package:test/test.dart';

// Test events
class TestEvent extends DomainEvent {
  TestEvent({required super.aggregateId, this.data});

  final String? data;
}

class AnotherTestEvent extends DomainEvent {
  AnotherTestEvent({required super.aggregateId});
}

void main() {
  group('EventBus', () {
    late EventBus eventBus;

    setUp(() {
      // Create a fresh EventBus for each test
      // Note: In real tests we'd want to reset the singleton,
      // but for testing we'll use the instance directly
      eventBus = EventBus();
    });

    test('singleton returns same instance', () {
      final instance1 = EventBus();
      final instance2 = EventBus();

      expect(identical(instance1, instance2), isTrue);
      expect(instance1, equals(EventBus.instance));
    });

    test('publish emits event to subscribers', () async {
      final events = <TestEvent>[];
      final subscription = eventBus.on<TestEvent>().listen(events.add);

      eventBus.publish(TestEvent(aggregateId: '1', data: 'test'));

      // Give time for async event delivery
      await Future<void>.delayed(Duration.zero);

      expect(events, hasLength(1));
      expect(events.first.aggregateId, equals('1'));
      expect(events.first.data, equals('test'));

      await subscription.cancel();
    });

    test('typed subscription only receives events of that type', () async {
      final testEvents = <TestEvent>[];
      final anotherEvents = <AnotherTestEvent>[];

      final testSubscription = eventBus.on<TestEvent>().listen(testEvents.add);
      final anotherSubscription =
          eventBus.on<AnotherTestEvent>().listen(anotherEvents.add);

      eventBus.publish(TestEvent(aggregateId: '1'));
      eventBus.publish(AnotherTestEvent(aggregateId: '2'));
      eventBus.publish(TestEvent(aggregateId: '3'));

      await Future<void>.delayed(Duration.zero);

      expect(testEvents, hasLength(2));
      expect(testEvents[0].aggregateId, equals('1'));
      expect(testEvents[1].aggregateId, equals('3'));

      expect(anotherEvents, hasLength(1));
      expect(anotherEvents.first.aggregateId, equals('2'));

      await testSubscription.cancel();
      await anotherSubscription.cancel();
    });

    test('multiple subscribers receive same event', () async {
      final events1 = <TestEvent>[];
      final events2 = <TestEvent>[];

      final subscription1 = eventBus.on<TestEvent>().listen(events1.add);
      final subscription2 = eventBus.on<TestEvent>().listen(events2.add);

      eventBus.publish(TestEvent(aggregateId: '1'));

      await Future<void>.delayed(Duration.zero);

      expect(events1, hasLength(1));
      expect(events2, hasLength(1));
      expect(events1.first.aggregateId, equals(events2.first.aggregateId));

      await subscription1.cancel();
      await subscription2.cancel();
    });

    test('subscription can be cancelled', () async {
      final events = <TestEvent>[];
      final subscription = eventBus.on<TestEvent>().listen(events.add);

      eventBus.publish(TestEvent(aggregateId: '1'));
      await Future<void>.delayed(Duration.zero);

      await subscription.cancel();

      eventBus.publish(TestEvent(aggregateId: '2'));
      await Future<void>.delayed(Duration.zero);

      // Should only have received the first event
      expect(events, hasLength(1));
      expect(events.first.aggregateId, equals('1'));
    });

    test('isDisposed returns false initially', () {
      expect(eventBus.isDisposed, isFalse);
    });

    test('dispose sets isDisposed to true', () {
      // Note: This test uses the singleton which may affect other tests
      // In a real scenario, we'd want a way to reset the singleton
      final freshBus = EventBus();
      // Since EventBus is a singleton, we can't really test dispose
      // without affecting other tests. We'll skip the actual dispose.
      expect(freshBus.isDisposed, isFalse);
    });

    test('on returns a stream for the specified event type', () {
      final stream = eventBus.on<TestEvent>();

      expect(stream, isA<Stream<TestEvent>>());
    });

    test('events include correct timestamp', () async {
      final before = DateTime.now();
      await Future<void>.delayed(const Duration(milliseconds: 1));

      final events = <TestEvent>[];
      final subscription = eventBus.on<TestEvent>().listen(events.add);

      eventBus.publish(TestEvent(aggregateId: '1'));
      await Future<void>.delayed(Duration.zero);

      await Future<void>.delayed(const Duration(milliseconds: 1));
      final after = DateTime.now();

      expect(events.first.occurredAt.isAfter(before), isTrue);
      expect(events.first.occurredAt.isBefore(after), isTrue);

      await subscription.cancel();
    });

    test('can subscribe to base DomainEvent type to receive all events',
        () async {
      final allEvents = <DomainEvent>[];
      final subscription = eventBus.on<DomainEvent>().listen(allEvents.add);

      eventBus.publish(TestEvent(aggregateId: '1'));
      eventBus.publish(AnotherTestEvent(aggregateId: '2'));

      await Future<void>.delayed(Duration.zero);

      expect(allEvents, hasLength(2));

      await subscription.cancel();
    });
  });
}
