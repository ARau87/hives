import 'package:authentication/domain/value_objects/user_id.dart';
import 'package:shared/shared.dart';

/// Domain event published when a user successfully authenticates.
///
/// Consumed by all modules that need to initialize or load user-specific
/// data (e.g., locations, hives, tasks) after sign-in.
///
/// Published via [EventBus] after [AuthenticationRepository.signIn] succeeds.
class AuthUserLoggedIn extends DomainEvent {
  AuthUserLoggedIn({required this.userId})
      : super(aggregateId: userId.value);

  /// The identifier of the user who logged in.
  final UserId userId;
}

/// Domain event published when a user signs out.
///
/// Consumed by all modules that should clear their local caches and
/// reset to an unauthenticated state.
///
/// Published via [EventBus] after [AuthenticationRepository.signOut] succeeds.
class AuthUserLoggedOut extends DomainEvent {
  AuthUserLoggedOut({required this.userId})
      : super(aggregateId: userId.value);

  /// The identifier of the user who logged out.
  final UserId userId;
}
