import 'package:authentication/domain/repositories/authentication_repository.dart';
import 'package:authentication/presentation/bloc/auth_event.dart';
import 'package:authentication/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// BLoC managing authentication state transitions.
///
/// Dispatches [CheckAuthStatus] on creation to determine initial auth state.
/// All repository calls return `Either<AuthException, T>` and are folded
/// into the appropriate [AuthState].
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._repository) : super(const AuthInitial()) {
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<SignInRequested>(_onSignIn);
    on<SignUpRequested>(_onSignUp);
    on<SignOutRequested>(_onSignOut);
    on<ResetPasswordRequested>(_onResetPassword);
    on<ConfirmSignUpRequested>(_onConfirmSignUp);
    on<ResendConfirmationCodeRequested>(_onResendConfirmationCode);
    on<ConfirmForgotPasswordRequested>(_onConfirmForgotPassword);

    add(const CheckAuthStatus());
  }

  final AuthenticationRepository _repository;

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await _repository.getCurrentUser();
    result.fold(
      (_) => emit(const Unauthenticated()),
      (user) =>
          user != null ? emit(Authenticated(user)) : emit(const Unauthenticated()),
    );
  }

  Future<void> _onSignIn(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await _repository.signIn(
      email: event.email,
      password: event.password,
    );
    result.fold(
      (exception) => emit(AuthError(exception)),
      (user) => emit(Authenticated(user)),
    );
  }

  Future<void> _onSignUp(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await _repository.signUp(
      email: event.email,
      password: event.password,
    );
    result.fold(
      (exception) => emit(AuthError(exception)),
      (user) => emit(Authenticated(user)),
    );
  }

  Future<void> _onSignOut(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      await _repository.signOut();
    } catch (_) {
      // Intentionally swallow — always sign out locally regardless of server errors.
    }
    emit(const Unauthenticated());
  }

  Future<void> _onResetPassword(
    ResetPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await _repository.resetPassword(email: event.email);
    result.fold(
      (exception) => emit(AuthError(exception)),
      (_) => emit(const Unauthenticated()),
    );
  }

  Future<void> _onConfirmSignUp(
    ConfirmSignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await _repository.confirmSignUp(
      email: event.email,
      confirmationCode: event.confirmationCode,
    );
    result.fold(
      (exception) => emit(AuthError(exception)),
      (_) => emit(const Unauthenticated()),
    );
  }

  Future<void> _onResendConfirmationCode(
    ResendConfirmationCodeRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await _repository.resendConfirmationCode(email: event.email);
    result.fold(
      (exception) => emit(AuthError(exception)),
      (_) => emit(const Unauthenticated()),
    );
  }

  Future<void> _onConfirmForgotPassword(
    ConfirmForgotPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await _repository.confirmForgotPassword(
      email: event.email,
      code: event.code,
      newPassword: event.newPassword,
    );
    result.fold(
      (exception) => emit(AuthError(exception)),
      (_) => emit(const Unauthenticated()),
    );
  }
}
