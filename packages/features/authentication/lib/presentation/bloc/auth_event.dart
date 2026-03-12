import 'package:authentication/domain/value_objects/email.dart';
import 'package:authentication/domain/value_objects/password.dart';

/// Sealed class for all authentication events dispatched to [AuthBloc].
sealed class AuthEvent {
  const AuthEvent();
}

/// Check the current authentication status on app startup.
final class CheckAuthStatus extends AuthEvent {
  const CheckAuthStatus();
}

/// Request sign-in with validated [email] and [password].
final class SignInRequested extends AuthEvent {
  const SignInRequested({required this.email, required this.password});

  final Email email;
  final Password password;
}

/// Request sign-up with validated [email] and [password].
final class SignUpRequested extends AuthEvent {
  const SignUpRequested({required this.email, required this.password});

  final Email email;
  final Password password;
}

/// Request sign-out of the current user.
final class SignOutRequested extends AuthEvent {
  const SignOutRequested();
}

/// Request a password reset code for [email].
final class ResetPasswordRequested extends AuthEvent {
  const ResetPasswordRequested({required this.email});

  final Email email;
}

/// Confirm a new user's sign-up with the [confirmationCode].
final class ConfirmSignUpRequested extends AuthEvent {
  const ConfirmSignUpRequested({
    required this.email,
    required this.confirmationCode,
  });

  final Email email;
  final String confirmationCode;
}

/// Resend the confirmation code to [email] for a pending sign-up.
final class ResendConfirmationCodeRequested extends AuthEvent {
  const ResendConfirmationCodeRequested({required this.email});

  final Email email;
}

/// Complete the password reset flow with [code] and [newPassword].
final class ConfirmForgotPasswordRequested extends AuthEvent {
  const ConfirmForgotPasswordRequested({
    required this.email,
    required this.code,
    required this.newPassword,
  });

  final Email email;
  final String code;
  final Password newPassword;
}
