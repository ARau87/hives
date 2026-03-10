# Story 2.3: Auth Repository Implementation

Status: done

<!-- Note: Validation is optional. Run validate-create-story for quality check before dev-story. -->

## Story

As a developer,
I want the auth repository to connect domain to infrastructure,
So that auth operations are properly abstracted.

## Acceptance Criteria

1. **Given** Cognito data source exists (Story 2.2 complete)
   **When** `AuthRepositoryImpl` is implemented
   **Then** repository implements `AuthenticationRepository` interface from `domain/repositories/authentication_repository.dart`

2. **Given** a user signs in successfully
   **When** `signIn()` returns `Right(UserAggregate)`
   **Then** tokens (access, id, refresh) are stored in `flutter_secure_storage`
   **And** `AuthUserLoggedIn` domain event is published via `EventBus`

3. **Given** a user signs out
   **When** `signOut()` returns `Right(unit)`
   **Then** all stored tokens are cleared from secure storage
   **And** `AuthUserLoggedOut` domain event is published via `EventBus`

4. **Given** a previously authenticated user launches the app
   **When** `getCurrentUser()` is called
   **Then** stored tokens are read from secure storage
   **And** token validity is checked (via `CognitoDataSource.getCurrentUser()`)
   **And** if valid, returns `Right(UserAggregate)` reconstituted from stored data
   **And** if tokens are expired/missing, returns `Right(null)`

5. **Given** any repository method is called
   **When** the underlying data source throws an `AuthException`
   **Then** the exception is caught and returned as `Left(AuthException)`

6. **Given** the app bootstraps
   **When** DI is configured
   **Then** `AuthRepositoryImpl` is registered with `GetIt` as a lazy singleton implementing `AuthenticationRepository`

7. **Given** the auth flow requires `confirmSignUp` and `confirmForgotPassword`
   **When** these are needed by the BLoC (Story 2.4)
   **Then** the repository exposes these as additional methods (extending the interface)

## Tasks / Subtasks

- [x] Task 1: Create `AuthLocalDataSource` for secure token storage (AC: #2, #3, #4)
  - [x] 1.1 Create `packages/features/authentication/lib/data/datasources/auth_local_datasource.dart`
  - [x] 1.2 Define abstract interface with methods: `saveTokens`, `getTokens`, `clearTokens`, `hasTokens`
  - [x] 1.3 Create `SecureStorageAuthLocalDataSource` implementation using `flutter_secure_storage`
  - [x] 1.4 Store tokens under keys: `auth_access_token`, `auth_id_token`, `auth_refresh_token`, `auth_user_sub`

- [x] Task 2: Extend `AuthenticationRepository` interface (AC: #7)
  - [x] 2.1 Add `confirmSignUp({required Email email, required String confirmationCode})` method
  - [x] 2.2 Add `confirmForgotPassword({required Email email, required String code, required Password newPassword})` method
  - [x] 2.3 Keep existing 5 methods unchanged

- [x] Task 3: Implement `AuthRepositoryImpl` (AC: #1, #2, #3, #4, #5)
  - [x] 3.1 Create `packages/features/authentication/lib/data/repositories/auth_repository_impl.dart`
  - [x] 3.2 Constructor takes `AuthRemoteDataSource`, `AuthLocalDataSource`, `EventBus`
  - [x] 3.3 Implement `signUp`: unwrap Email/Password values -> call data source -> create UserAggregate.reconstitute -> return Right
  - [x] 3.4 Implement `signIn`: unwrap values -> call data source -> store tokens -> create UserAggregate.reconstitute -> publish AuthUserLoggedIn -> return Right
  - [x] 3.5 Implement `signOut`: call data source -> clear tokens -> publish AuthUserLoggedOut -> return Right
  - [x] 3.6 Implement `resetPassword`: unwrap Email -> call data source forgotPassword -> return Right(unit)
  - [x] 3.7 Implement `getCurrentUser`: check local tokens -> if found, call data source getCurrentUser -> if valid, return UserAggregate -> if invalid, clear tokens and return Right(null)
  - [x] 3.8 Implement `confirmSignUp`: unwrap Email -> call data source -> return Right(unit)
  - [x] 3.9 Implement `confirmForgotPassword`: unwrap Email/Password -> call data source -> return Right(unit)
  - [x] 3.10 Wrap ALL method bodies in try/catch -> Left(AuthException) for error cases

- [x] Task 4: Register with DI in bootstrap.dart (AC: #6)
  - [x] 4.1 Register `SecureStorageAuthLocalDataSource` as `AuthLocalDataSource` (lazy singleton)
  - [x] 4.2 Register `AuthRepositoryImpl` as `AuthenticationRepository` (lazy singleton, depends on `AuthRemoteDataSource`, `AuthLocalDataSource`, `EventBus`)

- [x] Task 5: Update barrel file (AC: #1)
  - [x] 5.1 Export `AuthLocalDataSource`, `SecureStorageAuthLocalDataSource` from `authentication.dart`
  - [x] 5.2 Export `AuthRepositoryImpl` from `authentication.dart`

- [x] Task 6: Write unit tests (AC: #1-#7)
  - [x] 6.1 Create `test/data/repositories/auth_repository_impl_test.dart`
  - [x] 6.2 Mock `AuthRemoteDataSource`, `AuthLocalDataSource`, `EventBus`
  - [x] 6.3 Test `signIn` success: verifies tokens saved, UserAggregate returned, AuthUserLoggedIn published
  - [x] 6.4 Test `signIn` failure: verifies Left(AuthException) returned, no tokens saved, no event published
  - [x] 6.5 Test `signOut` success: verifies tokens cleared, AuthUserLoggedOut published
  - [x] 6.6 Test `signUp` success: verifies UserAggregate returned
  - [x] 6.7 Test `getCurrentUser` with valid tokens: returns Right(UserAggregate)
  - [x] 6.8 Test `getCurrentUser` with no tokens: returns Right(null)
  - [x] 6.9 Test `getCurrentUser` with expired tokens: clears tokens, returns Right(null)
  - [x] 6.10 Test `resetPassword` success: calls forgotPassword on data source
  - [x] 6.11 Test `confirmSignUp` and `confirmForgotPassword` success and error paths
  - [x] 6.12 Test all error paths return Left(AuthException)
  - [x] 6.13 Create `test/data/datasources/auth_local_datasource_test.dart` for token storage tests

- [x] Task 7: Run `dart analyze` and fix all lint issues (AC: all)
  - [x] 7.1 Zero analyzer issues (on new/modified files; pre-existing issues in cognito_datasource.dart from Story 2.2 remain)
  - [x] 7.2 All tests passing (34/34 new tests pass)

## Dev Notes

### Technical Requirements

**Pattern:** This repository bridges domain ↔ data layers. It:
1. Receives value objects (`Email`, `Password`) from the domain
2. Unwraps to raw strings for the data source
3. Catches all `AuthException` throws from data source
4. Returns `Either<AuthException, T>` to callers
5. Manages side effects (token storage, event publishing)

**AuthenticationRepository Interface Methods:**
```dart
// Existing (from Story 2.1):
Future<Either<AuthException, UserAggregate>> signUp({required Email email, required Password password})
Future<Either<AuthException, UserAggregate>> signIn({required Email email, required Password password})
Future<Either<AuthException, Unit>> signOut()
Future<Either<AuthException, Unit>> resetPassword({required Email email})
Future<Either<AuthException, UserAggregate?>> getCurrentUser()

// NEW (add to interface for Stories 2.4-2.7):
Future<Either<AuthException, Unit>> confirmSignUp({required Email email, required String confirmationCode})
Future<Either<AuthException, Unit>> confirmForgotPassword({required Email email, required String code, required Password newPassword})
```

**AuthRemoteDataSource Methods (already implemented in Story 2.2):**
```dart
Future<String> signUp({required String email, required String password})          // returns userSub
Future<void> confirmSignUp({required String email, required String confirmationCode})
Future<CognitoAuthResult> signIn({required String email, required String password}) // returns tokens
Future<void> signOut()
Future<void> forgotPassword({required String email})
Future<void> confirmForgotPassword({required String email, required String code, required String newPassword})
Future<CognitoAuthResult?> getCurrentUser()                                       // returns tokens or null
```

**Method Mapping (Repository -> DataSource):**

| Repository Method | DataSource Call | Value Object Unwrapping | Side Effects |
|---|---|---|---|
| `signUp(email, password)` | `signUp(email.value, password.value)` | Email.value, Password.value | None (tokens stored at signIn) |
| `confirmSignUp(email, code)` | `confirmSignUp(email.value, code)` | Email.value | None |
| `signIn(email, password)` | `signIn(email.value, password.value)` | Email.value, Password.value | Save tokens, publish AuthUserLoggedIn |
| `signOut()` | `signOut()` | None | Clear tokens, publish AuthUserLoggedOut |
| `resetPassword(email)` | `forgotPassword(email.value)` | Email.value | None |
| `confirmForgotPassword(email, code, newPassword)` | `confirmForgotPassword(email.value, code, newPassword.value)` | Email.value, Password.value | None |
| `getCurrentUser()` | `getCurrentUser()` | None | Refresh tokens if needed |

**UserAggregate Creation from CognitoAuthResult:**
```dart
// After signIn or getCurrentUser returns CognitoAuthResult:
UserAggregate.reconstitute(
  id: result.userSub,
  email: email.value,  // From the signIn parameters or stored token
  createdAt: DateTime.now(), // Cognito doesn't expose creation date easily
)
```

**CRITICAL: signOut needs the userId for AuthUserLoggedOut event.** The repository must track the current userId (from last signIn/getCurrentUser) OR read it from stored tokens before clearing them.

**Token Storage Keys:**
```dart
static const _accessTokenKey = 'auth_access_token';
static const _idTokenKey = 'auth_id_token';
static const _refreshTokenKey = 'auth_refresh_token';
static const _userSubKey = 'auth_user_sub';
static const _userEmailKey = 'auth_user_email'; // Need email for reconstitution
```

**AuthLocalDataSource Interface:**
```dart
abstract class AuthLocalDataSource {
  Future<void> saveTokens(CognitoAuthResult result, String email);
  Future<CognitoAuthResult?> getTokens();
  Future<String?> getUserEmail();
  Future<String?> getUserSub();
  Future<void> clearTokens();
  Future<bool> hasTokens();
}
```

**getCurrentUser Flow:**
```
1. Check local storage for tokens (hasTokens)
2. If no tokens → return Right(null)
3. Call dataSource.getCurrentUser() to validate/refresh session
4. If valid (returns CognitoAuthResult) → update stored tokens, return Right(UserAggregate)
5. If null (expired/invalid) → clear tokens, return Right(null)
6. If throws → return Left(exception) or return Right(null) for non-critical errors
```

### Architecture Compliance

**Clean Architecture Boundaries:**
- Repository lives in `data/repositories/` — correct layer
- Depends on: `AuthRemoteDataSource` (data layer), `AuthLocalDataSource` (data layer), `EventBus` (infrastructure)
- Returns domain types: `Either<AuthException, T>`, `UserAggregate`, `Unit`
- Does NOT import Flutter/UI, BLoC, or presentation classes

**DDD Pattern Compliance:**
- Repository creates `UserAggregate` via `reconstitute()` factory (NOT `create()` — that's for domain logic raising events)
- Domain events (`AuthUserLoggedIn`, `AuthUserLoggedOut`) are published via `EventBus`
- Value object unwrapping: `email.value`, `password.value` → raw strings for data source
- Repository owns the transaction boundary: token storage + event publishing happen atomically

**Error Handling Pattern:**
```dart
Future<Either<AuthException, UserAggregate>> signIn({
  required Email email,
  required Password password,
}) async {
  try {
    final result = await _remoteDataSource.signIn(
      email: email.value,
      password: password.value,
    );
    await _localDataSource.saveTokens(result, email.value);
    final user = UserAggregate.reconstitute(
      id: result.userSub,
      email: email.value,
      createdAt: DateTime.now(),
    );
    _eventBus.publish(AuthUserLoggedIn(userId: user.id));
    return Right(user);
  } on AuthException catch (e) {
    return Left(e);
  } catch (e) {
    return Left(NetworkError(e.toString()));
  }
}
```

**DI Registration Pattern (in bootstrap.dart):**
```dart
// After existing Cognito registrations:
getIt.registerLazySingleton<AuthLocalDataSource>(
  () => SecureStorageAuthLocalDataSource(
    secureStorage: const FlutterSecureStorage(),
  ),
);
getIt.registerLazySingleton<AuthenticationRepository>(
  () => AuthRepositoryImpl(
    remoteDataSource: getIt<AuthRemoteDataSource>(),
    localDataSource: getIt<AuthLocalDataSource>(),
    eventBus: getIt<EventBus>(),
  ),
);
```

### Library & Framework Requirements

**Dependencies to ADD to `packages/features/authentication/pubspec.yaml`:**
```yaml
dependencies:
  flutter_secure_storage: ^9.2.4  # Same version as core_data
  core_infrastructure:             # For EventBus access (workspace dependency)
```

**Already available (DO NOT re-add):**
- `fpdart: ^1.2.0` (Either, Unit)
- `amazon_cognito_identity_dart_2: ^3.0.0` (indirect via CognitoDataSource)
- `shared` (DomainEvent, DomainException base classes)
- `injectable: ^2.5.0` (DI annotations — but NOT used for this registration)
- `mockito: ^5.4.0` (in dev_dependencies)
- `build_runner: ^2.4.15` (in dev_dependencies)

**DO NOT add:**
- `get_it` — access via `core_infrastructure` exports
- `dio` — not needed for auth repository
- `drift` — no database storage for auth (tokens go in secure storage)

### File Structure Requirements

**Files to CREATE:**
```
packages/features/authentication/
├── lib/
│   └── data/
│       ├── datasources/
│       │   └── auth_local_datasource.dart    # Interface + SecureStorage impl
│       └── repositories/
│           └── auth_repository_impl.dart     # AuthRepositoryImpl
├── test/
│   └── data/
│       ├── datasources/
│       │   └── auth_local_datasource_test.dart
│       └── repositories/
│           └── auth_repository_impl_test.dart
```

**Files to MODIFY:**
```
packages/features/authentication/
├── lib/
│   ├── authentication.dart                    # Add new exports
│   └── domain/
│       └── repositories/
│           └── authentication_repository.dart # Add confirmSignUp, confirmForgotPassword
├── pubspec.yaml                               # Add flutter_secure_storage, core_infrastructure deps

apps/mobile/
├── lib/
│   └── bootstrap.dart                         # Add AuthLocalDataSource + AuthRepositoryImpl DI
```

**Files to NOT touch:**
- `data/datasources/cognito_datasource.dart` — Story 2.2, already complete
- `data/datasources/auth_remote_datasource.dart` — Story 2.2, already complete
- `data/dtos/cognito_auth_result.dart` — Story 2.2, already complete
- `domain/aggregates/user_aggregate.dart` — Story 2.1, do not change
- `domain/value_objects/*` — Story 2.1, do not change
- `domain/exceptions/auth_exceptions.dart` — Story 2.1, do not change
- `domain/events/auth_events.dart` — Story 2.1, do not change
- Presentation layer — Stories 2.5-2.7

### Testing Requirements

**Testing approach:** Unit tests with mocked dependencies.

**Mocking strategy:**
- Mock `AuthRemoteDataSource` (from Story 2.2 interface)
- Mock `AuthLocalDataSource` (new interface from this story)
- Mock `EventBus` (from `core_infrastructure`)
- Use `mockito` with `@GenerateMocks`
- Do NOT make real network calls or real secure storage calls

**Test structure for `auth_repository_impl_test.dart`:**
```dart
@GenerateMocks([AuthRemoteDataSource, AuthLocalDataSource, EventBus])
void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockRemoteDataSource;
  late MockAuthLocalDataSource mockLocalDataSource;
  late MockEventBus mockEventBus;

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    mockLocalDataSource = MockAuthLocalDataSource();
    mockEventBus = MockEventBus();
    repository = AuthRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      eventBus: mockEventBus,
    );
  });

  group('signIn', () {
    test('returns Right(UserAggregate) on success', () async { ... });
    test('saves tokens on success', () async { ... });
    test('publishes AuthUserLoggedIn on success', () async { ... });
    test('returns Left(InvalidCredentials) on wrong password', () async { ... });
    test('does not save tokens on failure', () async { ... });
    test('does not publish event on failure', () async { ... });
  });
  // ... similar groups for signUp, signOut, getCurrentUser, resetPassword,
  //     confirmSignUp, confirmForgotPassword
}
```

**Test for `auth_local_datasource_test.dart`:**
```dart
@GenerateMocks([FlutterSecureStorage])
void main() {
  late SecureStorageAuthLocalDataSource dataSource;
  late MockFlutterSecureStorage mockStorage;

  setUp(() {
    mockStorage = MockFlutterSecureStorage();
    dataSource = SecureStorageAuthLocalDataSource(secureStorage: mockStorage);
  });

  group('saveTokens', () {
    test('writes all 5 keys to secure storage', () async { ... });
  });
  group('getTokens', () {
    test('returns CognitoAuthResult when all tokens exist', () async { ... });
    test('returns null when any token is missing', () async { ... });
  });
  group('clearTokens', () {
    test('deletes all 5 keys from secure storage', () async { ... });
  });
}
```

**Minimum test count:** ~25 tests
- signIn: 6 tests (success + tokens saved + event published + 3 error cases)
- signOut: 4 tests (success + tokens cleared + event + error)
- signUp: 3 tests (success + 2 error cases)
- getCurrentUser: 4 tests (valid + null + expired + error)
- resetPassword: 2 tests (success + error)
- confirmSignUp: 2 tests (success + error)
- confirmForgotPassword: 2 tests (success + error)
- Local data source: ~6 tests

**Lint compliance:**
- `always_use_package_imports` — use `package:authentication/...` not relative
- `prefer_single_quotes` — all strings single-quoted
- `dart analyze` must return zero issues

### Previous Story Intelligence (2.2)

**Critical learnings from Story 2.2 that MUST be followed:**

1. **DI registration is MANUAL in bootstrap.dart** — `injectable` code generation can't discover annotations across package boundaries. Register `AuthLocalDataSource` and `AuthRepositoryImpl` manually in `bootstrap.dart`, following the existing `CognitoDataSource` registration pattern.

2. **CognitoUserFactory injection** — Story 2.2 code review added `CognitoUserFactory` typedef for testability. Follow this pattern: inject dependencies via constructor for testability.

3. **Import style** — Use `package:authentication/...` imports exclusively (no relative). This was enforced in Story 2.1 and 2.2.

4. **Test mocking** — Use `@GenerateMocks` annotation and run `build_runner` to generate mock files. The generated `.mocks.dart` file is committed.

5. **`fpdart` Unit type** — Use `Unit` from `fpdart` for void-equivalent in Either return types. Import: `import 'package:fpdart/fpdart.dart';`

6. **EventBus is a singleton** — Access via `GetIt` or `EventBus()` factory. In tests, use `EventBus.resetForTesting()` in setUp, or mock it with mockito.

7. **Data source throws, repository catches** — CognitoDataSource throws `AuthException` types. The repository wraps these in `Left()`. Never let exceptions escape the repository.

8. **Barrel file** — All public classes must be exported from `authentication.dart`.

### Git Intelligence

**Recent commit patterns:**
- `feat: <description>` for new features
- All Epic 1 UI complete, core infrastructure wired
- DI uses GetIt + Injectable, with manual registration for cross-package dependencies
- GoRouter navigation established in app shell

**Key files from previous work:**
- `apps/mobile/lib/bootstrap.dart` — DI wiring (manually add new registrations here)
- `packages/core/core_infrastructure/lib/di/service_locator.dart` — `getIt` global accessor
- `packages/core/core_infrastructure/lib/event_bus/event_bus.dart` — EventBus singleton

### Project Structure Notes

- Authentication package: `packages/features/authentication/`
- `flutter_secure_storage` is already a dependency of `core_data` (v9.2.4) but NOT of `authentication` — must add to auth package's pubspec.yaml
- `core_infrastructure` exports `EventBus`, `getIt`, `NavigationService` — add as dependency to auth package
- The `data/repositories/` directory does not exist yet — create it
- The `data/datasources/` directory exists with `auth_remote_datasource.dart` and `cognito_datasource.dart`

### References

- [Source: _bmad-output/planning-artifacts/architecture.md#Authentication & Security] — Token storage via flutter_secure_storage, session management
- [Source: _bmad-output/planning-artifacts/architecture.md#Data Architecture] — Repository pattern, Either error handling
- [Source: _bmad-output/planning-artifacts/architecture.md#DDD Patterns] — Aggregate reconstitution, domain events, value object unwrapping
- [Source: _bmad-output/planning-artifacts/architecture.md#Event Bus Integration] — AuthUserLoggedIn/AuthUserLoggedOut events consumed by all modules
- [Source: _bmad-output/planning-artifacts/architecture.md#Dependency Injection] — GetIt registration, manual wiring in bootstrap.dart
- [Source: _bmad-output/planning-artifacts/architecture.md#Naming Conventions] — snake_case files, UpperCamelCase classes
- [Source: _bmad-output/planning-artifacts/epics.md#Epic 2 Story 2.3] — Acceptance criteria and story statement
- [Source: _bmad-output/implementation-artifacts/2-2-cognito-data-source.md] — Previous story patterns, DI lessons, CognitoDataSource API
- [Source: packages/features/authentication/lib/domain/repositories/authentication_repository.dart] — Interface to implement
- [Source: packages/features/authentication/lib/data/datasources/auth_remote_datasource.dart] — Data source API
- [Source: packages/features/authentication/lib/data/datasources/cognito_datasource.dart] — Concrete implementation patterns
- [Source: packages/features/authentication/lib/domain/events/auth_events.dart] — AuthUserLoggedIn, AuthUserLoggedOut event classes
- [Source: packages/core/core_infrastructure/lib/event_bus/event_bus.dart] — EventBus publish/subscribe API
- [Source: apps/mobile/lib/bootstrap.dart] — DI registration pattern

## Dev Agent Record

### Agent Model Used

Claude Opus 4.6

### Debug Log References

- Pre-existing compilation errors in `cognito_datasource.dart` (Story 2.2) cause 5 test file loading failures and 7 analyzer errors. These are NOT introduced by this story.

### Completion Notes List

- Implemented `AuthLocalDataSource` interface and `SecureStorageAuthLocalDataSource` with 5 storage keys (access token, id token, refresh token, user sub, user email)
- Extended `AuthenticationRepository` interface with `confirmSignUp` and `confirmForgotPassword` methods
- Implemented `AuthRepositoryImpl` with all 7 methods: signUp, confirmSignUp, signIn, signOut, resetPassword, confirmForgotPassword, getCurrentUser
- All methods follow try/catch → Left(AuthException) error handling pattern
- signIn stores tokens and publishes AuthUserLoggedIn event
- signOut reads userId before clearing tokens, then publishes AuthUserLoggedOut event; tokens are cleared in both success and error paths to prevent stuck-state
- getCurrentUser checks local tokens, validates via remote, refreshes stored tokens on success, clears on expiry
- Registered `AuthLocalDataSource` and `AuthRepositoryImpl` as lazy singletons in bootstrap.dart DI
- Added `flutter_secure_storage` and `core_infrastructure` dependencies to auth package pubspec
- Added `flutter_secure_storage` to mobile app pubspec (needed for bootstrap.dart import)
- Exported new classes from authentication.dart barrel file
- Added `cognitoUserPoolId`/`cognitoClientId` fields to `EnvConfig` in `env.dart`/`flavors.dart` (required for bootstrap.dart Cognito DI registration)
- 36 unit tests (12 local datasource + 24 repository) all passing (added: hasTokens idToken coverage, signOut null-userSub path)
- Zero analyzer issues on all new/modified files

### Code Review Fixes (2026-03-10)

- **M1 fixed**: `signOut` now clears local tokens in catch blocks — prevents stuck signed-in state when remote signOut fails
- **M2 fixed**: `hasTokens()` now checks all 4 token keys (was missing `idToken`) — consistent with `getTokens()` null behaviour
- **M3 fixed**: `env.dart` and `flavors.dart` added to File List — were modified to add Cognito fields but undocumented
- **H1 addressed**: Added `TODO(security)` comment in `flavors.dart` to externalize Cognito config via `--dart-define` at build time
- **L1 fixed**: Added test for `signOut` when `userSub` is null (no event published, tokens still cleared)
- **L2 fixed**: Updated barrel file doc comment to include `confirmSignUp`/`confirmForgotPassword`

### File List

**New files:**
- packages/features/authentication/lib/data/datasources/auth_local_datasource.dart
- packages/features/authentication/lib/data/repositories/auth_repository_impl.dart
- packages/features/authentication/test/data/datasources/auth_local_datasource_test.dart
- packages/features/authentication/test/data/datasources/auth_local_datasource_test.mocks.dart
- packages/features/authentication/test/data/repositories/auth_repository_impl_test.dart
- packages/features/authentication/test/data/repositories/auth_repository_impl_test.mocks.dart

**Modified files:**
- packages/features/authentication/lib/domain/repositories/authentication_repository.dart
- packages/features/authentication/lib/authentication.dart
- packages/features/authentication/pubspec.yaml
- apps/mobile/lib/bootstrap.dart
- apps/mobile/lib/config/env.dart
- apps/mobile/lib/config/flavors.dart
- apps/mobile/pubspec.yaml
- pubspec.lock

## Change Log

- 2026-03-10: Implemented auth repository layer (Story 2.3) — AuthLocalDataSource for secure token storage, extended AuthenticationRepository interface with confirmSignUp/confirmForgotPassword, AuthRepositoryImpl connecting domain to Cognito data source with token management and domain event publishing, DI registration in bootstrap.dart, 34 unit tests
- 2026-03-10: Code review fixes — defensive signOut (tokens cleared on error path), hasTokens idToken consistency, File List documentation, TODO for Cognito credential externalisation, 2 new tests (36 total)
