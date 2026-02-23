import 'package:shared/shared.dart';
import 'package:test/test.dart';

// Test implementation of DomainEvent
class UserCreatedEvent extends DomainEvent {
  UserCreatedEvent({
    required super.aggregateId,
    required this.email,
    super.occurredAt,
  });

  final String email;
}

void main() {
  group('DomainEvent', () {
    test('should create event with aggregateId', () {
      final event = UserCreatedEvent(
        aggregateId: 'user-123',
        email: 'test@example.com',
      );

      expect(event.aggregateId, equals('user-123'));
    });

    test('should auto-generate occurredAt if not provided', () {
      final before = DateTime.now();
      final event = UserCreatedEvent(
        aggregateId: 'user-123',
        email: 'test@example.com',
      );
      final after = DateTime.now();

      expect(event.occurredAt.isAfter(before.subtract(Duration(seconds: 1))),
          isTrue);
      expect(
          event.occurredAt.isBefore(after.add(Duration(seconds: 1))), isTrue);
    });

    test('should use provided occurredAt', () {
      final timestamp = DateTime(2026, 1, 15, 10, 30);
      final event = UserCreatedEvent(
        aggregateId: 'user-123',
        email: 'test@example.com',
        occurredAt: timestamp,
      );

      expect(event.occurredAt, equals(timestamp));
    });

    test('should store additional event data', () {
      final event = UserCreatedEvent(
        aggregateId: 'user-123',
        email: 'test@example.com',
      );

      expect(event.email, equals('test@example.com'));
    });

    test('should be equal when aggregateId and occurredAt match', () {
      final timestamp = DateTime(2026, 1, 15, 10, 30);
      final event1 = UserCreatedEvent(
        aggregateId: 'user-123',
        email: 'test1@example.com',
        occurredAt: timestamp,
      );
      final event2 = UserCreatedEvent(
        aggregateId: 'user-123',
        email: 'test2@example.com', // Different email
        occurredAt: timestamp,
      );

      expect(event1, equals(event2));
      expect(event1.hashCode, equals(event2.hashCode));
    });

    test('should not be equal when aggregateId differs', () {
      final timestamp = DateTime(2026, 1, 15, 10, 30);
      final event1 = UserCreatedEvent(
        aggregateId: 'user-123',
        email: 'test@example.com',
        occurredAt: timestamp,
      );
      final event2 = UserCreatedEvent(
        aggregateId: 'user-456',
        email: 'test@example.com',
        occurredAt: timestamp,
      );

      expect(event1, isNot(equals(event2)));
    });

    test('should not be equal when occurredAt differs', () {
      final event1 = UserCreatedEvent(
        aggregateId: 'user-123',
        email: 'test@example.com',
        occurredAt: DateTime(2026, 1, 15, 10, 30),
      );
      final event2 = UserCreatedEvent(
        aggregateId: 'user-123',
        email: 'test@example.com',
        occurredAt: DateTime(2026, 1, 15, 10, 31),
      );

      expect(event1, isNot(equals(event2)));
    });

    test('should return string representation', () {
      final timestamp = DateTime(2026, 1, 15, 10, 30);
      final event = UserCreatedEvent(
        aggregateId: 'user-123',
        email: 'test@example.com',
        occurredAt: timestamp,
      );

      expect(
        event.toString(),
        equals('UserCreatedEvent(aggregateId: user-123, occurredAt: $timestamp)'),
      );
    });

    test('should be equal to itself', () {
      final event = UserCreatedEvent(
        aggregateId: 'user-123',
        email: 'test@example.com',
      );

      expect(event, equals(event));
    });

    test('should not be equal to different type', () {
      final event = UserCreatedEvent(
        aggregateId: 'user-123',
        email: 'test@example.com',
      );

      expect(event, isNot(equals('user-123')));
    });
  });
}
