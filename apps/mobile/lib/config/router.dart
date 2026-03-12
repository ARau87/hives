import 'dart:async';

import 'package:authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/config/route_names.dart';
import 'package:mobile/screens/home_screen.dart';
import 'package:mobile/screens/locations_screen.dart';
import 'package:mobile/screens/settings_screen.dart';
import 'package:mobile/screens/tasks_screen.dart';
import 'package:mobile/shell/app_shell_scaffold.dart';

/// Bridges [AuthBloc] state changes into a [ChangeNotifier] so [GoRouter]
/// can re-run its redirect whenever auth state changes.
class _AuthRefreshNotifier extends ChangeNotifier {
  _AuthRefreshNotifier(AuthBloc authBloc) {
    _subscription = authBloc.stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<AuthState> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

/// Creates the application router with bottom navigation shell.
///
/// Uses [StatefulShellRoute.indexedStack] to preserve each tab's
/// navigation state independently. Auth routes are top-level (no shell)
/// since unauthenticated users should not see bottom navigation.
///
/// [AuthBloc] must be registered in GetIt before calling this function.
GoRouter appRouter() {
  final authBloc = GetIt.instance<AuthBloc>();

  return GoRouter(
    initialLocation: '/auth/sign-up',
    refreshListenable: _AuthRefreshNotifier(authBloc),
    redirect: (context, state) {
      final authState = context.read<AuthBloc>().state;
      final isAuthRoute = state.matchedLocation.startsWith('/auth');

      // Redirect authenticated users away from auth screens, but allow
      // verify-email since it's a required step after sign-up (the user is
      // temporarily Authenticated while awaiting OTP confirmation).
      final isVerifyRoute = state.matchedLocation.startsWith('/auth/verify-email');
      if (authState is Authenticated && isAuthRoute && !isVerifyRoute) {
        return '/home';
      }
      // Redirect unauthenticated users away from protected screens.
      if (authState is Unauthenticated && !isAuthRoute) {
        return '/auth/sign-up';
      }
      // AuthInitial: CheckAuthStatus still in flight — don't redirect yet.
      return null;
    },
    routes: [
      // Auth routes — top-level, no shell
      GoRoute(
        path: '/auth/sign-up',
        name: RouteNames.signUp,
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        path: '/auth/verify-email',
        name: RouteNames.verifyEmail,
        builder: (context, state) {
          final email = state.uri.queryParameters['email'] ?? '';
          return EmailVerificationPage(email: email);
        },
      ),
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
