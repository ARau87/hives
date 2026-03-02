import 'package:core_data/database/app_database.dart';
import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppDatabase', () {
    late AppDatabase db;

    setUp(() {
      db = AppDatabase.createInMemory();
    });

    tearDown(() async {
      await db.close();
    });

    test('creates database successfully', () {
      expect(db, isNotNull);
    });

    test('schemaVersion is 1', () {
      expect(db.schemaVersion, equals(1));
    });

    group('SQLCipher encryption', () {
      late AppDatabase encryptedDb;

      setUp(() {
        // 64 hex chars = 32 bytes (valid AES-256 key length)
        encryptedDb = AppDatabase.createInMemoryEncrypted('a' * 64);
      });

      tearDown(() async {
        await encryptedDb.close();
      });

      // On the macOS/Linux desktop test runner the system SQLite is used
      // instead of the SQLCipher binary provided by sqlcipher_flutter_libs.
      // cipher_version() is a SQLCipher-only SQL function, so this test
      // must run as an integration test on a real device or simulator.
      // The test is kept here to document AC #8; mark it skipped on host.
      test(
        'cipher_version() returns a non-null value confirming SQLCipher is active',
        () async {
          final results = await encryptedDb
              .customSelect('SELECT cipher_version() AS version')
              .get();

          expect(results, hasLength(1));
          final version = results.first.readNullable<String>('version');
          expect(version, isNotNull);
          expect(version, isNotEmpty);
        },
        skip: 'Requires SQLCipher native library — run as integration test on device/simulator',
      );

      test('encrypted database performs CRUD operations successfully', () async {
        final id = await encryptedDb.into(encryptedDb.syncQueueItems).insert(
              SyncQueueItemsCompanion.insert(
                entityTableName: 'hives',
                recordId: 'enc-test',
                operation: 'create',
              ),
            );

        expect(id, greaterThan(0));

        final item = await (encryptedDb.select(encryptedDb.syncQueueItems)
              ..where((t) => t.id.equals(id)))
            .getSingle();

        expect(item.entityTableName, equals('hives'));
        expect(item.status, equals('pending'));
      });
    });

    group('SyncQueueItems CRUD', () {
      test('inserts a sync queue item', () async {
        final id = await db.into(db.syncQueueItems).insert(
              SyncQueueItemsCompanion.insert(
                entityTableName: 'hives',
                recordId: 'abc-123',
                operation: 'create',
                payload: const Value('{"name":"Test Hive"}'),
              ),
            );

        expect(id, greaterThan(0));
      });

      test('queries sync queue items', () async {
        await db.into(db.syncQueueItems).insert(
              SyncQueueItemsCompanion.insert(
                entityTableName: 'hives',
                recordId: 'abc-123',
                operation: 'create',
                payload: const Value('{"name":"Test Hive"}'),
              ),
            );

        final items = await db.select(db.syncQueueItems).get();

        expect(items, hasLength(1));
        expect(items.first.entityTableName, equals('hives'));
        expect(items.first.recordId, equals('abc-123'));
        expect(items.first.operation, equals('create'));
        expect(items.first.payload, equals('{"name":"Test Hive"}'));
        expect(items.first.status, equals('pending'));
        expect(items.first.retryCount, equals(0));
      });

      test('updates sync queue item status', () async {
        final id = await db.into(db.syncQueueItems).insert(
              SyncQueueItemsCompanion.insert(
                entityTableName: 'hives',
                recordId: 'abc-123',
                operation: 'create',
              ),
            );

        await (db.update(db.syncQueueItems)
              ..where((t) => t.id.equals(id)))
            .write(
          const SyncQueueItemsCompanion(
            status: Value('in_progress'),
          ),
        );

        final updated = await (db.select(db.syncQueueItems)
              ..where((t) => t.id.equals(id)))
            .getSingle();

        expect(updated.status, equals('in_progress'));
      });

      test('deletes sync queue item', () async {
        final id = await db.into(db.syncQueueItems).insert(
              SyncQueueItemsCompanion.insert(
                entityTableName: 'locations',
                recordId: 'def-456',
                operation: 'delete',
              ),
            );

        final deletedCount = await (db.delete(db.syncQueueItems)
              ..where((t) => t.id.equals(id)))
            .go();

        expect(deletedCount, equals(1));

        final remaining = await db.select(db.syncQueueItems).get();
        expect(remaining, isEmpty);
      });

      test('inserts multiple items and queries by status', () async {
        await db.into(db.syncQueueItems).insert(
              SyncQueueItemsCompanion.insert(
                entityTableName: 'hives',
                recordId: 'a',
                operation: 'create',
              ),
            );
        await db.into(db.syncQueueItems).insert(
              SyncQueueItemsCompanion.insert(
                entityTableName: 'locations',
                recordId: 'b',
                operation: 'update',
              ),
            );

        final pending = await (db.select(db.syncQueueItems)
              ..where((t) => t.status.equals('pending')))
            .get();

        expect(pending, hasLength(2));
      });

      test('default values are set correctly', () async {
        await db.into(db.syncQueueItems).insert(
              SyncQueueItemsCompanion.insert(
                entityTableName: 'hives',
                recordId: 'abc-123',
                operation: 'create',
              ),
            );

        final item =
            await db.select(db.syncQueueItems).getSingle();

        expect(item.status, equals('pending'));
        expect(item.retryCount, equals(0));
        expect(item.payload, isNull);
        expect(item.createdAt, isNotNull);
      });

      test('retryCount can be incremented', () async {
        final id = await db.into(db.syncQueueItems).insert(
              SyncQueueItemsCompanion.insert(
                entityTableName: 'hives',
                recordId: 'abc-123',
                operation: 'create',
              ),
            );

        await (db.update(db.syncQueueItems)
              ..where((t) => t.id.equals(id)))
            .write(
          const SyncQueueItemsCompanion(retryCount: Value(1)),
        );

        final updated = await (db.select(db.syncQueueItems)
              ..where((t) => t.id.equals(id)))
            .getSingle();

        expect(updated.retryCount, equals(1));
      });
    });
  });
}
