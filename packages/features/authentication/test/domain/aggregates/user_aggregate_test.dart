import 'package:authentication/authentication.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserAggregate', () {
    group('UserAggregate.create()', () {
      test('returns Right with aggregate on valid email', () {
        final result = UserAggregate.create(emailStr: 'user@example.com');
        expect(result.isRight(), isTrue);
      });

      test('aggregate has non-null id and correct email', () {
        final result = UserAggregate.create(emailStr: 'user@example.com');
        result.fold(
          (_) => fail('Expected Right'),
          (aggregate) {
            expect(aggregate.id.value, isNotEmpty);
            expect(aggregate.email.value, 'user@example.com');
          },
        );
      });

      test('raises AuthUserLoggedIn event on creation', () {
        final result = UserAggregate.create(emailStr: 'user@example.com');
        result.fold(
          (_) => fail('Expected Right'),
          (aggregate) {
            expect(aggregate.events, hasLength(1));
            expect(aggregate.events.first, isA<AuthUserLoggedIn>());

            final event = aggregate.events.first as AuthUserLoggedIn;
            expect(event.userId, equals(aggregate.id));
          },
        );
      });

      test('returns Left with InvalidCredentials on invalid email', () {
        final result = UserAggregate.create(emailStr: 'not-an-email');
        expect(result.isLeft(), isTrue);
        result.fold(
          (e) => expect(e, isA<InvalidCredentials>()),
          (_) => fail('Expected Left'),
        );
      });

      test('returns Left on empty email', () {
        final result = UserAggregate.create(emailStr: '');
        expect(result.isLeft(), isTrue);
      });

      test('each creation generates a unique UserId', () {
        final a = UserAggregate.create(emailStr: 'a@example.com')
            .getOrElse((_) => throw '');
        final b = UserAggregate.create(emailStr: 'b@example.com')
            .getOrElse((_) => throw '');
        expect(a.id, isNot(equals(b.id)));
      });
    });

    group('UserAggregate.reconstitute()', () {
      const uuid = '550e8400-e29b-41d4-a716-446655440000';
      final createdAt = DateTime(2026, 1, 1);

      test('builds aggregate from stored values without events', () {
        final aggregate = UserAggregate.reconstitute(
          id: uuid,
          email: 'user@example.com',
          createdAt: createdAt,
        );
        expect(aggregate.id.value, uuid);
        expect(aggregate.email.value, 'user@example.com');
        expect(aggregate.createdAt, createdAt);
        expect(aggregate.events, isEmpty);
      });

      test('raises no domain events', () {
        final aggregate = UserAggregate.reconstitute(
          id: uuid,
          email: 'user@example.com',
          createdAt: createdAt,
        );
        expect(aggregate.events, isEmpty);
      });

      test('throws FormatException when id is not a valid UUID', () {
        expect(
          () => UserAggregate.reconstitute(
            id: 'not-a-uuid',
            email: 'user@example.com',
            createdAt: createdAt,
          ),
          throwsA(isA<FormatException>()),
        );
      });
    });

    group('clearEvents()', () {
      test('clears events after publishing', () {
        final aggregate =
            UserAggregate.create(emailStr: 'user@example.com')
                .getOrElse((_) => throw '');
        expect(aggregate.events, hasLength(1));
        aggregate.clearEvents();
        expect(aggregate.events, isEmpty);
      });
    });
  });
}
