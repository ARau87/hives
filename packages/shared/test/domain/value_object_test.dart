import 'package:shared/shared.dart';
import 'package:test/test.dart';

// Test implementation of ValueObject
class Email extends ValueObject {
  const Email(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

class Money extends ValueObject {
  const Money({required this.amount, required this.currency});

  final double amount;
  final String currency;

  @override
  List<Object?> get props => [amount, currency];
}

class EmptyValueObject extends ValueObject {
  const EmptyValueObject();

  @override
  List<Object?> get props => [];
}

void main() {
  group('ValueObject', () {
    test('should be equal when props match', () {
      const email1 = Email('test@example.com');
      const email2 = Email('test@example.com');

      expect(email1, equals(email2));
      expect(email1.hashCode, equals(email2.hashCode));
    });

    test('should not be equal when props differ', () {
      const email1 = Email('test1@example.com');
      const email2 = Email('test2@example.com');

      expect(email1, isNot(equals(email2)));
    });

    test('should work with multiple props', () {
      const money1 = Money(amount: 100.0, currency: 'USD');
      const money2 = Money(amount: 100.0, currency: 'USD');
      const money3 = Money(amount: 100.0, currency: 'EUR');

      expect(money1, equals(money2));
      expect(money1, isNot(equals(money3)));
    });

    test('should return string representation', () {
      const email = Email('test@example.com');

      expect(email.toString(), equals('Email(test@example.com)'));
    });

    test('should work with empty props list', () {
      const empty1 = EmptyValueObject();
      const empty2 = EmptyValueObject();

      expect(empty1, equals(empty2));
    });

    test('should be equal to itself', () {
      const email = Email('test@example.com');

      expect(email, equals(email));
    });

    test('should not be equal to different type', () {
      const email = Email('test@example.com');

      expect(email, isNot(equals('test@example.com')));
    });

    test('should not be equal to different value object type', () {
      const email = Email('100.0');
      const money = Money(amount: 100.0, currency: 'USD');

      // Different types should not be equal
      expect(email, isNot(equals(money)));
    });

    test('should have consistent hashCode across multiple calls', () {
      const email = Email('test@example.com');

      expect(email.hashCode, equals(email.hashCode));
    });

    test('should produce different hashCodes for different values', () {
      const email1 = Email('test1@example.com');
      const email2 = Email('test2@example.com');

      // While not guaranteed by contract, different values typically have different hashCodes
      // This test is more of a sanity check
      expect(email1.hashCode, isNot(equals(email2.hashCode)));
    });

    test('should handle props with different lengths', () {
      const money1 = Money(amount: 100.0, currency: 'USD');
      const email = Email('100.0');

      // Different number of props should not match
      expect(money1, isNot(equals(email)));
    });

    test('should format multiple props in toString', () {
      const money = Money(amount: 100.0, currency: 'USD');

      expect(money.toString(), equals('Money(100.0, USD)'));
    });
  });
}
