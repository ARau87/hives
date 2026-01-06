/// Base class for all domain events in the domain model.
///
/// Domain events represent something that has happened within a domain
/// aggregate. They capture important business events and allow different
/// parts of the system to react to them. Each domain event is identified
/// by a unique ID and timestamp, ensuring traceability and proper ordering
/// of events within the domain.
///
/// Concrete domain events should extend this class and add event-specific
/// properties relevant to the business domain.
///
/// Example:
/// ```dart
/// class UserCreatedEvent extends DomainEvent {
///   UserCreatedEvent({
///     required String userId,
///     required String email,
///   }) : super(
///     aggregateId: userId,
///   ) {
///     this.userId = userId;
///     this.email = email;
///   }
///
///   late final String userId;
///   late final String email;
/// }
/// ```
abstract class DomainEvent {
  /// Creates a domain event with the given [aggregateId].
  ///
  /// The [occurredAt] is automatically set to the current time if not
  /// provided, ensuring events are timestamped when created.
  DomainEvent({required this.aggregateId, DateTime? occurredAt})
    : occurredAt = occurredAt ?? DateTime.now();

  /// The unique identifier of the aggregate that produced this event.
  ///
  /// This links the event to the aggregate it originates from,
  /// allowing event consumers to process events for specific aggregates.
  final String aggregateId;

  /// The timestamp when this event occurred.
  ///
  /// Automatically set to the current time when the event is created,
  /// unless explicitly provided. This ensures proper event ordering
  /// across the domain.
  final DateTime occurredAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DomainEvent &&
          runtimeType == other.runtimeType &&
          aggregateId == other.aggregateId &&
          occurredAt == other.occurredAt;

  @override
  int get hashCode => Object.hash(runtimeType, aggregateId, occurredAt);

  @override
  String toString() =>
      '$runtimeType(aggregateId: $aggregateId, occurredAt: $occurredAt)';
}
