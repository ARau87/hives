import 'package:shared/domain/value_object.dart';
import 'package:uuid/uuid.dart';

/// A value object representing a universally unique identifier.
///
/// [UniqueId] wraps a UUID v4 string and provides:
/// - Generation of new cryptographically secure random IDs
/// - Reconstitution from existing ID strings (e.g., from database)
/// - Value equality based on the underlying UUID string
///
/// UUID v4 provides 122 bits of randomness, making collisions extremely
/// unlikely (probability of ~1 in 5.3 billion for 100 trillion IDs).
///
/// ## Creating a New ID
///
/// ```dart
/// final id = UniqueId();
/// print(id.value); // e.g., "550e8400-e29b-41d4-a716-446655440000"
/// ```
///
/// ## Reconstituting from Storage
///
/// ```dart
/// final id = UniqueId.fromString('550e8400-e29b-41d4-a716-446655440000');
/// ```
///
/// ## Usage in Aggregates
///
/// ```dart
/// class HiveId extends UniqueId {
///   HiveId() : super();
///   HiveId.fromString(String value) : super.fromString(value);
/// }
///
/// class HiveAggregate extends AggregateRoot<HiveId> {
///   HiveAggregate({required HiveId id}) : super(id: id);
/// }
/// ```
class UniqueId extends ValueObject {
  /// Creates a new [UniqueId] with a randomly generated UUID v4.
  ///
  /// The generated UUID is cryptographically secure and suitable for
  /// use as a primary identifier in distributed systems.
  ///
  /// Example:
  /// ```dart
  /// final id = UniqueId();
  /// ```
  UniqueId() : value = _uuid.v4();

  /// Creates a [UniqueId] from an existing UUID string.
  ///
  /// Use this when reconstituting objects from persistence (database, API)
  /// where the ID already exists.
  ///
  /// Throws [FormatException] if [value] is not a valid UUID format.
  ///
  /// Example:
  /// ```dart
  /// final id = UniqueId.fromString(databaseRecord['id']);
  /// ```
  UniqueId.fromString(this.value) {
    if (!_uuidPattern.hasMatch(value)) {
      throw FormatException('Invalid UUID format: $value');
    }
  }

  /// The underlying UUID string value.
  ///
  /// Format: 8-4-4-4-12 hexadecimal characters with hyphens.
  /// Example: "550e8400-e29b-41d4-a716-446655440000"
  final String value;

  /// Shared UUID generator instance.
  ///
  /// Using a single instance is more efficient than creating new ones.
  static const Uuid _uuid = Uuid();

  /// UUID format validation pattern.
  ///
  /// Matches standard UUID format: 8-4-4-4-12 hexadecimal characters.
  static final RegExp _uuidPattern = RegExp(
    r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$',
    caseSensitive: false,
  );

  @override
  List<Object?> get props => [value];

  @override
  String toString() => value;
}
