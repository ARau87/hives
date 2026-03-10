import 'package:authentication/data/datasources/auth_local_datasource.dart';
import 'package:authentication/data/datasources/auth_remote_datasource.dart';
import 'package:authentication/data/dtos/cognito_auth_result.dart';
import 'package:authentication/data/repositories/auth_repository_impl.dart';
import 'package:authentication/domain/events/auth_events.dart';
import 'package:authentication/domain/exceptions/auth_exceptions.dart';
import 'package:authentication/domain/value_objects/email.dart';
import 'package:authentication/domain/value_objects/password.dart';
import 'package:core_infrastructure/core_infrastructure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([AuthRemoteDataSource, AuthLocalDataSource, EventBus])
import 'auth_repository_impl_test.mocks.dart';

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockRemoteDataSource;
  late MockAuthLocalDataSource mockLocalDataSource;
  late MockEventBus mockEventBus;

  final testEmail = Email.create('test@example.com').getOrElse((_) => throw Exception('Invalid test email'));
  final testPassword = Password.create('Password1').getOrElse((_) => throw Exception('Invalid test password'));

  const testAuthResult = CognitoAuthResult(
    accessToken: 'access-token',
    idToken: 'id-token',
    refreshToken: 'refresh-token',
    userSub: '550e8400-e29b-41d4-a716-446655440000',
  );

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    mockLocalDataSource = MockAuthLocalDataSource();
    mockEventBus = MockEventBus();
    repository = AuthRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      eventBus: mockEventBus,
    );
  });

  group('signUp', () {
    test('returns Right(UserAggregate) on success', () async {
      when(mockRemoteDataSource.signUp(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => '550e8400-e29b-41d4-a716-446655440000');

      final result = await repository.signUp(
        email: testEmail,
        password: testPassword,
      );

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (user) {
          expect(user.id.value, '550e8400-e29b-41d4-a716-446655440000');
          expect(user.email.value, 'test@example.com');
        },
      );
    });

    test('returns Left(EmailAlreadyExists) when email taken', () async {
      when(mockRemoteDataSource.signUp(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenThrow(EmailAlreadyExists());

      final result = await repository.signUp(
        email: testEmail,
        password: testPassword,
      );

      expect(result.isLeft(), isTrue);
      result.fold(
        (e) => expect(e, isA<EmailAlreadyExists>()),
        (_) => fail('Expected Left'),
      );
    });

    test('returns Left(NetworkError) on unexpected exception', () async {
      when(mockRemoteDataSource.signUp(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenThrow(Exception('Connection failed'));

      final result = await repository.signUp(
        email: testEmail,
        password: testPassword,
      );

      expect(result.isLeft(), isTrue);
      result.fold(
        (e) => expect(e, isA<NetworkError>()),
        (_) => fail('Expected Left'),
      );
    });
  });

  group('signIn', () {
    test('returns Right(UserAggregate) on success', () async {
      when(mockRemoteDataSource.signIn(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => testAuthResult);
      when(mockLocalDataSource.saveTokens(any, any))
          .thenAnswer((_) async {});
      when(mockEventBus.publish(any)).thenReturn(null);

      final result = await repository.signIn(
        email: testEmail,
        password: testPassword,
      );

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (user) {
          expect(user.id.value, '550e8400-e29b-41d4-a716-446655440000');
          expect(user.email.value, 'test@example.com');
        },
      );
    });

    test('saves tokens on success', () async {
      when(mockRemoteDataSource.signIn(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => testAuthResult);
      when(mockLocalDataSource.saveTokens(any, any))
          .thenAnswer((_) async {});
      when(mockEventBus.publish(any)).thenReturn(null);

      await repository.signIn(email: testEmail, password: testPassword);

      verify(mockLocalDataSource.saveTokens(testAuthResult, 'test@example.com'))
          .called(1);
    });

    test('publishes AuthUserLoggedIn on success', () async {
      when(mockRemoteDataSource.signIn(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => testAuthResult);
      when(mockLocalDataSource.saveTokens(any, any))
          .thenAnswer((_) async {});
      when(mockEventBus.publish(any)).thenReturn(null);

      await repository.signIn(email: testEmail, password: testPassword);

      final captured =
          verify(mockEventBus.publish(captureAny)).captured.single;
      expect(captured, isA<AuthUserLoggedIn>());
      expect(
        (captured as AuthUserLoggedIn).userId.value,
        '550e8400-e29b-41d4-a716-446655440000',
      );
    });

    test('returns Left(InvalidCredentials) on wrong password', () async {
      when(mockRemoteDataSource.signIn(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenThrow(InvalidCredentials());

      final result = await repository.signIn(
        email: testEmail,
        password: testPassword,
      );

      expect(result.isLeft(), isTrue);
      result.fold(
        (e) => expect(e, isA<InvalidCredentials>()),
        (_) => fail('Expected Left'),
      );
    });

    test('does not save tokens on failure', () async {
      when(mockRemoteDataSource.signIn(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenThrow(InvalidCredentials());

      await repository.signIn(email: testEmail, password: testPassword);

      verifyNever(mockLocalDataSource.saveTokens(any, any));
    });

    test('does not publish event on failure', () async {
      when(mockRemoteDataSource.signIn(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenThrow(InvalidCredentials());

      await repository.signIn(email: testEmail, password: testPassword);

      verifyNever(mockEventBus.publish(any));
    });
  });

  group('signOut', () {
    test('returns Right(unit) on success', () async {
      when(mockLocalDataSource.getUserSub())
          .thenAnswer((_) async => '550e8400-e29b-41d4-a716-446655440000');
      when(mockRemoteDataSource.signOut()).thenAnswer((_) async {});
      when(mockLocalDataSource.clearTokens()).thenAnswer((_) async {});
      when(mockEventBus.publish(any)).thenReturn(null);

      final result = await repository.signOut();

      expect(result.isRight(), isTrue);
    });

    test('clears tokens on success', () async {
      when(mockLocalDataSource.getUserSub())
          .thenAnswer((_) async => '550e8400-e29b-41d4-a716-446655440000');
      when(mockRemoteDataSource.signOut()).thenAnswer((_) async {});
      when(mockLocalDataSource.clearTokens()).thenAnswer((_) async {});
      when(mockEventBus.publish(any)).thenReturn(null);

      await repository.signOut();

      verify(mockLocalDataSource.clearTokens()).called(1);
    });

    test('publishes AuthUserLoggedOut on success', () async {
      when(mockLocalDataSource.getUserSub())
          .thenAnswer((_) async => '550e8400-e29b-41d4-a716-446655440000');
      when(mockRemoteDataSource.signOut()).thenAnswer((_) async {});
      when(mockLocalDataSource.clearTokens()).thenAnswer((_) async {});
      when(mockEventBus.publish(any)).thenReturn(null);

      await repository.signOut();

      final captured =
          verify(mockEventBus.publish(captureAny)).captured.single;
      expect(captured, isA<AuthUserLoggedOut>());
      expect(
        (captured as AuthUserLoggedOut).userId.value,
        '550e8400-e29b-41d4-a716-446655440000',
      );
    });

    test('clears tokens even when remote sign-out fails', () async {
      when(mockLocalDataSource.getUserSub())
          .thenAnswer((_) async => '550e8400-e29b-41d4-a716-446655440000');
      when(mockRemoteDataSource.signOut()).thenThrow(NetworkError());
      when(mockLocalDataSource.clearTokens()).thenAnswer((_) async {});

      final result = await repository.signOut();

      expect(result.isLeft(), isTrue);
      result.fold(
        (e) => expect(e, isA<NetworkError>()),
        (_) => fail('Expected Left'),
      );
      verify(mockLocalDataSource.clearTokens()).called(1);
    });

    test('returns Right(unit) when userSub is null (no event published)', () async {
      when(mockLocalDataSource.getUserSub()).thenAnswer((_) async => null);
      when(mockRemoteDataSource.signOut()).thenAnswer((_) async {});
      when(mockLocalDataSource.clearTokens()).thenAnswer((_) async {});

      final result = await repository.signOut();

      expect(result.isRight(), isTrue);
      verify(mockLocalDataSource.clearTokens()).called(1);
      verifyNever(mockEventBus.publish(any));
    });
  });

  group('getCurrentUser', () {
    test('returns Right(UserAggregate) with valid tokens', () async {
      when(mockLocalDataSource.hasTokens()).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getCurrentUser())
          .thenAnswer((_) async => testAuthResult);
      when(mockLocalDataSource.getUserEmail())
          .thenAnswer((_) async => 'test@example.com');
      when(mockLocalDataSource.saveTokens(any, any))
          .thenAnswer((_) async {});

      final result = await repository.getCurrentUser();

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (user) {
          expect(user, isNotNull);
          expect(user!.id.value, '550e8400-e29b-41d4-a716-446655440000');
          expect(user.email.value, 'test@example.com');
        },
      );
    });

    test('returns Right(null) when no tokens stored', () async {
      when(mockLocalDataSource.hasTokens()).thenAnswer((_) async => false);

      final result = await repository.getCurrentUser();

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (user) => expect(user, isNull),
      );
      verifyNever(mockRemoteDataSource.getCurrentUser());
    });

    test('returns Right(null) and clears tokens when expired', () async {
      when(mockLocalDataSource.hasTokens()).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getCurrentUser())
          .thenAnswer((_) async => null);
      when(mockLocalDataSource.clearTokens()).thenAnswer((_) async {});

      final result = await repository.getCurrentUser();

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (user) => expect(user, isNull),
      );
      verify(mockLocalDataSource.clearTokens()).called(1);
    });

    test('returns Right(null) and clears tokens when email missing', () async {
      when(mockLocalDataSource.hasTokens()).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getCurrentUser())
          .thenAnswer((_) async => testAuthResult);
      when(mockLocalDataSource.getUserEmail())
          .thenAnswer((_) async => null);
      when(mockLocalDataSource.clearTokens()).thenAnswer((_) async {});

      final result = await repository.getCurrentUser();

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (user) => expect(user, isNull),
      );
      verify(mockLocalDataSource.clearTokens()).called(1);
    });

    test('returns Left(AuthException) on error', () async {
      when(mockLocalDataSource.hasTokens()).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getCurrentUser()).thenThrow(NetworkError());

      final result = await repository.getCurrentUser();

      expect(result.isLeft(), isTrue);
      result.fold(
        (e) => expect(e, isA<NetworkError>()),
        (_) => fail('Expected Left'),
      );
    });
  });

  group('resetPassword', () {
    test('returns Right(unit) on success', () async {
      when(mockRemoteDataSource.forgotPassword(email: anyNamed('email')))
          .thenAnswer((_) async {});

      final result = await repository.resetPassword(email: testEmail);

      expect(result.isRight(), isTrue);
      verify(mockRemoteDataSource.forgotPassword(email: 'test@example.com'))
          .called(1);
    });

    test('returns Left(AuthException) on error', () async {
      when(mockRemoteDataSource.forgotPassword(email: anyNamed('email')))
          .thenThrow(NetworkError());

      final result = await repository.resetPassword(email: testEmail);

      expect(result.isLeft(), isTrue);
      result.fold(
        (e) => expect(e, isA<NetworkError>()),
        (_) => fail('Expected Left'),
      );
    });
  });

  group('confirmSignUp', () {
    test('returns Right(unit) on success', () async {
      when(mockRemoteDataSource.confirmSignUp(
        email: anyNamed('email'),
        confirmationCode: anyNamed('confirmationCode'),
      )).thenAnswer((_) async {});

      final result = await repository.confirmSignUp(
        email: testEmail,
        confirmationCode: '123456',
      );

      expect(result.isRight(), isTrue);
      verify(mockRemoteDataSource.confirmSignUp(
        email: 'test@example.com',
        confirmationCode: '123456',
      )).called(1);
    });

    test('returns Left(InvalidCredentials) on invalid code', () async {
      when(mockRemoteDataSource.confirmSignUp(
        email: anyNamed('email'),
        confirmationCode: anyNamed('confirmationCode'),
      )).thenThrow(InvalidCredentials());

      final result = await repository.confirmSignUp(
        email: testEmail,
        confirmationCode: 'wrong',
      );

      expect(result.isLeft(), isTrue);
      result.fold(
        (e) => expect(e, isA<InvalidCredentials>()),
        (_) => fail('Expected Left'),
      );
    });
  });

  group('confirmForgotPassword', () {
    test('returns Right(unit) on success', () async {
      when(mockRemoteDataSource.confirmForgotPassword(
        email: anyNamed('email'),
        code: anyNamed('code'),
        newPassword: anyNamed('newPassword'),
      )).thenAnswer((_) async {});

      final result = await repository.confirmForgotPassword(
        email: testEmail,
        code: '123456',
        newPassword: testPassword,
      );

      expect(result.isRight(), isTrue);
      verify(mockRemoteDataSource.confirmForgotPassword(
        email: 'test@example.com',
        code: '123456',
        newPassword: 'Password1',
      )).called(1);
    });

    test('returns Left(InvalidCredentials) on invalid code', () async {
      when(mockRemoteDataSource.confirmForgotPassword(
        email: anyNamed('email'),
        code: anyNamed('code'),
        newPassword: anyNamed('newPassword'),
      )).thenThrow(InvalidCredentials());

      final result = await repository.confirmForgotPassword(
        email: testEmail,
        code: 'wrong',
        newPassword: testPassword,
      );

      expect(result.isLeft(), isTrue);
      result.fold(
        (e) => expect(e, isA<InvalidCredentials>()),
        (_) => fail('Expected Left'),
      );
    });
  });
}
