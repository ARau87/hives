# Story 2.4: Auth BLoC & State Management

Status: done

<!-- Note: Validation is optional. Run validate-create-story for quality check before dev-story. -->

## Story

As a developer,
I want auth state management via BLoC,
so that UI can react to authentication state changes.

## Acceptance Criteria

1. `AuthEvent` sealed class includes: `CheckAuthStatus`, `SignUpRequested`, `SignInRequested`, `SignOutRequested`, `ResetPasswordRequested`, `ConfirmSignUpRequested`, `ConfirmForgotPasswordRequested`
2. `AuthState` sealed class includes: `AuthInitial`, `AuthLoading`, `Authenticated(user)`, `Unauthenticated`, `AuthError(exception)`
3. BLoC checks auth status on initialization (emits `CheckAuthStatus` in constructor)
4. BLoC emits `Authenticated` state with `UserAggregate` data on successful sign in
5. BLoC emits `Unauthenticated` state on sign out or token expiry
6. BLoC emits `AuthError` with specific `AuthException` for failures
7. BLoC is provided at app root level via `BlocProvider` in `HivesApp`
8. Unit tests verify all state transitions (every event -> state combination)

## Tasks / Subtasks

- [x] Task 1: Add `flutter_bloc` and `bloc_test` dependencies (AC: #7, #8)
  - [x] 1.1 Add `flutter_bloc: ^9.1.0` to `packages/features/authentication/pubspec.yaml`
  - [x] 1.2 Add `bloc_test: ^10.0.0` to dev_dependencies in `packages/features/authentication/pubspec.yaml` (^10.0.0 used for bloc ^9.0.0 compatibility)
  - [x] 1.3 Add `flutter_bloc: ^9.1.0` to `apps/mobile/pubspec.yaml` (for BlocProvider)
  - [x] 1.4 Run `dart pub get` from root workspace

- [x] Task 2: Create `AuthEvent` sealed class (AC: #1)
  - [x] 2.1 Create `packages/features/authentication/lib/presentation/bloc/auth_event.dart`
  - [x] 2.2 Implement all event classes with required parameters (Email, Password value objects)

- [x] Task 3: Create `AuthState` sealed class (AC: #2)
  - [x] 3.1 Create `packages/features/authentication/lib/presentation/bloc/auth_state.dart`
  - [x] 3.2 Implement all state classes with appropriate fields

- [x] Task 4: Create `AuthBloc` (AC: #1-6)
  - [x] 4.1 Create `packages/features/authentication/lib/presentation/bloc/auth_bloc.dart`
  - [x] 4.2 Implement all event handlers using `AuthenticationRepository`
  - [x] 4.3 Add `CheckAuthStatus` dispatch in constructor
  - [x] 4.4 Handle `Either` fold pattern for all repository calls

- [x] Task 5: Register BLoC in DI and provide at app root (AC: #7)
  - [x] 5.1 Register `AuthBloc` in `bootstrap.dart` via GetIt
  - [x] 5.2 Wrap `HivesApp` with `BlocProvider<AuthBloc>` in `app.dart`

- [x] Task 6: Update barrel exports (AC: all)
  - [x] 6.1 Export `auth_bloc.dart`, `auth_event.dart`, `auth_state.dart` from `authentication.dart`

- [x] Task 7: Write unit tests (AC: #8)
  - [x] 7.1 Create `test/presentation/bloc/auth_bloc_test.dart`
  - [x] 7.2 Test `CheckAuthStatus` -> `Authenticated` when user has valid session
  - [x] 7.3 Test `CheckAuthStatus` -> `Unauthenticated` when no session
  - [x] 7.4 Test `SignInRequested` -> `AuthLoading` -> `Authenticated`
  - [x] 7.5 Test `SignInRequested` -> `AuthLoading` -> `AuthError` on failure
  - [x] 7.6 Test `SignUpRequested` -> `AuthLoading` -> `Authenticated`
  - [x] 7.7 Test `SignOutRequested` -> `AuthLoading` -> `Unauthenticated`
  - [x] 7.8 Test `ResetPasswordRequested` -> `AuthLoading` -> success state
  - [x] 7.9 Test `ConfirmSignUpRequested` and `ConfirmForgotPasswordRequested`
  - [x] 7.10 Verify error mapping for each `AuthException` type
  - [x] 7.11 Run `dart analyze` with zero issues on new files (pre-existing cognito_datasource.dart errors excluded)

## Dev Notes

### Architecture Compliance

- **BLoC location:** `packages/features/authentication/lib/presentation/bloc/` (per architecture.md project structure)
- **Pattern:** Pure BLoC pattern (NOT Cubit, NOT hydrated_bloc) — architecture mandates `flutter_bloc` for UI state
- **Sealed classes:** REQUIRED for both events and states (architecture enforcement guideline #2)
- **Either fold:** Repository returns `Either<AuthException, T>` — BLoC must fold results into states
- **No domain imports in BLoC:** BLoC depends on `AuthenticationRepository` interface (not impl), value objects, and exceptions only
- **Event naming:** Imperative style (e.g., `SignInRequested`, `SignOutRequested`) per architecture BLoC patterns
- **State classes:** Each state is a separate `final class extends AuthState` (sealed parent)

### Critical Implementation Details

**Constructor auto-check pattern:**
```dart
AuthBloc(this._repository) : super(AuthInitial()) {
  on<CheckAuthStatus>(_onCheckAuthStatus);
  on<SignInRequested>(_onSignIn);
  // ... register all handlers
  add(CheckAuthStatus()); // Auto-check on creation
}
```

**Event -> Repository method mapping:**

| AuthEvent | Repository Method | Success State | Error State |
|-----------|------------------|---------------|-------------|
| `CheckAuthStatus` | `getCurrentUser()` | `Authenticated(user)` or `Unauthenticated` | `Unauthenticated` (graceful) |
| `SignInRequested(email, password)` | `signIn(email, password)` | `Authenticated(user)` | `AuthError(exception)` |
| `SignUpRequested(email, password)` | `signUp(email, password)` | `Authenticated(user)` | `AuthError(exception)` |
| `SignOutRequested` | `signOut()` | `Unauthenticated` | `AuthError(exception)` |
| `ResetPasswordRequested(email)` | `resetPassword(email)` | `Unauthenticated` (stay) | `AuthError(exception)` |
| `ConfirmSignUpRequested(email, code)` | `confirmSignUp(email, code)` | `Unauthenticated` (user must sign in) | `AuthError(exception)` |
| `ConfirmForgotPasswordRequested(email, code, newPassword)` | `confirmForgotPassword(email, code, newPassword)` | `Unauthenticated` (user must sign in) | `AuthError(exception)` |

**CheckAuthStatus error handling:** On error, emit `Unauthenticated` (NOT `AuthError`) — the app should gracefully show login when session check fails, not an error screen.

**SignUp does NOT auto-sign-in:** After signUp, Cognito requires email confirmation (confirmSignUp). The BLoC should emit `Authenticated(user)` after signUp to hold the user object, but downstream UI (Story 2.5) will need to prompt for confirmation code.

### Event Parameters

```dart
// Events that need value objects (already validated by UI before dispatch)
class SignInRequested extends AuthEvent {
  final Email email;
  final Password password;
}

class SignUpRequested extends AuthEvent {
  final Email email;
  final Password password;
}

class ResetPasswordRequested extends AuthEvent {
  final Email email;
}

class ConfirmSignUpRequested extends AuthEvent {
  final Email email;
  final String confirmationCode;
}

class ConfirmForgotPasswordRequested extends AuthEvent {
  final Email email;
  final String code;
  final Password newPassword;
}

// Events without parameters
class CheckAuthStatus extends AuthEvent {}
class SignOutRequested extends AuthEvent {}
```

### Dependency Injection Notes

- DI is MANUAL in `bootstrap.dart` — injectable code generation cannot discover cross-package annotations (confirmed in Story 2.2/2.3)
- `AuthBloc` depends on `AuthenticationRepository` (already registered as lazy singleton)
- Register `AuthBloc` as a **factory** (NOT singleton) if BLoC needs to be recreatable, or **lazy singleton** if one instance for app lifetime
- **Recommendation:** Register as `registerLazySingleton<AuthBloc>` since auth state is app-wide and persists across navigation
- `BlocProvider` wraps `MaterialApp.router` in `app.dart` using `GetIt.instance<AuthBloc>()`

### Testing Strategy

- Use `bloc_test` package with `blocTest<AuthBloc, AuthState>()` pattern
- Mock `AuthenticationRepository` with mockito `@GenerateMocks`
- Use `seed` parameter in blocTest to set initial state before events
- Test all state transitions: `emits [AuthLoading(), Authenticated(user)]` for success
- Test error paths: `emits [AuthLoading(), AuthError(InvalidCredentials())]`
- Do NOT test repository internals — only verify BLoC emits correct states
- Use `@GenerateMocks([AuthenticationRepository])` — mock the interface, not impl

**Test file structure:**
```
test/
└── presentation/
    └── bloc/
        ├── auth_bloc_test.dart
        └── auth_bloc_test.mocks.dart  (generated by build_runner)
```

### Project Structure Notes

- Alignment: Architecture specifies `presentation/bloc/` directory — matches hive example in architecture.md
- The `lib/ui/` directory exists with a `.keep` file — do NOT use this; use `presentation/` per architecture convention
- The `lib/app/` directory exists with a `.keep` file — not relevant for BLoC
- After creating `presentation/bloc/`, consider removing the empty `lib/ui/.keep` placeholder (or leave for future stories)

### Previous Story Intelligence (Story 2.3)

Key learnings from Story 2.3 that impact this story:

1. **DI registration is MANUAL** in bootstrap.dart — do NOT rely on injectable annotations
2. **Use `package:authentication/...` imports exclusively** — no relative imports (lint rule: `always_use_package_imports`)
3. **Use `@GenerateMocks` annotation** and run `build_runner` to generate mock files
4. **EventBus is already a singleton** via GetIt — AuthBloc should NOT subscribe to EventBus directly (that's for cross-module communication, not intra-module)
5. **All public classes must be exported** from `authentication.dart` barrel file
6. **Pre-existing compilation errors** in `cognito_datasource.dart` (Story 2.2) cause analyzer errors — these are NOT introduced by this story, do not fix them
7. **`signOut` clears tokens in both success and error paths** — BLoC should always emit `Unauthenticated` after signOut attempt regardless of error

### Git Intelligence

Recent commit patterns:
- Commit message format: `feat: <description>`
- Most recent auth commit: `4b95cba feat: implement authentication module with Cognito integration`
- Files follow the established package structure

### Library & Framework Requirements

| Package | Version | Purpose | Add To |
|---------|---------|---------|--------|
| `flutter_bloc` | `^9.1.0` | BLoC pattern state management | authentication/pubspec.yaml + mobile/pubspec.yaml |
| `bloc_test` | `^9.1.0` | BLoC testing utilities | authentication/pubspec.yaml (dev_dependencies) |
| `bloc` | (transitive) | Core bloc library | Pulled in by flutter_bloc |

**IMPORTANT:** Check latest stable versions at pub.dev before adding. The versions above are based on the architecture spec and current stable releases.

**Already available (no action needed):**
- `fpdart: ^1.2.0` — for Either, Unit
- `mockito: ^5.4.0` — for mocking in tests
- `build_runner: ^2.4.15` — for mock generation
- `core_infrastructure: 0.0.1` — for EventBus (not directly needed by BLoC)

### References

- [Source: _bmad-output/planning-artifacts/architecture.md#BLoC Patterns] — Sealed event/state pattern, BLoC structure with fold
- [Source: _bmad-output/planning-artifacts/architecture.md#State Management] — flutter_bloc, pure BLoC pattern mandate
- [Source: _bmad-output/planning-artifacts/architecture.md#Authentication & Security] — Token refresh transparent to BLoC
- [Source: _bmad-output/planning-artifacts/architecture.md#Dependency Injection] — GetIt + manual registration
- [Source: _bmad-output/planning-artifacts/architecture.md#Enforcement Guidelines] — Sealed classes, Either returns, barrel exports
- [Source: _bmad-output/planning-artifacts/architecture.md#Project Structure] — presentation/bloc/ directory layout
- [Source: _bmad-output/planning-artifacts/epics.md#Epic 2 Story 2.4] — Acceptance criteria and dependencies
- [Source: _bmad-output/implementation-artifacts/2-3-auth-repository-implementation.md] — Previous story patterns and learnings
- [Source: apps/mobile/lib/bootstrap.dart] — Current DI registration pattern
- [Source: apps/mobile/lib/app.dart] — App root widget needing BlocProvider

## Dev Agent Record

### Agent Model Used

Claude Opus 4.6

### Debug Log References

- Version conflict: `bloc_test: ^9.1.0` requires `bloc ^8.1.0` but `flutter_bloc: ^9.1.0` requires `bloc ^9.0.0`. Resolved by upgrading to `bloc_test: ^10.0.0` which depends on `bloc ^9.0.0`.
- Mockito `MissingDummyValueError` for `Either<AuthException, UserAggregate?>` — resolved by adding `provideDummy` calls in test setUp for all Either return types.
- Pre-existing cognito_datasource.dart compilation errors (Story 2.2) cause 3 test file load failures — not introduced by this story.

### Completion Notes List

- Implemented AuthEvent sealed class with 7 event types matching AC #1
- Implemented AuthState sealed class with 5 state types matching AC #2
- Implemented AuthBloc with constructor auto-check (AC #3), all event handlers using Either fold pattern (AC #4-6)
- SignOut always emits Unauthenticated regardless of success/failure (per Story 2.3 learning #7)
- CheckAuthStatus emits Unauthenticated on error (graceful degradation, not AuthError)
- Registered AuthBloc as lazySingleton in bootstrap.dart via GetIt (AC #7)
- Wrapped HivesApp with BlocProvider<AuthBloc> in app.dart (AC #7)
- Added barrel exports for all 3 BLoC files in authentication.dart
- 20 unit tests covering all event->state transitions, error mapping for all 5 exception types (AC #8)
- dart analyze: zero issues on all new files (pre-existing cognito_datasource errors unchanged)

### Change Log

- 2026-03-10: Implemented Auth BLoC & State Management (Story 2.4) — added AuthBloc, AuthEvent, AuthState, DI registration, BlocProvider, barrel exports, and 20 unit tests
- 2026-03-12: Code review fixes — H1: switched to BlocProvider.value to prevent lifecycle conflict with GetIt lazySingleton; H2: wrapped _onSignOut in try/catch for throw safety; M1: fixed stale barrel docstring; M2: added pubspec.lock to File List; M3: added AuthLoading to CheckAuthStatus handler + updated all test expectations; M4: added expect: state chains to error mapping tests; M5: declared AuthBloc as final class

### File List

**New files:**
- packages/features/authentication/lib/presentation/bloc/auth_event.dart
- packages/features/authentication/lib/presentation/bloc/auth_state.dart
- packages/features/authentication/lib/presentation/bloc/auth_bloc.dart
- packages/features/authentication/test/presentation/bloc/auth_bloc_test.dart
- packages/features/authentication/test/presentation/bloc/auth_bloc_test.mocks.dart (generated)

**Modified files:**
- packages/features/authentication/pubspec.yaml (added flutter_bloc, bloc_test)
- apps/mobile/pubspec.yaml (added flutter_bloc)
- apps/mobile/lib/bootstrap.dart (registered AuthBloc in GetIt)
- apps/mobile/lib/app.dart (wrapped with BlocProvider)
- packages/features/authentication/lib/authentication.dart (added BLoC exports)
- pubspec.lock (updated by dependency resolution)
