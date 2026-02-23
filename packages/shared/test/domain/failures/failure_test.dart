import 'package:shared/shared.dart';
import 'package:test/test.dart';

void main() {
  group('Failure', () {
    group('ServerFailure', () {
      test('should create with message', () {
        const failure = ServerFailure('Server error occurred');

        expect(failure.message, equals('Server error occurred'));
      });

      test('should create without message', () {
        const failure = ServerFailure();

        expect(failure.message, isNull);
      });

      test('should create with status code', () {
        final failure = ServerFailure.withStatusCode(500);

        expect(failure.message, equals('HTTP 500'));
      });

      test('should create with status code and details', () {
        final failure =
            ServerFailure.withStatusCode(404, 'Resource not found');

        expect(failure.message, equals('HTTP 404: Resource not found'));
      });

      test('should format toString correctly', () {
        const failure = ServerFailure('Test message');

        expect(failure.toString(), equals('ServerFailure: Test message'));
      });
    });

    group('CacheFailure', () {
      test('should create with message', () {
        const failure = CacheFailure('Cache read failed');

        expect(failure.message, equals('Cache read failed'));
      });

      test('should create without message', () {
        const failure = CacheFailure();

        expect(failure.message, isNull);
      });

      test('should format toString correctly', () {
        const failure = CacheFailure('Test');

        expect(failure.toString(), equals('CacheFailure: Test'));
      });
    });

    group('NetworkFailure', () {
      test('should create with message', () {
        const failure = NetworkFailure('No internet connection');

        expect(failure.message, equals('No internet connection'));
      });

      test('should create without message', () {
        const failure = NetworkFailure();

        expect(failure.message, isNull);
      });
    });

    group('ValidationFailure', () {
      test('should create with errors list', () {
        final failure = ValidationFailure(['Error 1', 'Error 2']);

        expect(failure.errors, equals(['Error 1', 'Error 2']));
      });

      test('should format message from errors', () {
        final failure = ValidationFailure(['Email is required', 'Name is too short']);

        expect(failure.message, equals('Email is required, Name is too short'));
      });

      test('should format toString correctly', () {
        final failure = ValidationFailure(['Error 1']);

        expect(failure.toString(), equals('ValidationFailure: Error 1'));
      });

      test('should handle empty errors list', () {
        final failure = ValidationFailure([]);

        expect(failure.errors, isEmpty);
        expect(failure.message, equals(''));
      });

      test('should have immutable errors list', () {
        final failure = ValidationFailure(['Error 1']);

        expect(
          () => failure.errors.add('Error 2'),
          throwsUnsupportedError,
        );
      });

      test('should not be affected by modifications to original list', () {
        final originalList = ['Error 1'];
        final failure = ValidationFailure(originalList);

        originalList.add('Error 2');

        expect(failure.errors, equals(['Error 1']));
        expect(failure.errors.length, equals(1));
      });
    });

    group('UnexpectedFailure', () {
      test('should create with message', () {
        const failure = UnexpectedFailure('Something went wrong');

        expect(failure.message, equals('Something went wrong'));
      });

      test('should create without message', () {
        const failure = UnexpectedFailure();

        expect(failure.message, isNull);
      });
    });

    group('equality', () {
      test('should be equal when same type and message', () {
        const failure1 = ServerFailure('Error');
        const failure2 = ServerFailure('Error');

        expect(failure1, equals(failure2));
        expect(failure1.hashCode, equals(failure2.hashCode));
      });

      test('should not be equal when different messages', () {
        const failure1 = ServerFailure('Error 1');
        const failure2 = ServerFailure('Error 2');

        expect(failure1, isNot(equals(failure2)));
      });

      test('should not be equal when different types', () {
        const failure1 = ServerFailure('Error');
        const failure2 = CacheFailure('Error');

        expect(failure1, isNot(equals(failure2)));
      });

      test('ValidationFailure should be equal when errors match', () {
        final failure1 = ValidationFailure(['Error 1', 'Error 2']);
        final failure2 = ValidationFailure(['Error 1', 'Error 2']);

        expect(failure1, equals(failure2));
        expect(failure1.hashCode, equals(failure2.hashCode));
      });

      test('ValidationFailure should not be equal when errors differ', () {
        final failure1 = ValidationFailure(['Error 1']);
        final failure2 = ValidationFailure(['Error 2']);

        expect(failure1, isNot(equals(failure2)));
      });

      test('ValidationFailure should not be equal when error count differs',
          () {
        final failure1 = ValidationFailure(['Error 1']);
        final failure2 = ValidationFailure(['Error 1', 'Error 2']);

        expect(failure1, isNot(equals(failure2)));
      });
    });

    group('pattern matching', () {
      test('should support exhaustive switch expression', () {
        Failure failure = const ServerFailure('Test');

        final result = switch (failure) {
          ServerFailure(:final message) => 'Server: $message',
          CacheFailure(:final message) => 'Cache: $message',
          NetworkFailure(:final message) => 'Network: $message',
          ValidationFailure(:final errors) => 'Validation: ${errors.length}',
          UnexpectedFailure(:final message) => 'Unexpected: $message',
        };

        expect(result, equals('Server: Test'));
      });

      test('should match ServerFailure', () {
        Failure failure = const ServerFailure('Server error');

        final matched = switch (failure) {
          ServerFailure() => true,
          _ => false,
        };

        expect(matched, isTrue);
      });

      test('should match CacheFailure', () {
        Failure failure = const CacheFailure('Cache error');

        final matched = switch (failure) {
          CacheFailure() => true,
          _ => false,
        };

        expect(matched, isTrue);
      });

      test('should match NetworkFailure', () {
        Failure failure = const NetworkFailure('Network error');

        final matched = switch (failure) {
          NetworkFailure() => true,
          _ => false,
        };

        expect(matched, isTrue);
      });

      test('should match ValidationFailure', () {
        Failure failure = ValidationFailure(['Error']);

        final matched = switch (failure) {
          ValidationFailure() => true,
          _ => false,
        };

        expect(matched, isTrue);
      });

      test('should match UnexpectedFailure', () {
        Failure failure = const UnexpectedFailure('Unexpected error');

        final matched = switch (failure) {
          UnexpectedFailure() => true,
          _ => false,
        };

        expect(matched, isTrue);
      });

      test('should extract ValidationFailure errors', () {
        Failure failure = ValidationFailure(['Error 1', 'Error 2']);

        final errors = switch (failure) {
          ValidationFailure(:final errors) => errors,
          _ => <String>[],
        };

        expect(errors, equals(['Error 1', 'Error 2']));
      });
    });
  });
}
