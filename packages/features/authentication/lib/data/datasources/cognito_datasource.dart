import 'dart:io';

import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:authentication/data/datasources/auth_remote_datasource.dart';
import 'package:authentication/data/dtos/cognito_auth_result.dart';
import 'package:authentication/domain/exceptions/auth_exceptions.dart';

/// Factory function for creating [CognitoUser] instances.
/// Injected for testability — production code uses the default.
typedef CognitoUserFactory = CognitoUser Function(
  String email,
  CognitoUserPool pool,
);

/// AWS Cognito implementation of [AuthRemoteDataSource].
///
/// Wraps the `amazon_cognito_identity_dart_2` SDK and maps all
/// Cognito-specific exceptions to domain [AuthException] types.
///
/// DI registration is handled manually in bootstrap.dart because
/// injectable's code generation cannot discover cross-package annotations.
class CognitoDataSource implements AuthRemoteDataSource {
  CognitoDataSource({
    required CognitoUserPool userPool,
    CognitoUserFactory? userFactory,
  })  : _userPool = userPool,
        _userFactory = userFactory ?? (email, pool) => CognitoUser(email, pool);

  final CognitoUserPool _userPool;
  final CognitoUserFactory _userFactory;

  /// Tracks the currently signed-in user for [signOut].
  /// Note: mutable singleton state — avoid concurrent signIn/signOut calls.
  CognitoUser? _cognitoUser;

  @override
  Future<String> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _userPool.signUp(
        email,
        password,
        userAttributes: [
          AttributeArg(name: 'email', value: email),
        ],
      );
      final userSub = result.userSub;
      if (userSub == null || userSub.isEmpty) {
        throw NetworkError('Sign up succeeded but returned no user identifier');
      }
      return userSub;
    } on CognitoClientException catch (e) {
      throw _mapCognitoException(e);
    } on SocketException catch (e) {
      throw NetworkError(e.message);
    } catch (e) {
      throw NetworkError(e.toString());
    }
  }

  @override
  Future<void> confirmSignUp({
    required String email,
    required String confirmationCode,
  }) async {
    try {
      final cognitoUser = _userFactory(email, _userPool);
      await cognitoUser.confirmRegistration(confirmationCode);
    } on CognitoClientException catch (e) {
      throw _mapCognitoException(e);
    } on SocketException catch (e) {
      throw NetworkError(e.message);
    } catch (e) {
      throw NetworkError(e.toString());
    }
  }

  @override
  Future<CognitoAuthResult> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final cognitoUser = _userFactory(email, _userPool);
      cognitoUser.authenticationFlowType = 'USER_PASSWORD_AUTH';

      final session = await cognitoUser.authenticateUser(
        AuthenticationDetails(username: email, password: password),
      );

      if (session == null) {
        throw NetworkError('Authentication returned no session');
      }

      _cognitoUser = cognitoUser;

      return CognitoAuthResult(
        accessToken: session.getAccessToken().getJwtToken() ?? '',
        idToken: session.getIdToken().getJwtToken() ?? '',
        refreshToken: session.getRefreshToken()?.getToken() ?? '',
        userSub: session.getAccessToken().getSub() ?? '',
      );
    } on CognitoClientException catch (e) {
      throw _mapCognitoException(e);
    } on CognitoUserConfirmationNecessaryException {
      throw InvalidCredentials();
    } on SocketException catch (e) {
      throw NetworkError(e.message);
    } on AuthException {
      rethrow;
    } catch (e) {
      throw NetworkError(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      if (_cognitoUser != null) {
        await _cognitoUser!.signOut();
        _cognitoUser = null;
      }
    } on SocketException catch (e) {
      throw NetworkError(e.message);
    } catch (e) {
      throw NetworkError(e.toString());
    }
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    try {
      final cognitoUser = _userFactory(email, _userPool);
      await cognitoUser.forgotPassword();
    } on CognitoClientException catch (e) {
      // Never throw UserNotFound for security — swallow it
      if (e.code == 'UserNotFoundException') {
        return;
      }
      throw _mapCognitoException(e);
    } on SocketException catch (e) {
      throw NetworkError(e.message);
    } catch (_) {
      // Swallow all other exceptions to avoid potentially leaking user existence
      throw NetworkError('Unable to process password reset request');
    }
  }

  @override
  Future<void> confirmForgotPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    try {
      final cognitoUser = _userFactory(email, _userPool);
      await cognitoUser.confirmPassword(code, newPassword);
    } on CognitoClientException catch (e) {
      throw _mapCognitoException(e);
    } on SocketException catch (e) {
      throw NetworkError(e.message);
    } catch (e) {
      throw NetworkError(e.toString());
    }
  }

  @override
  Future<CognitoAuthResult?> getCurrentUser() async {
    try {
      final cognitoUser = await _userPool.getCurrentUser();
      if (cognitoUser == null) {
        return null;
      }

      final session = await cognitoUser.getSession();
      if (session == null || !session.isValid()) {
        return null;
      }

      _cognitoUser = cognitoUser;

      return CognitoAuthResult(
        accessToken: session.getAccessToken().getJwtToken() ?? '',
        idToken: session.getIdToken().getJwtToken() ?? '',
        refreshToken: session.getRefreshToken()?.getToken() ?? '',
        userSub: session.getAccessToken().getSub() ?? '',
      );
    } on SocketException catch (e) {
      throw NetworkError(e.message);
    } catch (e) {
      // No session available — return null instead of throwing
      return null;
    }
  }

  /// Maps [CognitoClientException] to domain [AuthException] types.
  AuthException _mapCognitoException(CognitoClientException e) {
    switch (e.code) {
      case 'UsernameExistsException':
        return EmailAlreadyExists();
      case 'InvalidPasswordException':
        return WeakPassword(e.message ?? 'Password does not meet requirements');
      case 'NotAuthorizedException':
        return InvalidCredentials();
      case 'UserNotFoundException':
        return UserNotFound();
      case 'CodeMismatchException':
        return InvalidCredentials();
      case 'ExpiredCodeException':
        return InvalidCredentials();
      case 'LimitExceededException':
        return NetworkError('Rate limit exceeded');
      case 'UserNotConfirmedException':
        return InvalidCredentials();
      default:
        return NetworkError(e.message ?? 'An unknown error occurred');
    }
  }
}
