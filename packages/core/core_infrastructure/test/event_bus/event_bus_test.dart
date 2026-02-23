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
      // Reset EventBus to a fresh state before each test
      EventBus.resetForTesting();
      eventBus = EventBus();
    });

    tearDown(() {
      // Clean up after each test
      EventBus.resetForTesting();
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
      expect(eventBus.isDisposed, isFalse);

      eventBus.dispose();

      expect(eventBus.isDisposed, isTrue);
    });

    test('publish throws StateError after dispose', () {
      eventBus.dispose();

      expect(
        () => eventBus.publish(TestEvent(aggregateId: '1')),
        throwsA(isA<StateError>().having(
          (e) => e.message,
          'message',
          contains('Cannot publish events after EventBus is disposed'),
        )),
      );
    });

    test('on throws StateError after dispose', () {
      eventBus.dispose();

      expect(
        () => eventBus.on<TestEvent>(),
        throwsA(isA<StateError>().having(
          (e) => e.message,
          'message',
          contains('Cannot subscribe to events after EventBus is disposed'),
        )),
      );
    });

    test('resetForTesting restores EventBus after dispose', () {
      eventBus.dispose();
      expect(eventBus.isDisposed, isTrue);

      EventBus.resetForTesting();
      final freshBus = EventBus();

      expect(freshBus.isDisposed, isFalse);
      // Should be able to publish again
      expect(
        () => freshBus.publish(TestEvent(aggregateId: '1')),
        returnsNormally,
      );
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
