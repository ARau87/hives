import 'package:authentication/domain/aggregates/user_aggregate.dart';
import 'package:authentication/domain/exceptions/auth_exceptions.dart';

/// Sealed class for all authentication states emitted by [AuthBloc].
sealed class AuthState {
  const AuthState();
}

/// Initial state before any auth check has been performed.
final class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Loading state while an auth operation is in progress.
final class AuthLoading extends AuthState {
  const AuthLoading();
}

/// The user is authenticated with a valid session.
final class Authenticated extends AuthState {
  const Authenticated(this.user);

  final UserAggregate user;
}

/// The user is not authenticated (no session or signed out).
final class Unauthenticated extends AuthState {
  const Unauthenticated();
}

/// An authentication operation failed with a specific [exception].
final class AuthError extends AuthState {
  const AuthError(this.exception);

  final AuthException exception;
}
