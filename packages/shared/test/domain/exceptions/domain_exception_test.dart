import 'package:shared/shared.dart';
import 'package:test/test.dart';

// Test implementations of DomainException
class TestException extends DomainException {
  TestException(this._message);

  final String _message;

  @override
  String get message => _message;
}

class HiveNotFoundException extends DomainException {
  HiveNotFoundException(this.hiveId);

  final String hiveId;

  @override
  String get message => 'Hive not found: $hiveId';
}

class ValidationException extends DomainException {
  ValidationException(this.errors);

  final List<String> errors;

  @override
  String get message => 'Validation failed: ${errors.join(', ')}';
}

void main() {
  group('DomainException', () {
    test('should implement Exception', () {
      final exception = TestException('Test message');

      expect(exception, isA<Exception>());
    });

    test('should provide message', () {
      final exception = TestException('Test message');

      expect(exception.message, equals('Test message'));
    });

    test('should format toString correctly', () {
      final exception = TestException('Test message');

      expect(exception.toString(), equals('TestException: Test message'));
    });

    test('should support custom exception with formatted message', () {
      final exception = HiveNotFoundException('hive-123');

      expect(exception.message, equals('Hive not found: hive-123'));
      expect(exception.toString(),
          equals('HiveNotFoundException: Hive not found: hive-123'));
    });

    test('should support exception with list of errors', () {
      final exception = ValidationException([
        'Name is required',
        'Email is invalid',
      ]);

      expect(exception.message,
          equals('Validation failed: Name is required, Email is invalid'));
    });

    test('should be catchable as Exception', () {
      expect(
        () => throw TestException('Test error'),
        throwsA(isA<Exception>()),
      );
    });

    test('should be catchable as DomainException', () {
      expect(
        () => throw TestException('Test error'),
        throwsA(isA<DomainException>()),
      );
    });

    test('should be catchable by specific type', () {
      expect(
        () => throw HiveNotFoundException('hive-123'),
        throwsA(isA<HiveNotFoundException>()),
      );
    });

    test('should allow try-catch with message access', () {
      try {
        throw HiveNotFoundException('hive-123');
      } on DomainException catch (e) {
        expect(e.message, equals('Hive not found: hive-123'));
      }
    });
  });
}
