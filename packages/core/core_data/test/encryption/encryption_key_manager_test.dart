import 'package:core_data/encryption/encryption_key_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

/// In-memory fake for [FlutterSecureStorage] used in tests.
class FakeSecureStorage implements FlutterSecureStorage {
  final Map<String, String> _store = {};

  @override
  Future<String?> read({
    required String key,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    return _store[key];
  }

  @override
  Future<void> write({
    required String key,
    required String? value,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    if (value != null) {
      _store[key] = value;
    } else {
      _store.remove(key);
    }
  }

  @override
  Future<void> delete({
    required String key,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    _store.remove(key);
  }

  @override
  Future<bool> containsKey({
    required String key,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    return _store.containsKey(key);
  }

  @override
  Future<Map<String, String>> readAll({
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    return Map.unmodifiable(_store);
  }

  @override
  Future<void> deleteAll({
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    _store.clear();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  group('EncryptionKeyManager', () {
    late FakeSecureStorage fakeStorage;
    late EncryptionKeyManager keyManager;

    setUp(() {
      fakeStorage = FakeSecureStorage();
      keyManager = EncryptionKeyManager(storage: fakeStorage);
    });

    test('generates a new key on first call', () async {
      final key = await keyManager.getOrCreateKey();

      expect(key, isNotNull);
      expect(key, isNotEmpty);
      // 32 bytes hex-encoded = 64 characters
      expect(key.length, equals(64));
    });

    test('generated key is valid hex', () async {
      final key = await keyManager.getOrCreateKey();

      final hexPattern = RegExp(r'^[0-9a-f]{64}$');
      expect(hexPattern.hasMatch(key), isTrue);
    });

    test('returns same key on subsequent calls', () async {
      final firstKey = await keyManager.getOrCreateKey();
      final secondKey = await keyManager.getOrCreateKey();

      expect(firstKey, equals(secondKey));
    });

    test('persists key in secure storage', () async {
      final key = await keyManager.getOrCreateKey();

      // Create a new manager with the same storage
      final newManager = EncryptionKeyManager(storage: fakeStorage);
      final retrievedKey = await newManager.getOrCreateKey();

      expect(retrievedKey, equals(key));
    });

    test('generates unique keys across instances with fresh storage', () async {
      final key1 = await keyManager.getOrCreateKey();

      final freshStorage = FakeSecureStorage();
      final freshManager = EncryptionKeyManager(storage: freshStorage);
      final key2 = await freshManager.getOrCreateKey();

      // Extremely unlikely to be equal with 32 random bytes
      expect(key1, isNot(equals(key2)));
    });
  });
}
