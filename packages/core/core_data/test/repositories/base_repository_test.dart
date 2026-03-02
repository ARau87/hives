import 'package:core_data/repositories/base_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';
import 'package:test/test.dart';

/// Concrete test implementation of [BaseRepository].
class TestEntity {
  TestEntity({required this.id, required this.name});
  final String id;
  final String name;
}

class TestRepository extends BaseRepository<TestEntity, String> {
  final Map<String, TestEntity> _store = {};
  final Set<String> _syncedIds = {};

  @override
  Future<Either<Failure, TestEntity>> getById(String id) async {
    final entity = _store[id];
    if (entity == null) {
      return Left(CacheFailure('Entity not found: $id'));
    }
    return Right(entity);
  }

  @override
  Future<Either<Failure, List<TestEntity>>> getAll() async {
    return Right(_store.values.toList());
  }

  @override
  Future<Either<Failure, TestEntity>> create(TestEntity entity) async {
    _store[entity.id] = entity;
    return Right(entity);
  }

  @override
  Future<Either<Failure, TestEntity>> update(TestEntity entity) async {
    if (!_store.containsKey(entity.id)) {
      return Left(CacheFailure('Entity not found: ${entity.id}'));
    }
    _store[entity.id] = entity;
    return Right(entity);
  }

  @override
  Future<Either<Failure, void>> delete(String id) async {
    _store.remove(id);
    return const Right(null);
  }

  @override
  Future<Either<Failure, List<TestEntity>>> getUnsyncedItems() async {
    final unsynced =
        _store.values.where((e) => !_syncedIds.contains(e.id)).toList();
    return Right(unsynced);
  }

  @override
  Future<Either<Failure, void>> markAsSynced(String id) async {
    _syncedIds.add(id);
    return const Right(null);
  }
}

void main() {
  group('BaseRepository contract via TestRepository', () {
    late TestRepository repository;

    setUp(() {
      repository = TestRepository();
    });

    test('create returns Right with entity', () async {
      final entity = TestEntity(id: '1', name: 'Test');
      final result = await repository.create(entity);

      expect(result.isRight(), isTrue);
      result.fold(
        (failure) => fail('Expected Right'),
        (value) {
          expect(value.id, equals('1'));
          expect(value.name, equals('Test'));
        },
      );
    });

    test('getById returns Right for existing entity', () async {
      await repository.create(TestEntity(id: '1', name: 'Test'));
      final result = await repository.getById('1');

      expect(result.isRight(), isTrue);
      result.fold(
        (failure) => fail('Expected Right'),
        (value) => expect(value.name, equals('Test')),
      );
    });

    test('getById returns Left for missing entity', () async {
      final result = await repository.getById('nonexistent');

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<CacheFailure>()),
        (value) => fail('Expected Left'),
      );
    });

    test('getAll returns all entities', () async {
      await repository.create(TestEntity(id: '1', name: 'First'));
      await repository.create(TestEntity(id: '2', name: 'Second'));

      final result = await repository.getAll();

      expect(result.isRight(), isTrue);
      result.fold(
        (failure) => fail('Expected Right'),
        (value) => expect(value, hasLength(2)),
      );
    });

    test('update returns Right for existing entity', () async {
      await repository.create(TestEntity(id: '1', name: 'Original'));
      final result = await repository.update(
        TestEntity(id: '1', name: 'Updated'),
      );

      expect(result.isRight(), isTrue);
      result.fold(
        (failure) => fail('Expected Right'),
        (value) => expect(value.name, equals('Updated')),
      );
    });

    test('update returns Left for missing entity', () async {
      final result = await repository.update(
        TestEntity(id: 'nonexistent', name: 'Test'),
      );

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<CacheFailure>()),
        (value) => fail('Expected Left'),
      );
    });

    test('delete removes entity', () async {
      await repository.create(TestEntity(id: '1', name: 'Test'));
      final deleteResult = await repository.delete('1');

      expect(deleteResult.isRight(), isTrue);

      final getResult = await repository.getById('1');
      expect(getResult.isLeft(), isTrue);
    });

    test('getUnsyncedItems returns unsynced entities', () async {
      await repository.create(TestEntity(id: '1', name: 'First'));
      await repository.create(TestEntity(id: '2', name: 'Second'));

      final result = await repository.getUnsyncedItems();

      expect(result.isRight(), isTrue);
      result.fold(
        (failure) => fail('Expected Right'),
        (value) => expect(value, hasLength(2)),
      );
    });

    test('markAsSynced excludes entity from unsynced list', () async {
      await repository.create(TestEntity(id: '1', name: 'First'));
      await repository.create(TestEntity(id: '2', name: 'Second'));
      await repository.markAsSynced('1');

      final result = await repository.getUnsyncedItems();

      expect(result.isRight(), isTrue);
      result.fold(
        (failure) => fail('Expected Right'),
        (value) {
          expect(value, hasLength(1));
          expect(value.first.id, equals('2'));
        },
      );
    });
  });
}
