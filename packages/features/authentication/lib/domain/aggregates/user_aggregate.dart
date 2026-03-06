import 'package:authentication/domain/events/auth_events.dart';
import 'package:authentication/domain/exceptions/auth_exceptions.dart';
import 'package:authentication/domain/value_objects/email.dart';
import 'package:authentication/domain/value_objects/user_id.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

/// Aggregate root for the authentication bounded context.
///
/// Represents an authenticated user with their validated identity data.
/// Follow DDD factory patterns:
///
/// - Use [UserAggregate.create] for new user registration — validates email
///   and raises [AuthUserLoggedIn] domain event.
/// - Use [UserAggregate.reconstitute] to rebuild from persistence — no
///   events are raised.
///
/// Fields are immutable (`final`) to enforce value-object semantics at
/// the aggregate level.
class UserAggregate extends AggregateRoot<UserId> {
  // ── Constructors (always first) ────────────────────────────────────────────

  UserAggregate._({
    required super.id,
    required this.email,
    required this.createdAt,
  });

  /// Factory for **reconstituting from persistence**.
  ///
  /// Bypasses validation (data is assumed valid from storage) and raises
  /// no domain events. Use this when loading a user from the local DB or
  /// a Cognito response after sign-in.
  factory UserAggregate.reconstitute({
    required String id,
    required String email,
    required DateTime createdAt,
  }) {
    return UserAggregate._(
      id: UserId.fromString(id),
      email: Email.fromStorage(email),
      createdAt: createdAt,
    );
  }

  // ── Fields ─────────────────────────────────────────────────────────────────

  /// The user's validated email address.
  final Email email;

  /// Timestamp when the user account was created.
  final DateTime createdAt;

  // ── Static factories ───────────────────────────────────────────────────────

  /// Factory for **new user registration**.
  ///
  /// Validates [emailStr] via [Email.create]. On success, generates a
  /// new [UserId], constructs the aggregate, and raises [AuthUserLoggedIn].
  ///
  /// Returns [Left] with an [AuthException] if validation fails.
  static Either<AuthException, UserAggregate> create({
    required String emailStr,
  }) {
    return Email.create(emailStr).map((validEmail) {
      final userId = UserId();
      final aggregate = UserAggregate._(
        id: userId,
        email: validEmail,
        createdAt: DateTime.now(),
      );
      aggregate.addEvent(AuthUserLoggedIn(userId: userId));
      return aggregate;
    });
  }
}
