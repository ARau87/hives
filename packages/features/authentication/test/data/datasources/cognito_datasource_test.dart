import 'dart:convert';
import 'dart:io';

import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:authentication/authentication.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([CognitoUserPool, CognitoUser, CognitoUserSession])
import 'cognito_datasource_test.mocks.dart';

void main() {
  late CognitoDataSource dataSource;
  late MockCognitoUserPool mockPool;
  late MockCognitoUser mockUser;
  late MockCognitoUserSession mockSession;

  setUp(() {
    mockPool = MockCognitoUserPool();
    mockUser = MockCognitoUser();
    mockSession = MockCognitoUserSession();
    dataSource = CognitoDataSource(
      userPool: mockPool,
      userFactory: (_, __) => mockUser,
    );
  });

  group('signUp', () {
    test('returns user sub on success', () async {
      final mockSignUpUser = MockCognitoUser();
      final poolData = CognitoUserPoolData(mockSignUpUser, userSub: 'test-uuid-123');

      when(mockPool.signUp(
        any,
        any,
        userAttributes: anyNamed('userAttributes'),
      )).thenAnswer((_) async => poolData);

      final result = await dataSource.signUp(
        email: 'test@example.com',
        password: 'Password1',
      );

      expect(result, 'test-uuid-123');
    });

    test('throws NetworkError when userSub is null', () async {
      final mockSignUpUser = MockCognitoUser();
      final poolData = CognitoUserPoolData(mockSignUpUser, userSub: null);

      when(mockPool.signUp(
        any,
        any,
        userAttributes: anyNamed('userAttributes'),
      )).thenAnswer((_) async => poolData);

      await expectLater(
        () => dataSource.signUp(email: 'test@example.com', password: 'Password1'),
        throwsA(isA<NetworkError>()),
      );
    });

    test('throws EmailAlreadyExists on duplicate email', () async {
      when(mockPool.signUp(
        any,
        any,
        userAttributes: anyNamed('userAttributes'),
      )).thenThrow(CognitoClientException(
        'User already exists',
        code: 'UsernameExistsException',
      ));

      await expectLater(
        () => dataSource.signUp(
          email: 'existing@example.com',
          password: 'Password1',
        ),
        throwsA(isA<EmailAlreadyExists>()),
      );
    });

    test('throws WeakPassword on invalid password', () async {
      when(mockPool.signUp(
        any,
        any,
        userAttributes: anyNamed('userAttributes'),
      )).thenThrow(CognitoClientException(
        'Password too short',
        code: 'InvalidPasswordException',
      ));

      await expectLater(
        () => dataSource.signUp(
          email: 'test@example.com',
          password: 'weak',
        ),
        throwsA(isA<WeakPassword>()),
      );
    });

    test('throws NetworkError on connection failure', () async {
      when(mockPool.signUp(
        any,
        any,
        userAttributes: anyNamed('userAttributes'),
      )).thenThrow(const SocketException('Connection refused'));

      await expectLater(
        () => dataSource.signUp(
          email: 'test@example.com',
          password: 'Password1',
        ),
        throwsA(isA<NetworkError>()),
      );
    });

    test('throws NetworkError on rate limit exceeded', () async {
      when(mockPool.signUp(
        any,
        any,
        userAttributes: anyNamed('userAttributes'),
      )).thenThrow(CognitoClientException(
        'Rate exceeded',
        code: 'LimitExceededException',
      ));

      await expectLater(
        () => dataSource.signUp(
          email: 'test@example.com',
          password: 'Password1',
        ),
        throwsA(isA<NetworkError>()),
      );
    });
  });

  group('confirmSignUp', () {
    test('completes successfully with valid code', () async {
      when(mockUser.confirmRegistration(any)).thenAnswer((_) async => true);

      await expectLater(
        dataSource.confirmSignUp(
          email: 'test@example.com',
          confirmationCode: '123456',
        ),
        completes,
      );
    });

    test('throws InvalidCredentials on code mismatch', () async {
      when(mockUser.confirmRegistration(any)).thenThrow(
        CognitoClientException('Wrong code', code: 'CodeMismatchException'),
      );

      await expectLater(
        () => dataSource.confirmSignUp(
          email: 'test@example.com',
          confirmationCode: 'wrong',
        ),
        throwsA(isA<InvalidCredentials>()),
      );
    });

    test('throws InvalidCredentials on expired code', () async {
      when(mockUser.confirmRegistration(any)).thenThrow(
        CognitoClientException('Expired', code: 'ExpiredCodeException'),
      );

      await expectLater(
        () => dataSource.confirmSignUp(
          email: 'test@example.com',
          confirmationCode: 'expired',
        ),
        throwsA(isA<InvalidCredentials>()),
      );
    });

    test('throws NetworkError on connection failure', () async {
      when(mockUser.confirmRegistration(any))
          .thenThrow(const SocketException('No network'));

      await expectLater(
        () => dataSource.confirmSignUp(
          email: 'test@example.com',
          confirmationCode: '123456',
        ),
        throwsA(isA<NetworkError>()),
      );
    });
  });

  group('signIn', () {
    test('returns CognitoAuthResult on success', () async {
      final accessJwt = _fakeJwt(sub: 'user-sub-123');
      final idJwt = _fakeJwt(sub: 'user-sub-123');

      when(mockUser.authenticateUser(any)).thenAnswer((_) async => mockSession);
      when(mockSession.getAccessToken()).thenReturn(CognitoAccessToken(accessJwt));
      when(mockSession.getIdToken()).thenReturn(CognitoIdToken(idJwt));
      when(mockSession.getRefreshToken()).thenReturn(CognitoRefreshToken('refresh-token'));

      final result = await dataSource.signIn(
        email: 'test@example.com',
        password: 'Password1!',
      );

      expect(result.accessToken, accessJwt);
      expect(result.idToken, idJwt);
      expect(result.refreshToken, 'refresh-token');
      expect(result.userSub, 'user-sub-123');
    });

    test('throws NetworkError when session is null', () async {
      when(mockUser.authenticateUser(any)).thenAnswer((_) async => null);

      await expectLater(
        () => dataSource.signIn(email: 'test@example.com', password: 'Password1!'),
        throwsA(isA<NetworkError>()),
      );
    });

    test('throws InvalidCredentials on wrong password', () async {
      when(mockUser.authenticateUser(any)).thenThrow(
        CognitoClientException('Wrong password', code: 'NotAuthorizedException'),
      );

      await expectLater(
        () => dataSource.signIn(email: 'test@example.com', password: 'wrong'),
        throwsA(isA<InvalidCredentials>()),
      );
    });

    test('throws UserNotFound when user does not exist', () async {
      when(mockUser.authenticateUser(any)).thenThrow(
        CognitoClientException('User not found', code: 'UserNotFoundException'),
      );

      await expectLater(
        () => dataSource.signIn(email: 'unknown@example.com', password: 'Password1!'),
        throwsA(isA<UserNotFound>()),
      );
    });

    test('throws InvalidCredentials when user not confirmed', () async {
      when(mockUser.authenticateUser(any))
          .thenThrow(CognitoUserConfirmationNecessaryException());

      await expectLater(
        () => dataSource.signIn(email: 'test@example.com', password: 'Password1!'),
        throwsA(isA<InvalidCredentials>()),
      );
    });

    test('throws NetworkError on connection failure', () async {
      when(mockUser.authenticateUser(any))
          .thenThrow(const SocketException('No network'));

      await expectLater(
        () => dataSource.signIn(email: 'test@example.com', password: 'Password1!'),
        throwsA(isA<NetworkError>()),
      );
    });
  });

  group('signOut', () {
    test('completes successfully when no user is signed in', () async {
      await expectLater(dataSource.signOut(), completes);
    });

    test('calls signOut on CognitoUser when signed in', () async {
      // Set _cognitoUser by completing a successful getCurrentUser
      final jwt = _fakeJwt(sub: 'user-sub');
      when(mockPool.getCurrentUser()).thenAnswer((_) async => mockUser);
      when(mockUser.getSession()).thenAnswer((_) async => mockSession);
      when(mockSession.isValid()).thenReturn(true);
      when(mockSession.getAccessToken()).thenReturn(CognitoAccessToken(jwt));
      when(mockSession.getIdToken()).thenReturn(CognitoIdToken(jwt));
      when(mockSession.getRefreshToken()).thenReturn(CognitoRefreshToken('refresh'));
      when(mockUser.signOut()).thenAnswer((_) async {});

      await dataSource.getCurrentUser(); // sets _cognitoUser = mockUser
      await dataSource.signOut();

      verify(mockUser.signOut()).called(1);
    });
  });

  group('forgotPassword', () {
    test('completes successfully for known email', () async {
      when(mockUser.forgotPassword()).thenAnswer((_) async {});

      await expectLater(
        dataSource.forgotPassword(email: 'test@example.com'),
        completes,
      );
    });

    test('swallows UserNotFoundException for security (unknown email)', () async {
      when(mockUser.forgotPassword()).thenThrow(
        CognitoClientException('User not found', code: 'UserNotFoundException'),
      );

      // Must complete without throwing — never reveals if email exists
      await expectLater(
        dataSource.forgotPassword(email: 'unknown@example.com'),
        completes,
      );
    });

    test('throws NetworkError on connection failure', () async {
      when(mockUser.forgotPassword())
          .thenThrow(const SocketException('No network'));

      await expectLater(
        () => dataSource.forgotPassword(email: 'test@example.com'),
        throwsA(isA<NetworkError>()),
      );
    });
  });

  group('confirmForgotPassword', () {
    test('completes successfully with valid code', () async {
      when(mockUser.confirmPassword(any, any)).thenAnswer((_) async => true);

      await expectLater(
        dataSource.confirmForgotPassword(
          email: 'test@example.com',
          code: '123456',
          newPassword: 'NewPassword1!',
        ),
        completes,
      );
    });

    test('throws InvalidCredentials on code mismatch', () async {
      when(mockUser.confirmPassword(any, any)).thenThrow(
        CognitoClientException('Wrong code', code: 'CodeMismatchException'),
      );

      await expectLater(
        () => dataSource.confirmForgotPassword(
          email: 'test@example.com',
          code: 'wrong',
          newPassword: 'NewPassword1!',
        ),
        throwsA(isA<InvalidCredentials>()),
      );
    });

    test('throws WeakPassword on invalid new password', () async {
      when(mockUser.confirmPassword(any, any)).thenThrow(
        CognitoClientException('Too weak', code: 'InvalidPasswordException'),
      );

      await expectLater(
        () => dataSource.confirmForgotPassword(
          email: 'test@example.com',
          code: '123456',
          newPassword: 'weak',
        ),
        throwsA(isA<WeakPassword>()),
      );
    });

    test('throws NetworkError on connection failure', () async {
      when(mockUser.confirmPassword(any, any))
          .thenThrow(const SocketException('No network'));

      await expectLater(
        () => dataSource.confirmForgotPassword(
          email: 'test@example.com',
          code: '123456',
          newPassword: 'NewPassword1!',
        ),
        throwsA(isA<NetworkError>()),
      );
    });
  });

  group('getCurrentUser', () {
    test('returns null when no current user', () async {
      when(mockPool.getCurrentUser()).thenAnswer((_) async => null);

      final result = await dataSource.getCurrentUser();

      expect(result, isNull);
    });

    test('returns CognitoAuthResult when session is valid', () async {
      when(mockPool.getCurrentUser()).thenAnswer((_) async => mockUser);
      when(mockUser.getSession()).thenAnswer((_) async => mockSession);
      when(mockSession.isValid()).thenReturn(true);

      final accessJwt = _fakeJwt(sub: 'user-sub-123');
      final idJwt = _fakeJwt(sub: 'user-sub-123');
      final mockAccessToken = CognitoAccessToken(accessJwt);
      final mockIdToken = CognitoIdToken(idJwt);
      final mockRefreshToken = CognitoRefreshToken('refresh-token');

      when(mockSession.getAccessToken()).thenReturn(mockAccessToken);
      when(mockSession.getIdToken()).thenReturn(mockIdToken);
      when(mockSession.getRefreshToken()).thenReturn(mockRefreshToken);

      final result = await dataSource.getCurrentUser();

      expect(result, isNotNull);
      expect(result!.accessToken, accessJwt);
      expect(result.idToken, idJwt);
      expect(result.refreshToken, 'refresh-token');
      expect(result.userSub, 'user-sub-123');
    });

    test('returns null when session is invalid', () async {
      when(mockPool.getCurrentUser()).thenAnswer((_) async => mockUser);
      when(mockUser.getSession()).thenAnswer((_) async => mockSession);
      when(mockSession.isValid()).thenReturn(false);

      final result = await dataSource.getCurrentUser();

      expect(result, isNull);
    });

    test('returns null when getSession throws', () async {
      when(mockPool.getCurrentUser()).thenAnswer((_) async => mockUser);
      when(mockUser.getSession()).thenThrow(Exception('No cached tokens'));

      final result = await dataSource.getCurrentUser();

      expect(result, isNull);
    });
  });

  group('_mapCognitoException', () {
    // Test the exception mapping indirectly through signUp
    // since _mapCognitoException is private.

    test('maps UsernameExistsException to EmailAlreadyExists', () async {
      when(mockPool.signUp(any, any, userAttributes: anyNamed('userAttributes')))
          .thenThrow(CognitoClientException('msg', code: 'UsernameExistsException'));

      await expectLater(
        () => dataSource.signUp(email: 'e@e.com', password: 'P1aaaaaaa'),
        throwsA(isA<EmailAlreadyExists>()),
      );
    });

    test('maps InvalidPasswordException to WeakPassword', () async {
      when(mockPool.signUp(any, any, userAttributes: anyNamed('userAttributes')))
          .thenThrow(CognitoClientException('too short', code: 'InvalidPasswordException'));

      await expectLater(
        () => dataSource.signUp(email: 'e@e.com', password: 'P1aaaaaaa'),
        throwsA(isA<WeakPassword>()),
      );
    });

    test('maps NotAuthorizedException to InvalidCredentials', () async {
      when(mockPool.signUp(any, any, userAttributes: anyNamed('userAttributes')))
          .thenThrow(CognitoClientException('msg', code: 'NotAuthorizedException'));

      await expectLater(
        () => dataSource.signUp(email: 'e@e.com', password: 'P1aaaaaaa'),
        throwsA(isA<InvalidCredentials>()),
      );
    });

    test('maps UserNotFoundException to UserNotFound', () async {
      when(mockPool.signUp(any, any, userAttributes: anyNamed('userAttributes')))
          .thenThrow(CognitoClientException('msg', code: 'UserNotFoundException'));

      await expectLater(
        () => dataSource.signUp(email: 'e@e.com', password: 'P1aaaaaaa'),
        throwsA(isA<UserNotFound>()),
      );
    });

    test('maps CodeMismatchException to InvalidCredentials', () async {
      when(mockPool.signUp(any, any, userAttributes: anyNamed('userAttributes')))
          .thenThrow(CognitoClientException('msg', code: 'CodeMismatchException'));

      await expectLater(
        () => dataSource.signUp(email: 'e@e.com', password: 'P1aaaaaaa'),
        throwsA(isA<InvalidCredentials>()),
      );
    });

    test('maps ExpiredCodeException to InvalidCredentials', () async {
      when(mockPool.signUp(any, any, userAttributes: anyNamed('userAttributes')))
          .thenThrow(CognitoClientException('msg', code: 'ExpiredCodeException'));

      await expectLater(
        () => dataSource.signUp(email: 'e@e.com', password: 'P1aaaaaaa'),
        throwsA(isA<InvalidCredentials>()),
      );
    });

    test('maps LimitExceededException to NetworkError', () async {
      when(mockPool.signUp(any, any, userAttributes: anyNamed('userAttributes')))
          .thenThrow(CognitoClientException('msg', code: 'LimitExceededException'));

      await expectLater(
        () => dataSource.signUp(email: 'e@e.com', password: 'P1aaaaaaa'),
        throwsA(isA<NetworkError>()),
      );
    });

    test('maps UserNotConfirmedException to InvalidCredentials', () async {
      when(mockPool.signUp(any, any, userAttributes: anyNamed('userAttributes')))
          .thenThrow(CognitoClientException('msg', code: 'UserNotConfirmedException'));

      await expectLater(
        () => dataSource.signUp(email: 'e@e.com', password: 'P1aaaaaaa'),
        throwsA(isA<InvalidCredentials>()),
      );
    });

    test('maps unknown exception to NetworkError', () async {
      when(mockPool.signUp(any, any, userAttributes: anyNamed('userAttributes')))
          .thenThrow(CognitoClientException('msg', code: 'SomeUnknownException'));

      await expectLater(
        () => dataSource.signUp(email: 'e@e.com', password: 'P1aaaaaaa'),
        throwsA(isA<NetworkError>()),
      );
    });
  });
}

/// Creates a fake JWT token string with the given [sub] claim.
String _fakeJwt({String sub = 'test-sub', int? exp, int? iat}) {
  final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  final payload = {
    'sub': sub,
    'exp': exp ?? now + 3600,
    'iat': iat ?? now,
  };
  final encodedPayload = base64Url.encode(utf8.encode(json.encode(payload)));
  return 'header.$encodedPayload.signature';
}
