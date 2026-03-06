import 'package:shared/shared.dart';

/// Typed identifier for a [UserAggregate].
///
/// Extends [UniqueId] to inherit UUID v4 generation and validation.
/// Provides compile-time type safety — a [UserId] cannot be confused
/// with a LocationId or HiveId even though all are UUID strings.
///
/// ## Creating a new user ID
/// ```dart
/// final id = UserId();   // generates new UUID v4
/// ```
///
/// ## Reconstituting from storage
/// ```dart
/// final id = UserId.fromString('550e8400-e29b-41d4-a716-446655440000');
/// ```
class UserId extends UniqueId {
  /// Creates a new [UserId] with a randomly generated UUID v4.
  UserId() : super();

  /// Creates a [UserId] from an existing UUID string.
  ///
  /// Throws [FormatException] if [value] is not a valid UUID format.
  UserId.fromString(super.value) : super.fromString();
}
