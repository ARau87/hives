import 'package:authentication/domain/aggregates/user_aggregate.dart';
import 'package:authentication/domain/exceptions/auth_exceptions.dart';
import 'package:authentication/domain/repositories/authentication_repository.dart';
import 'package:authentication/domain/value_objects/email.dart';
import 'package:authentication/domain/value_objects/password.dart';
import 'package:authentication/presentation/bloc/auth_bloc.dart';
import 'package:authentication/presentation/bloc/auth_event.dart';
import 'package:authentication/presentation/bloc/auth_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([AuthenticationRepository])
import 'auth_bloc_test.mocks.dart';

void main() {
  late MockAuthenticationRepository mockRepository;
  late UserAggregate testUser;
  late Email testEmail;
  late Password testPassword;

  setUp(() {
    mockRepository = MockAuthenticationRepository();

    // Provide dummy values for Either types that mockito can't auto-generate
    provideDummy<Either<AuthException, UserAggregate?>>(right(null));
    provideDummy<Either<AuthException, UserAggregate>>(
      right(UserAggregate.reconstitute(
        id: '00000000-0000-0000-0000-000000000000',
        email: 'dummy@example.com',
        createdAt: DateTime(2026),
      )),
    );
    provideDummy<Either<AuthException, Unit>>(right(unit));

    testUser = UserAggregate.reconstitute(
      id: '123e4567-e89b-12d3-a456-426614174000',
      email: 'test@example.com',
      createdAt: DateTime(2026),
    );
    testEmail = Email.create('test@example.com').getOrElse((_) => throw Error());
    testPassword =
        Password.create('StrongPass1').getOrElse((_) => throw Error());
  });

  group('CheckAuthStatus', () {
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, Authenticated] when user has valid session',
      setUp: () {
        when(mockRepository.getCurrentUser())
            .thenAnswer((_) async => right(testUser));
      },
      build: () => AuthBloc(mockRepository),
      expect: () => [isA<AuthLoading>(), isA<Authenticated>()],
      verify: (_) {
        verify(mockRepository.getCurrentUser()).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, Unauthenticated] when no session exists',
      setUp: () {
        when(mockRepository.getCurrentUser())
            .thenAnswer((_) async => right(null));
      },
      build: () => AuthBloc(mockRepository),
      expect: () => [isA<AuthLoading>(), isA<Unauthenticated>()],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, Unauthenticated] on error (graceful degradation)',
      setUp: () {
        when(mockRepository.getCurrentUser())
            .thenAnswer((_) async => left(NetworkError()));
      },
      build: () => AuthBloc(mockRepository),
      expect: () => [isA<AuthLoading>(), isA<Unauthenticated>()],
    );
  });

  group('SignInRequested', () {
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, Authenticated] on successful sign in',
      setUp: () {
        when(mockRepository.getCurrentUser())
            .thenAnswer((_) async => right(null));
        when(mockRepository.signIn(email: testEmail, password: testPassword))
            .thenAnswer((_) async => right(testUser));
      },
      build: () => AuthBloc(mockRepository),
      act: (bloc) =>
          bloc.add(SignInRequested(email: testEmail, password: testPassword)),
      expect: () => [
        isA<AuthLoading>(),
        isA<Unauthenticated>(),
        isA<AuthLoading>(),
        isA<Authenticated>(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthError] on invalid credentials',
      setUp: () {
        when(mockRepository.getCurrentUser())
            .thenAnswer((_) async => right(null));
        when(mockRepository.signIn(email: testEmail, password: testPassword))
            .thenAnswer((_) async => left(InvalidCredentials()));
      },
      build: () => AuthBloc(mockRepository),
      act: (bloc) =>
          bloc.add(SignInRequested(email: testEmail, password: testPassword)),
      expect: () => [
        isA<AuthLoading>(),
        isA<Unauthenticated>(),
        isA<AuthLoading>(),
        isA<AuthError>(),
      ],
    );
  });

  group('SignUpRequested', () {
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, Authenticated] on successful sign up',
      setUp: () {
        when(mockRepository.getCurrentUser())
            .thenAnswer((_) async => right(null));
        when(mockRepository.signUp(email: testEmail, password: testPassword))
            .thenAnswer((_) async => right(testUser));
      },
      build: () => AuthBloc(mockRepository),
      act: (bloc) =>
          bloc.add(SignUpRequested(email: testEmail, password: testPassword)),
      expect: () => [
        isA<AuthLoading>(),
        isA<Unauthenticated>(),
        isA<AuthLoading>(),
        isA<Authenticated>(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthError] when email already exists',
      setUp: () {
        when(mockRepository.getCurrentUser())
            .thenAnswer((_) async => right(null));
        when(mockRepository.signUp(email: testEmail, password: testPassword))
            .thenAnswer((_) async => left(EmailAlreadyExists()));
      },
      build: () => AuthBloc(mockRepository),
      act: (bloc) =>
          bloc.add(SignUpRequested(email: testEmail, password: testPassword)),
      expect: () => [
        isA<AuthLoading>(),
        isA<Unauthenticated>(),
        isA<AuthLoading>(),
        isA<AuthError>(),
      ],
    );
  });

  group('SignOutRequested', () {
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, Unauthenticated] on sign out',
      setUp: () {
        when(mockRepository.getCurrentUser())
            .thenAnswer((_) async => right(testUser));
        when(mockRepository.signOut())
            .thenAnswer((_) async => right(unit));
      },
      build: () => AuthBloc(mockRepository),
      act: (bloc) => bloc.add(const SignOutRequested()),
      expect: () => [
        isA<AuthLoading>(),
        isA<Authenticated>(),
        isA<AuthLoading>(),
        isA<Unauthenticated>(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, Unauthenticated] even when sign out fails',
      setUp: () {
        when(mockRepository.getCurrentUser())
            .thenAnswer((_) async => right(testUser));
        when(mockRepository.signOut())
            .thenAnswer((_) async => left(NetworkError()));
      },
      build: () => AuthBloc(mockRepository),
      act: (bloc) => bloc.add(const SignOutRequested()),
      expect: () => [
        isA<AuthLoading>(),
        isA<Authenticated>(),
        isA<AuthLoading>(),
        isA<Unauthenticated>(),
      ],
    );
  });

  group('ResetPasswordRequested', () {
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, Unauthenticated] on success',
      setUp: () {
        when(mockRepository.getCurrentUser())
            .thenAnswer((_) async => right(null));
        when(mockRepository.resetPassword(email: testEmail))
            .thenAnswer((_) async => right(unit));
      },
      build: () => AuthBloc(mockRepository),
      act: (bloc) =>
          bloc.add(ResetPasswordRequested(email: testEmail)),
      expect: () => [
        isA<AuthLoading>(),
        isA<Unauthenticated>(),
        isA<AuthLoading>(),
        isA<Unauthenticated>(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthError] on failure',
      setUp: () {
        when(mockRepository.getCurrentUser())
            .thenAnswer((_) async => right(null));
        when(mockRepository.resetPassword(email: testEmail))
            .thenAnswer((_) async => left(NetworkError()));
      },
      build: () => AuthBloc(mockRepository),
      act: (bloc) =>
          bloc.add(ResetPasswordRequested(email: testEmail)),
      expect: () => [
        isA<AuthLoading>(),
        isA<Unauthenticated>(),
        isA<AuthLoading>(),
        isA<AuthError>(),
      ],
    );
  });

  group('ConfirmSignUpRequested', () {
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, Unauthenticated] on success',
      setUp: () {
        when(mockRepository.getCurrentUser())
            .thenAnswer((_) async => right(null));
        when(mockRepository.confirmSignUp(
          email: testEmail,
          confirmationCode: '123456',
        )).thenAnswer((_) async => right(unit));
      },
      build: () => AuthBloc(mockRepository),
      act: (bloc) => bloc.add(ConfirmSignUpRequested(
        email: testEmail,
        confirmationCode: '123456',
      )),
      expect: () => [
        isA<AuthLoading>(),
        isA<Unauthenticated>(),
        isA<AuthLoading>(),
        isA<Unauthenticated>(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthError] on invalid code',
      setUp: () {
        when(mockRepository.getCurrentUser())
            .thenAnswer((_) async => right(null));
        when(mockRepository.confirmSignUp(
          email: testEmail,
          confirmationCode: 'wrong',
        )).thenAnswer((_) async => left(InvalidCredentials()));
      },
      build: () => AuthBloc(mockRepository),
      act: (bloc) => bloc.add(ConfirmSignUpRequested(
        email: testEmail,
        confirmationCode: 'wrong',
      )),
      expect: () => [
        isA<AuthLoading>(),
        isA<Unauthenticated>(),
        isA<AuthLoading>(),
        isA<AuthError>(),
      ],
    );
  });

  group('ConfirmForgotPasswordRequested', () {
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, Unauthenticated] on success',
      setUp: () {
        when(mockRepository.getCurrentUser())
            .thenAnswer((_) async => right(null));
        when(mockRepository.confirmForgotPassword(
          email: testEmail,
          code: '123456',
          newPassword: testPassword,
        )).thenAnswer((_) async => right(unit));
      },
      build: () => AuthBloc(mockRepository),
      act: (bloc) => bloc.add(ConfirmForgotPasswordRequested(
        email: testEmail,
        code: '123456',
        newPassword: testPassword,
      )),
      expect: () => [
        isA<AuthLoading>(),
        isA<Unauthenticated>(),
        isA<AuthLoading>(),
        isA<Unauthenticated>(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthError] on failure',
      setUp: () {
        when(mockRepository.getCurrentUser())
            .thenAnswer((_) async => right(null));
        when(mockRepository.confirmForgotPassword(
          email: testEmail,
          code: 'wrong',
          newPassword: testPassword,
        )).thenAnswer((_) async => left(InvalidCredentials()));
      },
      build: () => AuthBloc(mockRepository),
      act: (bloc) => bloc.add(ConfirmForgotPasswordRequested(
        email: testEmail,
        code: 'wrong',
        newPassword: testPassword,
      )),
      expect: () => [
        isA<AuthLoading>(),
        isA<Unauthenticated>(),
        isA<AuthLoading>(),
        isA<AuthError>(),
      ],
    );
  });

  group('Error mapping', () {
    blocTest<AuthBloc, AuthState>(
      'maps InvalidCredentials exception correctly',
      setUp: () {
        when(mockRepository.getCurrentUser())
            .thenAnswer((_) async => right(null));
        when(mockRepository.signIn(email: testEmail, password: testPassword))
            .thenAnswer((_) async => left(InvalidCredentials()));
      },
      build: () => AuthBloc(mockRepository),
      act: (bloc) =>
          bloc.add(SignInRequested(email: testEmail, password: testPassword)),
      expect: () => [
        isA<AuthLoading>(),
        isA<Unauthenticated>(),
        isA<AuthLoading>(),
        isA<AuthError>(),
      ],
      verify: (bloc) {
        expect(bloc.state, isA<AuthError>());
        expect((bloc.state as AuthError).exception, isA<InvalidCredentials>());
      },
    );

    blocTest<AuthBloc, AuthState>(
      'maps EmailAlreadyExists exception correctly',
      setUp: () {
        when(mockRepository.getCurrentUser())
            .thenAnswer((_) async => right(null));
        when(mockRepository.signUp(email: testEmail, password: testPassword))
            .thenAnswer((_) async => left(EmailAlreadyExists()));
      },
      build: () => AuthBloc(mockRepository),
      act: (bloc) =>
          bloc.add(SignUpRequested(email: testEmail, password: testPassword)),
      expect: () => [
        isA<AuthLoading>(),
        isA<Unauthenticated>(),
        isA<AuthLoading>(),
        isA<AuthError>(),
      ],
      verify: (bloc) {
        expect(bloc.state, isA<AuthError>());
        expect(
            (bloc.state as AuthError).exception, isA<EmailAlreadyExists>());
      },
    );

    blocTest<AuthBloc, AuthState>(
      'maps NetworkError exception correctly',
      setUp: () {
        when(mockRepository.getCurrentUser())
            .thenAnswer((_) async => right(null));
        when(mockRepository.signIn(email: testEmail, password: testPassword))
            .thenAnswer((_) async => left(NetworkError()));
      },
      build: () => AuthBloc(mockRepository),
      act: (bloc) =>
          bloc.add(SignInRequested(email: testEmail, password: testPassword)),
      expect: () => [
        isA<AuthLoading>(),
        isA<Unauthenticated>(),
        isA<AuthLoading>(),
        isA<AuthError>(),
      ],
      verify: (bloc) {
        expect(bloc.state, isA<AuthError>());
        expect((bloc.state as AuthError).exception, isA<NetworkError>());
      },
    );

    blocTest<AuthBloc, AuthState>(
      'maps UserNotFound exception correctly',
      setUp: () {
        when(mockRepository.getCurrentUser())
            .thenAnswer((_) async => right(null));
        when(mockRepository.signIn(email: testEmail, password: testPassword))
            .thenAnswer((_) async => left(UserNotFound()));
      },
      build: () => AuthBloc(mockRepository),
      act: (bloc) =>
          bloc.add(SignInRequested(email: testEmail, password: testPassword)),
      expect: () => [
        isA<AuthLoading>(),
        isA<Unauthenticated>(),
        isA<AuthLoading>(),
        isA<AuthError>(),
      ],
      verify: (bloc) {
        expect(bloc.state, isA<AuthError>());
        expect((bloc.state as AuthError).exception, isA<UserNotFound>());
      },
    );

    blocTest<AuthBloc, AuthState>(
      'maps WeakPassword exception correctly',
      setUp: () {
        when(mockRepository.getCurrentUser())
            .thenAnswer((_) async => right(null));
        when(mockRepository.signUp(email: testEmail, password: testPassword))
            .thenAnswer((_) async => left(WeakPassword()));
      },
      build: () => AuthBloc(mockRepository),
      act: (bloc) =>
          bloc.add(SignUpRequested(email: testEmail, password: testPassword)),
      expect: () => [
        isA<AuthLoading>(),
        isA<Unauthenticated>(),
        isA<AuthLoading>(),
        isA<AuthError>(),
      ],
      verify: (bloc) {
        expect(bloc.state, isA<AuthError>());
        expect((bloc.state as AuthError).exception, isA<WeakPassword>());
      },
    );
  });
}
