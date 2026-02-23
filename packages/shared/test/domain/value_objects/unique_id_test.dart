import 'package:shared/shared.dart';
import 'package:test/test.dart';

void main() {
  group('UniqueId', () {
    test('should generate new UUID v4', () {
      final id = UniqueId();

      expect(id.value, isNotEmpty);
      // UUID v4 format: 8-4-4-4-12 (36 chars including hyphens)
      expect(id.value.length, equals(36));
    });

    test('should generate unique ids on each creation', () {
      final id1 = UniqueId();
      final id2 = UniqueId();
      final id3 = UniqueId();

      expect(id1.value, isNot(equals(id2.value)));
      expect(id2.value, isNot(equals(id3.value)));
      expect(id1.value, isNot(equals(id3.value)));
    });

    test('should create from existing string', () {
      const existingId = '550e8400-e29b-41d4-a716-446655440000';
      final id = UniqueId.fromString(existingId);

      expect(id.value, equals(existingId));
    });

    test('should be equal when values match', () {
      const value = '550e8400-e29b-41d4-a716-446655440000';
      final id1 = UniqueId.fromString(value);
      final id2 = UniqueId.fromString(value);

      expect(id1, equals(id2));
      expect(id1.hashCode, equals(id2.hashCode));
    });

    test('should not be equal when values differ', () {
      final id1 = UniqueId.fromString('550e8400-e29b-41d4-a716-446655440000');
      final id2 = UniqueId.fromString('550e8400-e29b-41d4-a716-446655440001');

      expect(id1, isNot(equals(id2)));
    });

    test('should return value in toString', () {
      const value = '550e8400-e29b-41d4-a716-446655440000';
      final id = UniqueId.fromString(value);

      expect(id.toString(), equals(value));
    });

    test('should be a ValueObject', () {
      final id = UniqueId();

      expect(id, isA<ValueObject>());
    });

    test('should have props containing value', () {
      const value = '550e8400-e29b-41d4-a716-446655440000';
      final id = UniqueId.fromString(value);

      expect(id.props, equals([value]));
    });

    test('should generate valid UUID v4 format', () {
      final id = UniqueId();

      // UUID v4 regex pattern
      final uuidV4Pattern = RegExp(
        r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
        caseSensitive: false,
      );

      expect(uuidV4Pattern.hasMatch(id.value), isTrue,
          reason: 'Generated UUID should match v4 format: ${id.value}');
    });

    test('should be usable as map key', () {
      final id1 = UniqueId.fromString('550e8400-e29b-41d4-a716-446655440000');
      final id2 = UniqueId.fromString('550e8400-e29b-41d4-a716-446655440000');

      final map = <UniqueId, String>{};
      map[id1] = 'value1';

      expect(map[id2], equals('value1'));
    });

    test('should be usable in set', () {
      final id1 = UniqueId.fromString('550e8400-e29b-41d4-a716-446655440000');
      final id2 = UniqueId.fromString('550e8400-e29b-41d4-a716-446655440000');
      final id3 = UniqueId.fromString('550e8400-e29b-41d4-a716-446655440001');

      final set = <UniqueId>{id1, id2, id3};

      expect(set.length, equals(2)); // id1 and id2 are equal, so only 2 unique
    });

    test('should handle many generations without collision', () {
      final ids = <String>{};

      // Generate 1000 IDs and check for uniqueness
      for (var i = 0; i < 1000; i++) {
        final id = UniqueId();
        expect(ids.add(id.value), isTrue,
            reason: 'Collision detected at iteration $i');
      }

      expect(ids.length, equals(1000));
    });

    group('fromString validation', () {
      test('should accept valid UUID v4', () {
        const validUuid = '550e8400-e29b-41d4-a716-446655440000';
        final id = UniqueId.fromString(validUuid);

        expect(id.value, equals(validUuid));
      });

      test('should accept valid UUID with uppercase', () {
        const validUuid = '550E8400-E29B-41D4-A716-446655440000';
        final id = UniqueId.fromString(validUuid);

        expect(id.value, equals(validUuid));
      });

      test('should throw FormatException for empty string', () {
        expect(
          () => UniqueId.fromString(''),
          throwsFormatException,
        );
      });

      test('should throw FormatException for invalid format', () {
        expect(
          () => UniqueId.fromString('not-a-uuid'),
          throwsFormatException,
        );
      });

      test('should throw FormatException for UUID without hyphens', () {
        expect(
          () => UniqueId.fromString('550e8400e29b41d4a716446655440000'),
          throwsFormatException,
        );
      });

      test('should throw FormatException for UUID with wrong segment length', () {
        expect(
          () => UniqueId.fromString('550e840-e29b-41d4-a716-446655440000'),
          throwsFormatException,
        );
      });

      test('should throw FormatException for UUID with invalid characters', () {
        expect(
          () => UniqueId.fromString('550e8400-e29b-41d4-a716-44665544000g'),
          throwsFormatException,
        );
      });
    });
  });
}
