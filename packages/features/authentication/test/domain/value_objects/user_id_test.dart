import 'package:authentication/authentication.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserId', () {
    group('UserId() — generate', () {
      test('generates a non-empty UUID string', () {
        final id = UserId();
        expect(id.value, isNotEmpty);
      });

      test('generates unique IDs on each call', () {
        final a = UserId();
        final b = UserId();
        expect(a.value, isNot(equals(b.value)));
      });

      test('generated value matches UUID v4 format', () {
        final id = UserId();
        final uuidRegex = RegExp(
          r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$',
          caseSensitive: false,
        );
        expect(uuidRegex.hasMatch(id.value), isTrue);
      });
    });

    group('UserId.fromString() — reconstitute', () {
      const validUuid = '550e8400-e29b-41d4-a716-446655440000';

      test('accepts valid UUID string', () {
        final id = UserId.fromString(validUuid);
        expect(id.value, validUuid);
      });

      test('throws FormatException for non-UUID string', () {
        expect(
          () => UserId.fromString('not-a-uuid'),
          throwsA(isA<FormatException>()),
        );
      });

      test('throws FormatException for empty string', () {
        expect(
          () => UserId.fromString(''),
          throwsA(isA<FormatException>()),
        );
      });
    });

    group('equality', () {
      const uuid = '550e8400-e29b-41d4-a716-446655440000';

      test('two UserIds with same UUID are equal', () {
        final a = UserId.fromString(uuid);
        final b = UserId.fromString(uuid);
        expect(a, equals(b));
      });

      test('two UserIds with different UUIDs are not equal', () {
        final a = UserId();
        final b = UserId();
        expect(a, isNot(equals(b)));
      });

      test('hashCode matches for equal UserIds', () {
        final a = UserId.fromString(uuid);
        final b = UserId.fromString(uuid);
        expect(a.hashCode, equals(b.hashCode));
      });
    });
  });
}
