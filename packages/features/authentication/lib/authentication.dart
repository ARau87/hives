/// Authentication feature package for the Hives project.
///
/// Exports the authentication domain model (Story 2.1), data layer
/// (Story 2.2), and BLoC state management (Story 2.4).
/// UI presentation layer added in Stories 2.5–2.8.
///
/// ## Domain Model
///
/// **Aggregates:**
/// - [UserAggregate] — root for the auth bounded context
///
/// **Value Objects:**
/// - [UserId] — UUID-validated user identifier
/// - [Email] — format-validated email address (factory with Either)
/// - [Password] — strength-validated password (factory with Either)
///
/// **Repository Interface:**
/// - [AuthenticationRepository] — signUp, confirmSignUp, signIn, signOut,
///   resetPassword, confirmForgotPassword, getCurrentUser
///
/// **Exceptions:**
/// - [AuthException] — base
/// - [InvalidCredentials], [EmailAlreadyExists], [WeakPassword],
///   [UserNotFound], [NetworkError]
///
/// **Domain Events (for EventBus):**
/// - [AuthUserLoggedIn], [AuthUserLoggedOut]
library;

// Aggregates
export 'package:authentication/domain/aggregates/user_aggregate.dart';

// Value objects
export 'package:authentication/domain/value_objects/user_id.dart';
export 'package:authentication/domain/value_objects/email.dart';
export 'package:authentication/domain/value_objects/password.dart';

// Repository interface
export 'package:authentication/domain/repositories/authentication_repository.dart';

// Exceptions
export 'package:authentication/domain/exceptions/auth_exceptions.dart';

// Domain events
export 'package:authentication/domain/events/auth_events.dart';

// Data sources
export 'package:authentication/data/datasources/auth_remote_datasource.dart';
export 'package:authentication/data/datasources/cognito_datasource.dart';

// Local data source
export 'package:authentication/data/datasources/auth_local_datasource.dart';

// Repository implementation
export 'package:authentication/data/repositories/auth_repository_impl.dart';

// DTOs
export 'package:authentication/data/dtos/cognito_auth_result.dart';

// Presentation - BLoC
export 'package:authentication/presentation/bloc/auth_bloc.dart';
export 'package:authentication/presentation/bloc/auth_event.dart';
export 'package:authentication/presentation/bloc/auth_state.dart';

// Presentation - Pages
export 'package:authentication/presentation/pages/sign_up_page.dart';
export 'package:authentication/presentation/pages/email_verification_page.dart';
