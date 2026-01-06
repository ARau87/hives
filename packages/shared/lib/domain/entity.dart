/// Base class for all entities in the domain model.
///
/// An entity is an object that has a persistent identity throughout its
/// lifecycle. Unlike value objects, entities are distinguished by their
/// identity rather than their attributes. Two entities with identical
/// attributes but different identities are considered different entities.
///
/// Entities are typically part of an aggregate and should be created,
/// retrieved, and modified through the aggregate root to maintain
/// invariants and consistency.
///
/// Example:
/// ```dart
/// class OrderItem extends Entity<String> {
///   OrderItem({
///     required String id,
///     required String productId,
///     required int quantity,
///     required Money price,
///   }) : super(id: id) {
///     _productId = productId;
///     _quantity = quantity;
///     _price = price;
///   }
///
///   late final String _productId;
///   late final int _quantity;
///   late final Money _price;
///
///   String get productId => _productId;
///   int get quantity => _quantity;
///   Money get price => _price;
/// }
/// ```
abstract class Entity<ID> {
  /// Creates an entity with the given [id].
  ///
  /// The [id] is the unique identifier that distinguishes this entity
  /// from other entities, even if they have identical attributes.
  Entity({required this.id});

  /// The unique identifier of this entity.
  ///
  /// This identity is stable throughout the entity's lifecycle and
  /// distinguishes it from all other entities of the same type.
  /// Equality between entities is determined by their ID, not their
  /// attributes.
  final ID id;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Entity<ID> && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => '$runtimeType(id: $id)';
}
