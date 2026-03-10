import 'package:authentication/data/datasources/auth_local_datasource.dart';
import 'package:authentication/data/dtos/cognito_auth_result.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([FlutterSecureStorage])
import 'auth_local_datasource_test.mocks.dart';

void main() {
  late SecureStorageAuthLocalDataSource dataSource;
  late MockFlutterSecureStorage mockStorage;

  setUp(() {
    mockStorage = MockFlutterSecureStorage();
    dataSource = SecureStorageAuthLocalDataSource(secureStorage: mockStorage);
  });

  const testResult = CognitoAuthResult(
    accessToken: 'access-token-123',
    idToken: 'id-token-456',
    refreshToken: 'refresh-token-789',
    userSub: 'user-sub-abc',
  );
  const testEmail = 'test@example.com';

  group('saveTokens', () {
    test('writes all 5 keys to secure storage', () async {
      when(mockStorage.write(key: anyNamed('key'), value: anyNamed('value')))
          .thenAnswer((_) async {});

      await dataSource.saveTokens(testResult, testEmail);

      verify(mockStorage.write(
        key: 'auth_access_token',
        value: 'access-token-123',
      )).called(1);
      verify(mockStorage.write(
        key: 'auth_id_token',
        value: 'id-token-456',
      )).called(1);
      verify(mockStorage.write(
        key: 'auth_refresh_token',
        value: 'refresh-token-789',
      )).called(1);
      verify(mockStorage.write(
        key: 'auth_user_sub',
        value: 'user-sub-abc',
      )).called(1);
      verify(mockStorage.write(
        key: 'auth_user_email',
        value: 'test@example.com',
      )).called(1);
      verifyNoMoreInteractions(mockStorage);
    });
  });

  group('getTokens', () {
    test('returns CognitoAuthResult when all tokens exist', () async {
      when(mockStorage.read(key: 'auth_access_token'))
          .thenAnswer((_) async => 'access-token-123');
      when(mockStorage.read(key: 'auth_id_token'))
          .thenAnswer((_) async => 'id-token-456');
      when(mockStorage.read(key: 'auth_refresh_token'))
          .thenAnswer((_) async => 'refresh-token-789');
      when(mockStorage.read(key: 'auth_user_sub'))
          .thenAnswer((_) async => 'user-sub-abc');

      final result = await dataSource.getTokens();

      expect(result, isNotNull);
      expect(result!.accessToken, 'access-token-123');
      expect(result.idToken, 'id-token-456');
      expect(result.refreshToken, 'refresh-token-789');
      expect(result.userSub, 'user-sub-abc');
    });

    test('returns null when access token is missing', () async {
      when(mockStorage.read(key: 'auth_access_token'))
          .thenAnswer((_) async => null);
      when(mockStorage.read(key: 'auth_id_token'))
          .thenAnswer((_) async => 'id-token-456');
      when(mockStorage.read(key: 'auth_refresh_token'))
          .thenAnswer((_) async => 'refresh-token-789');
      when(mockStorage.read(key: 'auth_user_sub'))
          .thenAnswer((_) async => 'user-sub-abc');

      final result = await dataSource.getTokens();

      expect(result, isNull);
    });

    test('returns null when user sub is missing', () async {
      when(mockStorage.read(key: 'auth_access_token'))
          .thenAnswer((_) async => 'access-token-123');
      when(mockStorage.read(key: 'auth_id_token'))
          .thenAnswer((_) async => 'id-token-456');
      when(mockStorage.read(key: 'auth_refresh_token'))
          .thenAnswer((_) async => 'refresh-token-789');
      when(mockStorage.read(key: 'auth_user_sub'))
          .thenAnswer((_) async => null);

      final result = await dataSource.getTokens();

      expect(result, isNull);
    });
  });

  group('getUserEmail', () {
    test('returns email when stored', () async {
      when(mockStorage.read(key: 'auth_user_email'))
          .thenAnswer((_) async => testEmail);

      final result = await dataSource.getUserEmail();

      expect(result, testEmail);
    });

    test('returns null when not stored', () async {
      when(mockStorage.read(key: 'auth_user_email'))
          .thenAnswer((_) async => null);

      final result = await dataSource.getUserEmail();

      expect(result, isNull);
    });
  });

  group('getUserSub', () {
    test('returns user sub when stored', () async {
      when(mockStorage.read(key: 'auth_user_sub'))
          .thenAnswer((_) async => 'user-sub-abc');

      final result = await dataSource.getUserSub();

      expect(result, 'user-sub-abc');
    });
  });

  group('clearTokens', () {
    test('deletes all 5 keys from secure storage', () async {
      when(mockStorage.delete(key: anyNamed('key'))).thenAnswer((_) async {});

      await dataSource.clearTokens();

      verify(mockStorage.delete(key: 'auth_access_token')).called(1);
      verify(mockStorage.delete(key: 'auth_id_token')).called(1);
      verify(mockStorage.delete(key: 'auth_refresh_token')).called(1);
      verify(mockStorage.delete(key: 'auth_user_sub')).called(1);
      verify(mockStorage.delete(key: 'auth_user_email')).called(1);
      verifyNoMoreInteractions(mockStorage);
    });
  });

  group('hasTokens', () {
    test('returns true when all required tokens exist', () async {
      when(mockStorage.read(key: 'auth_access_token'))
          .thenAnswer((_) async => 'access-token-123');
      when(mockStorage.read(key: 'auth_id_token'))
          .thenAnswer((_) async => 'id-token-456');
      when(mockStorage.read(key: 'auth_refresh_token'))
          .thenAnswer((_) async => 'refresh-token-789');
      when(mockStorage.read(key: 'auth_user_sub'))
          .thenAnswer((_) async => 'user-sub-abc');

      final result = await dataSource.hasTokens();

      expect(result, isTrue);
    });

    test('returns false when access token is missing', () async {
      when(mockStorage.read(key: 'auth_access_token'))
          .thenAnswer((_) async => null);
      when(mockStorage.read(key: 'auth_id_token'))
          .thenAnswer((_) async => 'id-token-456');
      when(mockStorage.read(key: 'auth_refresh_token'))
          .thenAnswer((_) async => 'refresh-token-789');
      when(mockStorage.read(key: 'auth_user_sub'))
          .thenAnswer((_) async => 'user-sub-abc');

      final result = await dataSource.hasTokens();

      expect(result, isFalse);
    });

    test('returns false when id token is missing', () async {
      when(mockStorage.read(key: 'auth_access_token'))
          .thenAnswer((_) async => 'access-token-123');
      when(mockStorage.read(key: 'auth_id_token'))
          .thenAnswer((_) async => null);
      when(mockStorage.read(key: 'auth_refresh_token'))
          .thenAnswer((_) async => 'refresh-token-789');
      when(mockStorage.read(key: 'auth_user_sub'))
          .thenAnswer((_) async => 'user-sub-abc');

      final result = await dataSource.hasTokens();

      expect(result, isFalse);
    });
  });
}
