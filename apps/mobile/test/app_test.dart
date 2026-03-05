import 'package:core_infrastructure/core_infrastructure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/app.dart';
import 'package:mobile/config/env.dart';
import 'package:mobile/config/flavors.dart';
import 'package:mobile/config/router.dart';

void main() {
  setUp(() {
    // Full reset + re-register mirrors what bootstrap() does at app startup.
    GetIt.instance.reset();
    final router = appRouter();
    GetIt.instance.registerSingleton<GoRouter>(router);
    GetIt.instance.registerSingleton<NavigationService>(
      GoRouterNavigationService(router),
    );
    GetIt.instance.registerSingleton<EnvConfig>(getConfig(AppEnvironment.dev));
  });

  tearDown(() {
    GetIt.instance.reset();
  });

  testWidgets('HivesApp renders MaterialApp.router', (tester) async {
    await tester.pumpWidget(const HivesApp());
    await tester.pumpAndSettle();

    expect(find.byType(MaterialApp), findsOneWidget);
    final materialApp =
        tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(materialApp.title, 'Hives');
    expect(materialApp.debugShowCheckedModeBanner, false);
  });

  testWidgets('HivesApp shows Home screen on launch', (tester) async {
    await tester.pumpWidget(const HivesApp());
    await tester.pumpAndSettle();

    expect(find.text('Home'), findsWidgets);
  });

  testWidgets('HivesApp applies Hives theme', (tester) async {
    await tester.pumpWidget(const HivesApp());
    await tester.pumpAndSettle();

    final materialApp =
        tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(materialApp.theme, isNotNull);
    expect(materialApp.darkTheme, isNotNull);
  });
}
