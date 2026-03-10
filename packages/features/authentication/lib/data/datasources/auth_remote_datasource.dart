import 'package:authentication/data/dtos/cognito_auth_result.dart';

/// Abstract interface for remote authentication data sources.
///
/// Enables mocking in tests and swapping authentication providers
/// without changing the repository layer.
abstract class AuthRemoteDataSource {
  /// Creates a new user account with the given [email] and [password].
  ///
  /// Returns the user sub (UUID) on success.
  /// Throws [EmailAlreadyExists], [WeakPassword], or [NetworkError].
  Future<String> signUp({
    required String email,
    required String password,
  });

  /// Verifies a user account with the given [email] and [confirmationCode].
  ///
  /// Throws [InvalidCredentials] on invalid/expired code, or [NetworkError].
  Future<void> confirmSignUp({
    required String email,
    required String confirmationCode,
  });

  /// Authenticates a user with [email] and [password].
  ///
  /// Returns [CognitoAuthResult] with access, id, and refresh tokens.
  /// Throws [InvalidCredentials], [UserNotFound], or [NetworkError].
  Future<CognitoAuthResult> signIn({
    required String email,
    required String password,
  });

  /// Signs out the current user by invalidating the local session.
  ///
  /// Throws [NetworkError] on failure.
  Future<void> signOut();

  /// Initiates password reset flow by sending a code to [email].
  ///
  /// Never throws [UserNotFound] for security (always succeeds from caller's perspective).
  /// Throws [NetworkError] on connectivity failure.
  Future<void> forgotPassword({required String email});

  /// Completes password reset with [email], [code], and [newPassword].
  ///
  /// Throws [InvalidCredentials] on bad code, [WeakPassword], or [NetworkError].
  Future<void> confirmForgotPassword({
    required String email,
    required String code,
    required String newPassword,
  });

  /// Returns the currently authenticated user's tokens, or null if no session.
  ///
  /// Throws [NetworkError] on failure.
  Future<CognitoAuthResult?> getCurrentUser();
}
