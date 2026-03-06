import 'package:authentication/authentication.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Password.create()', () {
    group('valid inputs', () {
      test('accepts password meeting all rules', () {
        final result = Password.create('MyPass1!');
        expect(result.isRight(), isTrue);
        result.fold(
          (_) => fail('Expected Right but got Left'),
          (pw) => expect(pw.value, 'MyPass1!'),
        );
      });

      test('accepts exactly 8 characters when rules met', () {
        final result = Password.create('Abcdef1!');
        expect(result.isRight(), isTrue);
      });

      test('accepts long passwords', () {
        final result = Password.create('MyLongSecurePassword123');
        expect(result.isRight(), isTrue);
      });
    });

    group('invalid inputs — too short', () {
      test('rejects password with 7 characters', () {
        final result = Password.create('Abc123!');
        expect(result.isLeft(), isTrue);
        result.fold(
          (e) {
            expect(e, isA<WeakPassword>());
            expect(e.message, contains('8 characters'));
          },
          (_) => fail('Expected Left'),
        );
      });

      test('rejects empty string', () {
        final result = Password.create('');
        expect(result.isLeft(), isTrue);
        result.fold(
          (e) => expect(e, isA<WeakPassword>()),
          (_) => fail('Expected Left'),
        );
      });
    });

    group('invalid inputs — missing uppercase', () {
      test('rejects all-lowercase password', () {
        final result = Password.create('abcdefg1');
        expect(result.isLeft(), isTrue);
        result.fold(
          (e) {
            expect(e, isA<WeakPassword>());
            expect(e.message, contains('uppercase'));
          },
          (_) => fail('Expected Left'),
        );
      });
    });

    group('invalid inputs — missing lowercase', () {
      test('rejects all-uppercase password', () {
        final result = Password.create('ABCDEFG1');
        expect(result.isLeft(), isTrue);
        result.fold(
          (e) {
            expect(e, isA<WeakPassword>());
            expect(e.message, contains('lowercase'));
          },
          (_) => fail('Expected Left'),
        );
      });
    });

    group('invalid inputs — missing digit', () {
      test('rejects password without any digit', () {
        final result = Password.create('MyPassword!');
        expect(result.isLeft(), isTrue);
        result.fold(
          (e) {
            expect(e, isA<WeakPassword>());
            expect(e.message, contains('digit'));
          },
          (_) => fail('Expected Left'),
        );
      });
    });

    group('toString', () {
      test('hides raw value for security', () {
        final pw = Password.create('MyPass1!').getOrElse((_) => throw '');
        expect(pw.toString(), isNot(contains('MyPass1!')));
        expect(pw.toString(), contains('****'));
      });
    });
  });
}
