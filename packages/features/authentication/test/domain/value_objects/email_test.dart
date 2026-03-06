import 'package:authentication/authentication.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Email.create()', () {
    group('valid inputs', () {
      test('accepts standard email', () {
        final result = Email.create('user@example.com');
        expect(result.isRight(), isTrue);
        result.fold(
          (_) => fail('Expected Right but got Left'),
          (email) => expect(email.value, 'user@example.com'),
        );
      });

      test('trims surrounding whitespace', () {
        final result = Email.create('  user@example.com  ');
        expect(result.isRight(), isTrue);
        result.fold(
          (_) => fail('Expected Right but got Left'),
          (email) => expect(email.value, 'user@example.com'),
        );
      });

      test('accepts email with subdomain', () {
        final result = Email.create('user@mail.example.co.uk');
        expect(result.isRight(), isTrue);
      });

      test('accepts email with plus addressing', () {
        final result = Email.create('user+tag@example.com');
        expect(result.isRight(), isTrue);
      });
    });

    group('invalid inputs', () {
      test('rejects empty string', () {
        final result = Email.create('');
        expect(result.isLeft(), isTrue);
        result.fold(
          (e) => expect(e, isA<InvalidCredentials>()),
          (_) => fail('Expected Left but got Right'),
        );
      });

      test('rejects whitespace-only string', () {
        final result = Email.create('   ');
        expect(result.isLeft(), isTrue);
      });

      test('rejects email without @', () {
        final result = Email.create('userexample.com');
        expect(result.isLeft(), isTrue);
      });

      test('rejects email without domain', () {
        final result = Email.create('user@');
        expect(result.isLeft(), isTrue);
      });

      test('rejects email without TLD', () {
        final result = Email.create('user@example');
        expect(result.isLeft(), isTrue);
      });

      test('rejects email without local part', () {
        final result = Email.create('@example.com');
        expect(result.isLeft(), isTrue);
      });

      test('returns InvalidCredentials on failure', () {
        final result = Email.create('not-an-email');
        result.fold(
          (e) => expect(e, isA<InvalidCredentials>()),
          (_) => fail('Expected Left'),
        );
      });
    });

    group('equality', () {
      test('two Emails with same value are equal', () {
        final a = Email.create('user@example.com').getOrElse((_) => throw '');
        final b = Email.create('user@example.com').getOrElse((_) => throw '');
        expect(a, equals(b));
      });

      test('two Emails with different values are not equal', () {
        final a = Email.create('a@example.com').getOrElse((_) => throw '');
        final b = Email.create('b@example.com').getOrElse((_) => throw '');
        expect(a, isNot(equals(b)));
      });
    });
  });
}
