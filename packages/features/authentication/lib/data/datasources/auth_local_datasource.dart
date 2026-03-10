import 'package:authentication/data/dtos/cognito_auth_result.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Abstract interface for local authentication token storage.
///
/// Provides secure persistence of Cognito auth tokens and user metadata
/// on the device. Used by [AuthRepositoryImpl] to maintain session state
/// across app launches.
abstract class AuthLocalDataSource {
  /// Persists all tokens from [result] along with the user's [email].
  Future<void> saveTokens(CognitoAuthResult result, String email);

  /// Returns stored tokens as a [CognitoAuthResult], or `null` if any
  /// token is missing.
  Future<CognitoAuthResult?> getTokens();

  /// Returns the stored user email, or `null` if not present.
  Future<String?> getUserEmail();

  /// Returns the stored user sub (UUID), or `null` if not present.
  Future<String?> getUserSub();

  /// Deletes all stored tokens and user metadata.
  Future<void> clearTokens();

  /// Returns `true` if all required tokens are present in storage.
  Future<bool> hasTokens();
}

/// [AuthLocalDataSource] backed by [FlutterSecureStorage].
///
/// Stores access, ID, and refresh tokens plus user sub and email under
/// well-known keys prefixed with `auth_`.
class SecureStorageAuthLocalDataSource implements AuthLocalDataSource {
  SecureStorageAuthLocalDataSource({required FlutterSecureStorage secureStorage})
      : _secureStorage = secureStorage;

  final FlutterSecureStorage _secureStorage;

  static const _accessTokenKey = 'auth_access_token';
  static const _idTokenKey = 'auth_id_token';
  static const _refreshTokenKey = 'auth_refresh_token';
  static const _userSubKey = 'auth_user_sub';
  static const _userEmailKey = 'auth_user_email';

  @override
  Future<void> saveTokens(CognitoAuthResult result, String email) async {
    await Future.wait([
      _secureStorage.write(key: _accessTokenKey, value: result.accessToken),
      _secureStorage.write(key: _idTokenKey, value: result.idToken),
      _secureStorage.write(key: _refreshTokenKey, value: result.refreshToken),
      _secureStorage.write(key: _userSubKey, value: result.userSub),
      _secureStorage.write(key: _userEmailKey, value: email),
    ]);
  }

  @override
  Future<CognitoAuthResult?> getTokens() async {
    final results = await Future.wait([
      _secureStorage.read(key: _accessTokenKey),
      _secureStorage.read(key: _idTokenKey),
      _secureStorage.read(key: _refreshTokenKey),
      _secureStorage.read(key: _userSubKey),
    ]);

    final accessToken = results[0];
    final idToken = results[1];
    final refreshToken = results[2];
    final userSub = results[3];

    if (accessToken == null ||
        idToken == null ||
        refreshToken == null ||
        userSub == null) {
      return null;
    }

    return CognitoAuthResult(
      accessToken: accessToken,
      idToken: idToken,
      refreshToken: refreshToken,
      userSub: userSub,
    );
  }

  @override
  Future<String?> getUserEmail() async {
    return _secureStorage.read(key: _userEmailKey);
  }

  @override
  Future<String?> getUserSub() async {
    return _secureStorage.read(key: _userSubKey);
  }

  @override
  Future<void> clearTokens() async {
    await Future.wait([
      _secureStorage.delete(key: _accessTokenKey),
      _secureStorage.delete(key: _idTokenKey),
      _secureStorage.delete(key: _refreshTokenKey),
      _secureStorage.delete(key: _userSubKey),
      _secureStorage.delete(key: _userEmailKey),
    ]);
  }

  @override
  Future<bool> hasTokens() async {
    final results = await Future.wait([
      _secureStorage.read(key: _accessTokenKey),
      _secureStorage.read(key: _idTokenKey),
      _secureStorage.read(key: _refreshTokenKey),
      _secureStorage.read(key: _userSubKey),
    ]);

    return results.every((value) => value != null);
  }
}
