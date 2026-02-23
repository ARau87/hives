import 'package:core_infrastructure/di/service_locator.dart';
import 'package:core_infrastructure/event_bus/event_bus.dart';
import 'package:get_it/get_it.dart';
import 'package:test/test.dart';

// Test class for singleton tests
class TestService {
  TestService(this.value);
  final String value;
}

void main() {
  group('Service Locator', () {
    setUp(() async {
      // Reset GetIt before each test
      await getIt.reset();
    });

    tearDown(() async {
      // Clean up after each test
      await getIt.reset();
    });

    test('getIt is the GetIt singleton instance', () {
      expect(getIt, equals(GetIt.instance));
    });

    test('can register and retrieve singleton', () {
      getIt.registerSingleton<String>('test-value');

      final result = getIt<String>();

      expect(result, equals('test-value'));
    });

    test('singleton returns same instance', () {
      final original = TestService('test');
      getIt.registerSingleton<TestService>(original);

      final result1 = getIt<TestService>();
      final result2 = getIt<TestService>();

      expect(identical(result1, result2), isTrue);
      expect(identical(result1, original), isTrue);
    });

    test('can register lazy singleton', () {
      var created = false;
      getIt.registerLazySingleton<String>(() {
        created = true;
        return 'lazy-value';
      });

      expect(created, isFalse);

      final result = getIt<String>();

      expect(created, isTrue);
      expect(result, equals('lazy-value'));
    });

    test('can register factory', () {
      var counter = 0;
      getIt.registerFactory<int>(() => ++counter);

      final result1 = getIt<int>();
      final result2 = getIt<int>();

      expect(result1, equals(1));
      expect(result2, equals(2));
    });

    test('can check if type is registered', () {
      expect(getIt.isRegistered<String>(), isFalse);

      getIt.registerSingleton<String>('value');

      expect(getIt.isRegistered<String>(), isTrue);
    });

    test('can unregister a type', () {
      getIt.registerSingleton<String>('value');
      expect(getIt.isRegistered<String>(), isTrue);

      getIt.unregister<String>();

      expect(getIt.isRegistered<String>(), isFalse);
    });

    test('can register EventBus manually', () {
      getIt.registerSingleton<EventBus>(EventBus());

      final eventBus = getIt<EventBus>();

      expect(eventBus, isA<EventBus>());
      expect(eventBus, equals(EventBus.instance));
    });

    test('reset clears all registrations', () async {
      getIt.registerSingleton<String>('value1');
      getIt.registerSingleton<TestService>(TestService('value2'));

      expect(getIt.isRegistered<String>(), isTrue);
      expect(getIt.isRegistered<TestService>(), isTrue);

      await getIt.reset();

      expect(getIt.isRegistered<String>(), isFalse);
      expect(getIt.isRegistered<TestService>(), isFalse);
    });
  });
}
