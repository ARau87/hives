import 'package:shared/shared.dart';

/// Base class for all authentication-specific domain exceptions.
///
/// Concrete subtypes represent specific failure scenarios in the auth
/// bounded context. Use these in [Either] return types rather than
/// throwing exceptions.
abstract class AuthException extends DomainException {}

/// Thrown when the provided credentials (email/password) are invalid
/// or the email format does not pass validation.
final class InvalidCredentials extends AuthException {
  InvalidCredentials();

  @override
  String get message => 'Invalid email or password';
}

/// Thrown when attempting to sign up with an email that is already
/// registered in the system.
final class EmailAlreadyExists extends AuthException {
  EmailAlreadyExists();

  @override
  String get message => 'Email address is already registered';
}

/// Thrown when a password does not meet the strength requirements.
///
/// The optional [detail] parameter carries the specific rule that failed,
/// useful for displaying targeted feedback in the UI.
final class WeakPassword extends AuthException {
  WeakPassword([this._detail = 'Password does not meet requirements']);

  final String _detail;

  @override
  String get message => _detail;
}

/// Thrown when no account exists for the provided identifier.
final class UserNotFound extends AuthException {
  UserNotFound();

  @override
  String get message => 'User not found';
}

/// Thrown when an auth operation fails due to a network problem
/// (e.g., no connectivity, timeout, or Cognito unreachable).
final class NetworkError extends AuthException {
  NetworkError([this._detail = 'A network error occurred']);

  final String _detail;

  @override
  String get message => _detail;
}
