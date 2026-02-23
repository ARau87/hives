import 'package:shared/domain/domain_event.dart';

/// Base class for all aggregate roots in the domain model.
///
/// An aggregate root is the entry point to an aggregate cluster of domain
/// objects (entities and value objects). The aggregate root enforces
/// transactional consistency and business invariants for all objects
/// within its aggregate boundary.
///
/// This class provides:
/// - **Identity**: Each aggregate root has a stable, unique identifier
/// - **Event sourcing**: Tracks and publishes domain events raised by the aggregate
/// - **Invariant enforcement**: Business rules are maintained at the aggregate level
///
/// Concrete aggregate roots should override [clearEvents] if they need custom
/// event handling behavior.
///
/// Example:
/// ```dart
/// class Order extends AggregateRoot<String> {
///   Order({required String id}) : super(id: id);
///
///   void placeOrder(OrderDetails details) {
///     // Business logic and validation
///     addEvent(OrderPlacedEvent(aggregateId: id));
///   }
/// }
/// ```
abstract class AggregateRoot<ID> {
  /// Creates an aggregate root with the given [id].
  ///
  /// The [id] uniquely identifies this aggregate within the domain.
  AggregateRoot({required this.id});

  /// The unique identifier of this aggregate root.
  ///
  /// This identity is stable throughout the aggregate's lifecycle and
  /// uniquely identifies it within its bounded context.
  final ID id;

  /// The list of domain events raised by this aggregate.
  ///
  /// Events are collected as the aggregate's state changes and should be
  /// published to event subscribers after the aggregate is persisted.
  /// After publishing, events should be cleared via [clearEvents].
  final List<DomainEvent> _events = [];

  /// Returns an unmodifiable view of domain events raised by this aggregate.
  List<DomainEvent> get events => List.unmodifiable(_events);

  /// Adds a domain event to this aggregate's event list.
  ///
  /// Domain events represent important business occurrences within the
  /// aggregate and should be published after the aggregate is persisted
  /// to maintain consistency.
  void addEvent(DomainEvent event) {
    _events.add(event);
  }

  /// Clears all domain events from this aggregate.
  ///
  /// This should be called after events have been successfully published
  /// to prevent duplicate event publishing. Can be overridden by subclasses
  /// for custom event handling behavior.
  void clearEvents() {
    _events.clear();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AggregateRoot<ID> &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => '$runtimeType(id: $id)';
}
