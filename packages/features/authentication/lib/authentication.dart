/// Authentication feature package for the Hives project.
///
/// Exports the complete authentication domain model following DDD patterns.
/// Story 2.1 covers the domain layer only; data and presentation layers
/// are added in subsequent stories (2.2–2.8).
///
/// ## Domain Model
///
/// **Aggregates:**
/// - [UserAggregate] — root for the auth bounded context
///
/// **Value Objects:**
/// - [UserId] — UUID-validated user identifier
/// - [Email] — format-validated email address (factory with Either)
/// - [Password] — strength-validated password (factory with Either)
///
/// **Repository Interface:**
/// - [AuthenticationRepository] — signUp, signIn, signOut, resetPassword, getCurrentUser
///
/// **Exceptions:**
/// - [AuthException] — base
/// - [InvalidCredentials], [EmailAlreadyExists], [WeakPassword],
///   [UserNotFound], [NetworkError]
///
/// **Domain Events (for EventBus):**
/// - [AuthUserLoggedIn], [AuthUserLoggedOut]
library;

// Aggregates
export 'package:authentication/domain/aggregates/user_aggregate.dart';

// Value objects
export 'package:authentication/domain/value_objects/user_id.dart';
export 'package:authentication/domain/value_objects/email.dart';
export 'package:authentication/domain/value_objects/password.dart';

// Repository interface
export 'package:authentication/domain/repositories/authentication_repository.dart';

// Exceptions
export 'package:authentication/domain/exceptions/auth_exceptions.dart';

// Domain events
export 'package:authentication/domain/events/auth_events.dart';
