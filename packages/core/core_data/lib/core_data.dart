/// Core data layer for the Hives project.
///
/// This package provides:
/// - Database infrastructure (Drift/SQLite with SQLCipher encryption)
/// - Encryption key management
/// - Sync queue for offline mutations
/// - Base repository patterns
/// - Network connectivity monitoring
///
/// ```dart
/// import 'package:core_data/core_data.dart';
///
/// final keyManager = EncryptionKeyManager();
/// final key = await keyManager.getOrCreateKey();
/// final db = AppDatabase.create(key);
/// ```
library;

// Database
export 'package:core_data/database/app_database.dart';

// Encryption
export 'package:core_data/encryption/encryption_key_manager.dart';

// Network
export 'package:core_data/network/connectivity_service.dart';

// Repositories
export 'package:core_data/repositories/base_repository.dart';
