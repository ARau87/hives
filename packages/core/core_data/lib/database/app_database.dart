import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlcipher_flutter_libs/sqlcipher_flutter_libs.dart';

part 'app_database.g.dart';

/// Drift table for tracking pending offline mutations.
///
/// The sync queue stores local mutations that need to be replayed
/// when connectivity is restored. Each entry tracks the target table,
/// record ID, operation type, and serialized payload.
///
/// SQL table name: `sync_queue_items`
class SyncQueueItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get entityTableName => text().named('table_name')();
  TextColumn get recordId => text()();
  TextColumn get operation => text()();
  TextColumn get payload => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  IntColumn get retryCount =>
      integer().withDefault(const Constant(0))();
  TextColumn get status =>
      text().withDefault(const Constant('pending'))();
}

/// Central database instance for the Hives application.
///
/// Uses Drift with SQLCipher for AES-256 encryption at rest.
/// Provides factory constructors for production (encrypted, persistent)
/// and test (unencrypted, in-memory) usage.
///
/// ```dart
/// final db = AppDatabase.create(encryptionKey);
/// ```
@DriftDatabase(tables: [SyncQueueItems])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          // Future migrations go here
        },
      );

  /// Factory for production use (encrypted, persistent).
  ///
  /// Applies SQLCipher AES-256 encryption with the provided [encryptionKey]
  /// and includes an Android 5.x compatibility workaround.
  ///
  /// Throws an [AssertionError] if [encryptionKey] is empty, which would
  /// cause SQLCipher to open the database unencrypted.
  static AppDatabase create(String encryptionKey) {
    assert(encryptionKey.isNotEmpty, 'encryptionKey must not be empty');
    return AppDatabase(
      driftDatabase(
        name: 'hives_db',
        native: DriftNativeOptions(
          databaseDirectory: () => getApplicationDocumentsDirectory(),
          setup: (rawDb) {
            applyWorkaroundToOpenSqlCipherOnOldAndroidVersions();
            rawDb.execute("PRAGMA key = '$encryptionKey';");
          },
        ),
      ),
    );
  }

  /// Factory for tests (unencrypted, in-memory).
  static AppDatabase createInMemory() {
    return AppDatabase(NativeDatabase.memory());
  }

  /// Factory for tests that verify SQLCipher encryption is active (in-memory).
  ///
  /// Mirrors the production [create] setup — applies `PRAGMA key` via SQLCipher —
  /// but uses an in-memory database so no file I/O or [path_provider] is needed.
  /// Use in unit tests to assert that `SELECT cipher_version()` returns a value.
  static AppDatabase createInMemoryEncrypted(String encryptionKey) {
    assert(encryptionKey.isNotEmpty, 'encryptionKey must not be empty');
    return AppDatabase(
      NativeDatabase.memory(
        setup: (rawDb) {
          applyWorkaroundToOpenSqlCipherOnOldAndroidVersions();
          rawDb.execute("PRAGMA key = '$encryptionKey';");
        },
      ),
    );
  }
}
