import 'package:shared/shared.dart';
import 'package:test/test.dart';

// Test implementation of Entity
class TestEntity extends Entity<String> {
  TestEntity({required super.id, required this.name});

  final String name;
}

void main() {
  group('Entity', () {
    test('should create entity with id', () {
      final entity = TestEntity(id: 'test-id', name: 'Test');

      expect(entity.id, equals('test-id'));
    });

    test('should store additional properties', () {
      final entity = TestEntity(id: 'test-id', name: 'Test Name');

      expect(entity.name, equals('Test Name'));
    });

    test('should be equal when ids match regardless of other properties', () {
      final entity1 = TestEntity(id: 'same-id', name: 'Name 1');
      final entity2 = TestEntity(id: 'same-id', name: 'Name 2');

      expect(entity1, equals(entity2));
      expect(entity1.hashCode, equals(entity2.hashCode));
    });

    test('should not be equal when ids differ', () {
      final entity1 = TestEntity(id: 'id-1', name: 'Same Name');
      final entity2 = TestEntity(id: 'id-2', name: 'Same Name');

      expect(entity1, isNot(equals(entity2)));
    });

    test('should return string representation', () {
      final entity = TestEntity(id: 'test-id', name: 'Test');

      expect(entity.toString(), equals('TestEntity(id: test-id)'));
    });

    test('should be equal to itself', () {
      final entity = TestEntity(id: 'test-id', name: 'Test');

      expect(entity, equals(entity));
    });

    test('should not be equal to different type', () {
      final entity = TestEntity(id: 'test-id', name: 'Test');

      expect(entity, isNot(equals('test-id')));
    });

    test('should have consistent hashCode', () {
      final entity1 = TestEntity(id: 'test-id', name: 'Name 1');
      final entity2 = TestEntity(id: 'test-id', name: 'Name 2');

      // Same id should produce same hashCode
      expect(entity1.hashCode, equals(entity2.hashCode));

      // Create it again to verify consistency
      final entity3 = TestEntity(id: 'test-id', name: 'Name 1');
      expect(entity1.hashCode, equals(entity3.hashCode));
    });
  });
}
