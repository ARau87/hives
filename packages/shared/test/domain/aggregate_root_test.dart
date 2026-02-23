import 'package:shared/shared.dart';
import 'package:test/test.dart';

// Test implementation of AggregateRoot
class TestAggregate extends AggregateRoot<String> {
  TestAggregate({required super.id});

  void doSomething() {
    addEvent(TestEvent(aggregateId: id));
  }
}

// Test implementation of DomainEvent
class TestEvent extends DomainEvent {
  TestEvent({required super.aggregateId});
}

void main() {
  group('AggregateRoot', () {
    test('should create aggregate with id', () {
      final aggregate = TestAggregate(id: 'test-id');

      expect(aggregate.id, equals('test-id'));
    });

    test('should start with empty events list', () {
      final aggregate = TestAggregate(id: 'test-id');

      expect(aggregate.events, isEmpty);
    });

    test('should add domain event', () {
      final aggregate = TestAggregate(id: 'test-id');

      aggregate.doSomething();

      expect(aggregate.events, hasLength(1));
      expect(aggregate.events.first, isA<TestEvent>());
    });

    test('should return unmodifiable events list', () {
      final aggregate = TestAggregate(id: 'test-id');
      aggregate.doSomething();

      expect(
        () => aggregate.events.add(TestEvent(aggregateId: 'another')),
        throwsUnsupportedError,
      );
    });

    test('should clear events', () {
      final aggregate = TestAggregate(id: 'test-id');
      aggregate.doSomething();
      aggregate.doSomething();

      expect(aggregate.events, hasLength(2));

      aggregate.clearEvents();

      expect(aggregate.events, isEmpty);
    });

    test('should be equal when ids match', () {
      final aggregate1 = TestAggregate(id: 'same-id');
      final aggregate2 = TestAggregate(id: 'same-id');

      expect(aggregate1, equals(aggregate2));
      expect(aggregate1.hashCode, equals(aggregate2.hashCode));
    });

    test('should not be equal when ids differ', () {
      final aggregate1 = TestAggregate(id: 'id-1');
      final aggregate2 = TestAggregate(id: 'id-2');

      expect(aggregate1, isNot(equals(aggregate2)));
    });

    test('should return string representation', () {
      final aggregate = TestAggregate(id: 'test-id');

      expect(aggregate.toString(), equals('TestAggregate(id: test-id)'));
    });

    test('should be equal to itself', () {
      final aggregate = TestAggregate(id: 'test-id');

      expect(aggregate, equals(aggregate));
    });

    test('should not be equal to different type', () {
      final aggregate = TestAggregate(id: 'test-id');

      expect(aggregate, isNot(equals('test-id')));
    });
  });
}
