import 'package:authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

/// Root application widget.
///
/// Uses [MaterialApp.router] with the Hives design system theme
/// and GoRouter for navigation. Wraps the app with [BlocProvider]
/// for app-wide [AuthBloc] access.
class HivesApp extends StatelessWidget {
  const HivesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>.value(
      value: GetIt.instance<AuthBloc>(),
      child: MaterialApp.router(
        title: 'Hives',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        routerConfig: GetIt.instance<GoRouter>(),
      ),
    );
  }
}
