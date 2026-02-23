/// Core domain building blocks for DDD-based architecture.
///
/// This package provides the foundational classes for implementing
/// Domain-Driven Design patterns across all feature modules.
///
/// ## Base Classes
///
/// - [AggregateRoot] - Entry point to aggregate clusters with event tracking
/// - [Entity] - Objects with persistent identity
/// - [ValueObject] - Immutable objects compared by attributes
/// - [DomainEvent] - Represents business events raised by aggregates
///
/// ## Error Handling
///
/// - [DomainException] - Base class for typed domain errors
/// - [Failure] - Sealed class hierarchy for functional error handling
///
/// ## Utilities
///
/// - [UniqueId] - UUID v4 generator for aggregate/entity identifiers
library;

// Base domain classes
export 'package:shared/domain/aggregate_root.dart';
export 'package:shared/domain/entity.dart';
export 'package:shared/domain/value_object.dart';
export 'package:shared/domain/domain_event.dart';

// Error handling
export 'package:shared/domain/exceptions/domain_exception.dart';
export 'package:shared/domain/failures/failure.dart';

// Value objects
export 'package:shared/domain/value_objects/unique_id.dart';
