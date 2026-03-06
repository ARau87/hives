import 'package:authentication/domain/exceptions/auth_exceptions.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

/// Value object representing a validated password.
///
/// Construction is only possible via the [create] factory, which validates
/// password strength rules and returns an [Either].
///
/// **Strength rules:**
/// - Minimum 8 characters
/// - At least one uppercase letter (A-Z)
/// - At least one lowercase letter (a-z)
/// - At least one digit (0-9)
///
/// The underlying [value] is the raw password string. The caller is
/// responsible for not persisting it in plaintext.
///
/// ```dart
/// final result = Password.create('MyPass1!');
/// result.fold(
///   (e) => print('Weak: ${e.message}'),
///   (pw) => print('Valid password'),
/// );
/// ```
class Password extends ValueObject {
  const Password._(this.value);

  /// The raw password string. Handle with care — never log or persist.
  final String value;

  /// Validates [input] against strength rules and returns a [Password]
  /// or a [WeakPassword] exception.
  static Either<AuthException, Password> create(String input) {
    if (input.length < 8) {
      return left(WeakPassword('Password must be at least 8 characters'));
    }
    if (!_uppercaseRegex.hasMatch(input)) {
      return left(
        WeakPassword('Password must contain at least one uppercase letter'),
      );
    }
    if (!_lowercaseRegex.hasMatch(input)) {
      return left(
        WeakPassword('Password must contain at least one lowercase letter'),
      );
    }
    if (!_digitRegex.hasMatch(input)) {
      return left(
        WeakPassword('Password must contain at least one digit'),
      );
    }
    return right(Password._(input));
  }

  static final _uppercaseRegex = RegExp(r'[A-Z]');
  static final _lowercaseRegex = RegExp(r'[a-z]');
  static final _digitRegex = RegExp(r'[0-9]');

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'Password(****)';
}
