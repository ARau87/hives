import 'package:authentication/domain/aggregates/user_aggregate.dart';
import 'package:authentication/domain/exceptions/auth_exceptions.dart';
import 'package:authentication/domain/value_objects/email.dart';
import 'package:authentication/domain/value_objects/password.dart';
import 'package:fpdart/fpdart.dart';

/// Repository interface for all authentication operations.
///
/// Implementations (Story 2.3) connect domain logic to the Cognito data
/// source and local secure storage. All methods return [Either] — never
/// throw exceptions — allowing callers to use functional error handling.
///
/// Registered as a GetIt singleton by the app's bootstrap (Story 2.3).
abstract class AuthenticationRepository {
  /// Creates a new user account with [email] and [password].
  ///
  /// On success returns the new [UserAggregate].
  /// On failure returns one of: [EmailAlreadyExists], [WeakPassword],
  /// [NetworkError].
  Future<Either<AuthException, UserAggregate>> signUp({
    required Email email,
    required Password password,
  });

  /// Authenticates an existing user with [email] and [password].
  ///
  /// On success returns the authenticated [UserAggregate] and stores
  /// tokens in secure storage.
  /// On failure returns one of: [InvalidCredentials], [UserNotFound],
  /// [NetworkError].
  Future<Either<AuthException, UserAggregate>> signIn({
    required Email email,
    required Password password,
  });

  /// Signs out the current user and clears stored tokens.
  ///
  /// Returns [Unit] on success (void equivalent in fpdart).
  Future<Either<AuthException, Unit>> signOut();

  /// Initiates the password reset flow for [email].
  ///
  /// Sends a verification code to the email address. For security, a
  /// generic response is returned even if the email is not registered.
  Future<Either<AuthException, Unit>> resetPassword({
    required Email email,
  });

  /// Returns the currently authenticated [UserAggregate], or `null`
  /// if no session exists.
  ///
  /// Checks secure storage for a valid token and refreshes if needed.
  Future<Either<AuthException, UserAggregate?>> getCurrentUser();
}
