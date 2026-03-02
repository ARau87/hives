import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

/// Abstract base repository defining standard CRUD and sync-aware operations.
///
/// All data-layer repositories extend this class and return
/// `Either<Failure, T>` to express infrastructure errors without throwing.
///
/// ```dart
/// class HiveRepositoryImpl extends BaseRepository<Hive, String> {
///   @override
///   Future<Either<Failure, Hive>> getById(String id) async {
///     try {
///       final dto = await _localDataSource.getHive(id);
///       return Right(dto.toDomain());
///     } on Exception catch (e) {
///       return Left(CacheFailure(e.toString()));
///     }
///   }
/// }
/// ```
abstract class BaseRepository<T, ID> {
  /// Retrieves a single entity by its [id].
  Future<Either<Failure, T>> getById(ID id);

  /// Retrieves all entities of this type.
  Future<Either<Failure, List<T>>> getAll();

  /// Creates a new entity and returns it.
  Future<Either<Failure, T>> create(T entity);

  /// Updates an existing entity and returns the updated version.
  Future<Either<Failure, T>> update(T entity);

  /// Deletes the entity with the given [id].
  Future<Either<Failure, void>> delete(ID id);

  /// Returns all entities that have not yet been synced to the remote.
  Future<Either<Failure, List<T>>> getUnsyncedItems();

  /// Marks the entity with the given [id] as synced.
  Future<Either<Failure, void>> markAsSynced(ID id);
}
