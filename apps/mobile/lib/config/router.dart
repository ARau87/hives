import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/config/route_names.dart';
import 'package:mobile/screens/home_screen.dart';
import 'package:mobile/screens/locations_screen.dart';
import 'package:mobile/screens/settings_screen.dart';
import 'package:mobile/screens/tasks_screen.dart';
import 'package:mobile/shell/app_shell_scaffold.dart';

/// Creates the application router with bottom navigation shell.
///
/// Uses [StatefulShellRoute.indexedStack] to preserve each tab's
/// navigation state independently.
GoRouter appRouter() {
  return GoRouter(
    initialLocation: '/home',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShellScaffold(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'home'),
            routes: [
              GoRoute(
                path: '/home',
                name: RouteNames.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'locations'),
            routes: [
              GoRoute(
                path: '/locations',
                name: RouteNames.locations,
                builder: (context, state) => const LocationsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'tasks'),
            routes: [
              GoRoute(
                path: '/tasks',
                name: RouteNames.tasks,
                builder: (context, state) => const TasksScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'settings'),
            routes: [
              GoRoute(
                path: '/settings',
                name: RouteNames.settings,
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
