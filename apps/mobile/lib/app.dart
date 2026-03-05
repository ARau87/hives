import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

/// Root application widget.
///
/// Uses [MaterialApp.router] with the Hives design system theme
/// and GoRouter for navigation.
class HivesApp extends StatelessWidget {
  const HivesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Hives',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: GetIt.instance<GoRouter>(),
    );
  }
}
