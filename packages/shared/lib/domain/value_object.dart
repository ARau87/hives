/// Base class for all value objects in the domain model.
///
/// A value object is an immutable object that is defined by its attributes
/// rather than its identity. Two value objects with identical attributes are
/// considered equal, regardless of whether they are the same instance.
///
/// Value objects:
/// - Are immutable and should not change after creation
/// - Are compared by their attributes, not by identity
/// - Have no persistent identity like entities
/// - Can be freely shared and copied
/// - Should enforce their own invariants through validation
///
/// Concrete value objects should:
/// - Override [props] to define which attributes determine equality
/// - Keep all fields final and initialize them in the constructor
/// - Validate invariants in the constructor or via factory constructors
/// - Override [==] and [hashCode] if [props] alone is not sufficient
///
/// Example:
/// ```dart
/// class Email extends ValueObject {
///   const Email(this.value);
///
///   final String value;
///
///   @override
///   List<Object?> get props => [value];
/// }
///
/// class Money extends ValueObject {
///   const Money({required this.amount, required this.currency});
///
///   final double amount;
///   final String currency;
///
///   @override
///   List<Object?> get props => [amount, currency];
/// }
/// ```
abstract class ValueObject {
  /// Creates a value object.
  ///
  /// Subclasses should call this constructor as `super()` if they define
  /// their own constructor.
  const ValueObject();

  /// The list of properties that define this value object's equality.
  ///
  /// Two value objects are equal if they have the same type and identical
  /// properties in the same order.
  ///
  /// Return an empty list `[]` if the value object has no properties,
  /// though this is rare. Include all attributes that define the value
  /// object's semantic meaning.
  List<Object?> get props;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ValueObject &&
          runtimeType == other.runtimeType &&
          _propsAreEqual(other);

  /// Checks if this value object's properties equal another's.
  bool _propsAreEqual(ValueObject other) {
    if (props.length != other.props.length) return false;
    for (int i = 0; i < props.length; i++) {
      if (props[i] != other.props[i]) return false;
    }
    return true;
  }

  @override
  int get hashCode => Object.hashAll(props);

  @override
  String toString() => '$runtimeType(${props.join(', ')})';
}
