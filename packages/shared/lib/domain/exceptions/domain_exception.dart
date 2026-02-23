/// Base class for all domain exceptions in the domain model.
///
/// Domain exceptions represent errors that occur within the domain layer
/// due to business rule violations, validation failures, or invalid operations.
/// They provide a typed exception hierarchy that can be caught and handled
/// appropriately by the application layer.
///
/// Feature modules should create their own exception hierarchies extending
/// this base class. This allows for:
/// - Type-safe exception handling
/// - Module-specific error messages
/// - Clear separation of domain errors from infrastructure errors
///
/// Example:
/// ```dart
/// // In feature module
/// abstract class HiveException extends DomainException {}
///
/// class HiveNotFoundException extends HiveException {
///   final String hiveId;
///
///   HiveNotFoundException(this.hiveId);
///
///   @override
///   String get message => 'Hive not found: $hiveId';
/// }
///
/// class HiveValidationException extends HiveException {
///   final List<String> errors;
///
///   HiveValidationException(this.errors);
///
///   @override
///   String get message => 'Validation failed: ${errors.join(', ')}';
/// }
/// ```
abstract class DomainException implements Exception {
  /// A human-readable message describing the exception.
  ///
  /// This message should be descriptive enough for logging and debugging
  /// but may not be suitable for direct display to end users.
  String get message;

  @override
  String toString() => '$runtimeType: $message';
}
