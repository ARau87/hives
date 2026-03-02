import 'dart:math';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Manages the database encryption key using platform-secure storage.
///
/// Generates a random 32-byte AES-256 encryption key on first launch
/// and stores it securely using [FlutterSecureStorage]. On subsequent
/// launches, the existing key is retrieved.
///
/// ```dart
/// final keyManager = EncryptionKeyManager();
/// final key = await keyManager.getOrCreateKey();
/// ```
class EncryptionKeyManager {
  /// Creates an [EncryptionKeyManager] with the given [FlutterSecureStorage].
  ///
  /// If no storage is provided, a default instance is used.
  EncryptionKeyManager({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  /// In-flight or completed key-fetch future.
  ///
  /// Caching this future ensures concurrent callers share the same async
  /// operation, eliminating the TOCTOU window where two parallel calls could
  /// each read `null` and independently generate (and overwrite) different keys.
  Future<String>? _keyFuture;

  static const String _keyName = 'hives_db_encryption_key';
  static const int _keyLengthBytes = 32;

  /// Returns the existing encryption key or generates a new one.
  ///
  /// On first call, generates a cryptographically random 32-byte key
  /// (hex-encoded) and persists it. Subsequent calls return the stored key.
  ///
  /// Concurrent callers share a single in-flight future, preventing
  /// multiple simultaneous writes to secure storage.
  Future<String> getOrCreateKey() {
    _keyFuture ??= _fetchOrCreate();
    return _keyFuture!;
  }

  Future<String> _fetchOrCreate() async {
    final existingKey = await _storage.read(key: _keyName);
    if (existingKey != null) {
      return existingKey;
    }

    final newKey = _generateKey();
    await _storage.write(key: _keyName, value: newKey);
    return newKey;
  }

  /// Generates a random 32-byte hex-encoded key.
  String _generateKey() {
    final random = Random.secure();
    final bytes = Uint8List(_keyLengthBytes);
    for (var i = 0; i < _keyLengthBytes; i++) {
      bytes[i] = random.nextInt(256);
    }
    return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }
}
