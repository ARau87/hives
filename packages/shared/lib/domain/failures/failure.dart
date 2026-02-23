/// Sealed class hierarchy for functional error handling.
///
/// [Failure] provides a type-safe way to represent errors in a functional
/// programming style using `Either<Failure, T>` from packages like fpdart.
/// Being a sealed class, it enables exhaustive pattern matching in switch
/// expressions, ensuring all failure cases are handled at compile time.
///
/// ## Usage with Either
///
/// ```dart
/// Future<Either<Failure, User>> getUser(String id) async {
///   try {
///     final user = await api.fetchUser(id);
///     return Right(user);
///   } on SocketException {
///     return Left(NetworkFailure('No internet connection'));
///   } catch (e) {
///     return Left(UnexpectedFailure(e.toString()));
///   }
/// }
/// ```
///
/// ## Pattern Matching
///
/// ```dart
/// final result = await getUser('123');
/// final message = switch (result) {
///   Left(value: ServerFailure(:final message)) => 'Server error: $message',
///   Left(value: NetworkFailure(:final message)) => 'Network error: $message',
///   Left(value: CacheFailure(:final message)) => 'Cache error: $message',
///   Left(value: ValidationFailure(:final errors)) => 'Invalid: ${errors.join(', ')}',
///   Left(value: UnexpectedFailure(:final message)) => 'Error: $message',
///   Right(:final value) => 'Success: ${value.name}',
/// };
/// ```
sealed class Failure {
  /// Creates a failure with an optional message.
  const Failure([this.message]);

  /// A human-readable message describing the failure.
  ///
  /// May be null if no additional context is needed beyond the failure type.
  final String? message;

  @override
  String toString() => '$runtimeType${message != null ? ': $message' : ''}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => Object.hash(runtimeType, message);
}

/// Represents a failure from a remote server or API.
///
/// Use this when the server returns an error response, times out,
/// or is otherwise unavailable.
///
/// Example:
/// ```dart
/// // API returned 500 Internal Server Error
/// return Left(ServerFailure('Server returned status 500'));
///
/// // API timeout
/// return Left(ServerFailure('Request timed out'));
/// ```
final class ServerFailure extends Failure {
  /// Creates a server failure with an optional message.
  const ServerFailure([super.message]);

  /// Creates a server failure with an HTTP status code.
  ServerFailure.withStatusCode(int statusCode, [String? details])
      : super('HTTP $statusCode${details != null ? ': $details' : ''}');
}

/// Represents a failure when reading from or writing to local cache/storage.
///
/// Use this when local database operations fail, cached data is corrupted,
/// or storage quota is exceeded.
///
/// Example:
/// ```dart
/// // Database read failed
/// return Left(CacheFailure('Failed to read from local database'));
///
/// // Cache expired
/// return Left(CacheFailure('Cached data has expired'));
/// ```
final class CacheFailure extends Failure {
  /// Creates a cache failure with an optional message.
  const CacheFailure([super.message]);
}

/// Represents a failure due to network connectivity issues.
///
/// Use this when the device has no internet connection, DNS resolution fails,
/// or the connection is otherwise unavailable (distinct from server errors).
///
/// Example:
/// ```dart
/// // No internet
/// return Left(NetworkFailure('No internet connection'));
///
/// // DNS resolution failed
/// return Left(NetworkFailure('Could not resolve host'));
/// ```
final class NetworkFailure extends Failure {
  /// Creates a network failure with an optional message.
  const NetworkFailure([super.message]);
}

/// Represents a failure due to validation errors.
///
/// Use this when input data fails validation rules. The [errors] list
/// contains all validation error messages.
///
/// Example:
/// ```dart
/// final errors = <String>[];
/// if (email.isEmpty) errors.add('Email is required');
/// if (!email.contains('@')) errors.add('Invalid email format');
/// if (errors.isNotEmpty) {
///   return Left(ValidationFailure(errors));
/// }
/// ```
final class ValidationFailure extends Failure {
  /// Creates a validation failure with a list of error messages.
  ///
  /// The [errors] list is copied and stored as unmodifiable to ensure
  /// immutability of this failure instance.
  ValidationFailure(List<String> errors)
      : errors = List.unmodifiable(errors),
        super(null);

  /// The list of validation error messages (unmodifiable).
  final List<String> errors;

  @override
  String get message => errors.join(', ');

  @override
  String toString() => 'ValidationFailure: ${errors.join(', ')}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ValidationFailure &&
          _listEquals(errors, other.errors);

  @override
  int get hashCode => Object.hashAll(errors);

  /// Helper to compare lists for equality.
  static bool _listEquals<T>(List<T> a, List<T> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}

/// Represents an unexpected failure that doesn't fit other categories.
///
/// Use this as a catch-all for unhandled exceptions. It's recommended
/// to log the original exception details for debugging.
///
/// Example:
/// ```dart
/// try {
///   // some operation
/// } catch (e, stackTrace) {
///   logger.error('Unexpected error', e, stackTrace);
///   return Left(UnexpectedFailure(e.toString()));
/// }
/// ```
final class UnexpectedFailure extends Failure {
  /// Creates an unexpected failure with an optional message.
  const UnexpectedFailure([super.message]);
}
