import 'package:authentication/domain/exceptions/auth_exceptions.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

/// Value object representing a validated email address.
///
/// Construction is only possible via the [create] factory, which validates
/// the format and returns an [Either]. On success the [Email] is in the
/// [Right]; on failure an [AuthException] is in the [Left].
///
/// ```dart
/// final result = Email.create('user@example.com');
/// result.fold(
///   (e) => print('Invalid: ${e.message}'),
///   (email) => print('Valid: ${email.value}'),
/// );
/// ```
class Email extends ValueObject {
  const Email._(this.value);

  /// Reconstitutes an [Email] from trusted persistent storage.
  ///
  /// Bypasses format validation — use **only** when the value is already
  /// known-valid (e.g., loaded from the local database or Cognito response).
  const Email.fromStorage(this.value);

  /// The raw, trimmed email string.
  final String value;

  /// Validates [input] and returns an [Email] or [AuthException].
  ///
  /// Validation rules:
  /// - Non-empty after trimming
  /// - Must match RFC 5322-compatible pattern (local@domain.tld)
  static Either<AuthException, Email> create(String input) {
    final trimmed = input.trim();
    if (trimmed.isEmpty || !_emailRegex.hasMatch(trimmed)) {
      return left(InvalidCredentials());
    }
    return right(Email._(trimmed));
  }

  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$',
  );

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'Email($value)';
}
