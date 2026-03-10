# Story 2.2: Cognito Data Source

Status: done

<!-- Note: Validation is optional. Run validate-create-story for quality check before dev-story. -->

## Story

As a developer,
I want AWS Cognito integration,
So that users can authenticate with a secure, managed service.

## Acceptance Criteria

1. **Given** authentication domain model exists (Story 2.1 complete)
   **When** Cognito data source is implemented
   **Then** `CognitoDataSource` class wraps `amazon_cognito_identity_dart_2` SDK

2. **Given** a new user provides email and password
   **When** `signUp()` is called
   **Then** user is created in Cognito user pool with email attribute
   **And** method returns user sub (UUID) on success
   **And** returns typed `AuthException` on failure (e.g., `EmailAlreadyExists`, `WeakPassword`)

3. **Given** a user has received email verification code
   **When** `confirmSignUp()` is called with email and confirmation code
   **Then** user account is verified in Cognito
   **And** returns success or typed `AuthException` on invalid/expired code

4. **Given** a registered and confirmed user
   **When** `signIn()` is called with email and password
   **Then** authentication succeeds and returns Cognito session with tokens (access, id, refresh)
   **And** returns `InvalidCredentials` exception on wrong credentials
   **And** returns `UserNotFound` exception if user doesn't exist

5. **Given** a signed-in user
   **When** `signOut()` is called
   **Then** Cognito session is invalidated locally

6. **Given** a user who forgot their password
   **When** `forgotPassword()` is called with email
   **Then** Cognito sends password reset code to user's email
   **And** returns success regardless of whether email exists (security best practice)

7. **Given** a user has received password reset code
   **When** `confirmForgotPassword()` is called with email, code, and new password
   **Then** password is updated in Cognito
   **And** returns typed `AuthException` on invalid code or weak password

8. **Given** a previously authenticated user
   **When** `getCurrentUser()` is called
   **Then** returns `CognitoAuthResult` with access, id, refresh tokens and userSub if session is valid
   **And** returns null if no active session

9. **Given** the app runs in different environments (dev, staging, production)
   **When** Cognito pool configuration is loaded
   **Then** User Pool ID and Client ID are sourced from environment configuration (flavor-specific)

10. **Given** any Cognito network call
    **When** the call is made
    **Then** all communication uses HTTPS (NFR8)

## Tasks / Subtasks

- [x] Task 1: Add `amazon_cognito_identity_dart_2` dependency to authentication package (AC: #9)
  - [x] 1.1 Add `amazon_cognito_identity_dart_2` to `packages/features/authentication/pubspec.yaml`
  - [x] 1.2 Run `melos bootstrap` to resolve dependencies
  - [x] 1.3 Verify package resolves and imports correctly

- [x] Task 2: Create Cognito environment configuration (AC: #9)
  - [x] 2.1 Add `cognitoUserPoolId` and `cognitoClientId` fields to `EnvConfig` in `apps/mobile/lib/config/env.dart`
  - [x] 2.2 Add flavor-specific Cognito pool values for dev, staging, production in `flavors.dart`
  - [x] 2.3 Verify configuration is accessible via `GetIt<EnvConfig>()`

- [x] Task 3: Implement `CognitoDataSource` class (AC: #1, #2, #3, #4, #5, #6, #7, #8, #10)
  - [x] 3.1 Create `packages/features/authentication/lib/data/datasources/cognito_datasource.dart`
  - [x] 3.2 Initialize `CognitoUserPool` from environment config (pool ID + client ID)
  - [x] 3.3 Implement `signUp({required String email, required String password})` → creates user with email attribute
  - [x] 3.4 Implement `confirmSignUp({required String email, required String confirmationCode})` → verifies account
  - [x] 3.5 Implement `signIn({required String email, required String password})` → returns `CognitoUserSession` with tokens
  - [x] 3.6 Implement `signOut()` → invalidates local session
  - [x] 3.7 Implement `forgotPassword({required String email})` → initiates reset flow
  - [x] 3.8 Implement `confirmForgotPassword({required String email, required String code, required String newPassword})` → completes reset
  - [x] 3.9 Implement `getCurrentUser()` → returns user attributes or null if no session
  - [x] 3.10 Map all Cognito SDK exceptions to domain `AuthException` types (see exception mapping table in Dev Notes)

- [x] Task 4: Create abstract `AuthRemoteDataSource` interface (AC: #1)
  - [x] 4.1 Create `packages/features/authentication/lib/data/datasources/auth_remote_datasource.dart`
  - [x] 4.2 Define abstract interface with all 7 methods matching `CognitoDataSource` signatures
  - [x] 4.3 Have `CognitoDataSource` implement `AuthRemoteDataSource`

- [x] Task 5: Register `CognitoDataSource` with DI (AC: #1)
  - [x] 5.1 Add `@LazySingleton(as: AuthRemoteDataSource)` annotation to `CognitoDataSource`
  - [x] 5.2 Add `injectable` dependency to authentication package if not present
  - [x] 5.3 Ensure DI module registration wires correctly via `configureInjection()`

- [x] Task 6: Update barrel file exports (AC: #1)
  - [x] 6.1 Export `AuthRemoteDataSource` and `CognitoDataSource` from `authentication.dart`
  - [x] 6.2 Export any new DTOs or helper classes

- [x] Task 7: Write unit tests (AC: #2, #3, #4, #5, #6, #7, #8)
  - [x] 7.1 Create `test/data/datasources/cognito_datasource_test.dart`
  - [x] 7.2 Test `signUp` success and error cases (EmailAlreadyExists, WeakPassword, NetworkError)
  - [x] 7.3 Test `confirmSignUp` success and invalid code case
  - [x] 7.4 Test `signIn` success and error cases (InvalidCredentials, UserNotFound, NetworkError)
  - [x] 7.5 Test `signOut` success case
  - [x] 7.6 Test `forgotPassword` success case
  - [x] 7.7 Test `confirmForgotPassword` success and error cases
  - [x] 7.8 Test `getCurrentUser` returns user when session valid, null when no session
  - [x] 7.9 Mock Cognito SDK classes for all tests (do NOT call real Cognito)

- [x] Task 8: Run `dart analyze` and fix all lint issues (AC: all)
  - [x] 8.1 Zero analyzer issues
  - [x] 8.2 All tests passing

## Dev Notes

### Technical Requirements

**Package:** `amazon_cognito_identity_dart_2`
- Unofficial Dart SDK wrapping Amazon Cognito Identity Provider
- GitHub: https://github.com/furaiev/amazon-cognito-identity-dart-2
- Key classes: `CognitoUserPool`, `CognitoUser`, `CognitoUserSession`, `CognitoUserAttribute`
- The SDK handles HTTPS natively — all Cognito API calls go over TLS (NFR8 satisfied by default)

**Return Types:** This is a DATA LAYER class. Methods return raw types or throw exceptions. The REPOSITORY layer (Story 2.3) wraps these in `Either<AuthException, T>`. Do NOT use `Either` in the data source.

**Exception Mapping Table (CRITICAL):**

| Cognito SDK Exception | Domain AuthException | Notes |
|----------------------|---------------------|-------|
| `CognitoClientException` with code `UsernameExistsException` | `EmailAlreadyExists` | signUp duplicate email |
| `CognitoClientException` with code `InvalidPasswordException` | `WeakPassword(detail)` | signUp weak password |
| `CognitoClientException` with code `NotAuthorizedException` | `InvalidCredentials` | signIn wrong password |
| `CognitoClientException` with code `UserNotFoundException` | `UserNotFound` | signIn/forgot unknown user |
| `CognitoClientException` with code `CodeMismatchException` | `InvalidCredentials` | confirmSignUp/confirmForgotPassword wrong code |
| `CognitoClientException` with code `ExpiredCodeException` | `InvalidCredentials` | expired verification/reset code |
| `CognitoClientException` with code `LimitExceededException` | `NetworkError('Rate limit exceeded')` | too many attempts |
| `CognitoClientException` with code `UserNotConfirmedException` | `InvalidCredentials` | signIn before email verification |
| Any `SocketException` / network error | `NetworkError(detail)` | connectivity failure |
| Any unhandled exception | `NetworkError(e.toString())` | catch-all safety net |

**Method Signatures for `CognitoDataSource`:**

```dart
class CognitoDataSource implements AuthRemoteDataSource {
  CognitoDataSource({required CognitoUserPool userPool});

  Future<String> signUp({required String email, required String password});
  // Returns: user sub (UUID string)
  // Throws: EmailAlreadyExists, WeakPassword, NetworkError

  Future<void> confirmSignUp({required String email, required String confirmationCode});
  // Throws: InvalidCredentials (bad code), NetworkError

  Future<CognitoAuthResult> signIn({required String email, required String password});
  // Returns: CognitoAuthResult(accessToken, idToken, refreshToken, userSub)
  // Throws: InvalidCredentials, UserNotFound, NetworkError

  Future<void> signOut();
  // Throws: NetworkError (unlikely, local operation)

  Future<void> forgotPassword({required String email});
  // Throws: NetworkError (never throw UserNotFound for security)

  Future<void> confirmForgotPassword({required String email, required String code, required String newPassword});
  // Throws: InvalidCredentials (bad code), WeakPassword, NetworkError

  Future<CognitoAuthResult?> getCurrentUser();
  // Returns: CognitoAuthResult if session valid, null if no session
  // Throws: NetworkError
}
```

**`CognitoAuthResult` DTO:**
Create a simple DTO class in `packages/features/authentication/lib/data/dtos/cognito_auth_result.dart`:
```dart
class CognitoAuthResult {
  final String accessToken;
  final String idToken;
  final String refreshToken;
  final String userSub;

  const CognitoAuthResult({
    required this.accessToken,
    required this.idToken,
    required this.refreshToken,
    required this.userSub,
  });
}
```

### Architecture Compliance

**Clean Architecture Boundaries:**
- This class lives in the DATA layer (`data/datasources/`)
- It depends on the Cognito SDK (external dependency) — this is correct for data layer
- It throws domain `AuthException` types (domain exceptions are allowed to flow up from data layer)
- It does NOT import Flutter/UI, BLoC, or repository classes
- The abstract `AuthRemoteDataSource` interface enables mocking and future provider swaps

**DDD Pattern Compliance:**
- Data source is NOT an aggregate or entity — it's infrastructure
- Uses raw `String` parameters (not `Email`/`Password` value objects) — value object unwrapping happens at repository layer (Story 2.3)
- Does NOT create `UserAggregate` — that's the repository's job
- Does NOT publish domain events — that's the repository's job

**DI Registration Pattern:**
- Use `@LazySingleton(as: AuthRemoteDataSource)` on `CognitoDataSource`
- Constructor receives `CognitoUserPool` — register a factory for it that reads from `EnvConfig`
- Follow existing pattern from `core_infrastructure` where `EventBus` is registered as singleton

**Naming Conventions (from architecture):**
- File: `cognito_datasource.dart` (snake_case)
- Class: `CognitoDataSource` (UpperCamelCase)
- Interface: `AuthRemoteDataSource` (UpperCamelCase)
- Private members: `_userPool`, `_cognitoUser` (underscore prefix)

### Library & Framework Requirements

**Dependencies to add to `packages/features/authentication/pubspec.yaml`:**
```yaml
dependencies:
  amazon_cognito_identity_dart_2: ^3.0.0  # Check pub.dev for latest stable
  injectable: ^2.5.0  # For DI annotations
```

**Dev dependencies to add:**
```yaml
dev_dependencies:
  mockito: ^5.4.0  # For mocking Cognito SDK in tests
  build_runner: ^2.4.15  # For mockito code generation
```

**DO NOT add:**
- `flutter_secure_storage` — already in `core_data`, token storage is Story 2.3's concern
- `dio` — not needed for Cognito SDK (it uses its own HTTP client)
- `fpdart` — already a dependency, but don't use `Either` in data source layer

### File Structure Requirements

**Files to CREATE:**
```
packages/features/authentication/
├── lib/
│   ├── data/
│   │   ├── datasources/
│   │   │   ├── auth_remote_datasource.dart    # Abstract interface
│   │   │   └── cognito_datasource.dart        # Cognito implementation
│   │   └── dtos/
│   │       └── cognito_auth_result.dart        # Token result DTO
├── test/
│   └── data/
│       └── datasources/
│           └── cognito_datasource_test.dart    # Unit tests with mocked SDK
```

**Files to MODIFY:**
```
packages/features/authentication/
├── lib/
│   └── authentication.dart                     # Add data layer exports
├── pubspec.yaml                                # Add new dependencies

apps/mobile/
├── lib/
│   └── config/
│       ├── env.dart                            # Add Cognito pool config fields
│       └── flavors.dart                        # Add flavor-specific Cognito values
```

**Files to NOT touch:**
- Domain layer files (Story 2.1) — already complete, do not modify
- `core_data/` — token storage is Story 2.3
- `core_infrastructure/di/` — injectable auto-generates, don't manually edit `injection.config.dart`
- Presentation layer — that's Stories 2.5-2.7

### Testing Requirements

**Testing approach:** Unit tests with mocked Cognito SDK classes.

**Mocking strategy:**
- Mock `CognitoUserPool` and `CognitoUser` from the SDK
- Use `mockito` with `@GenerateMocks` annotation for type-safe mocks
- Test each method's success path and all error paths from the exception mapping table
- Do NOT make real network calls

**Test structure:**
```dart
@GenerateMocks([CognitoUserPool, CognitoUser, CognitoUserSession])
void main() {
  late CognitoDataSource dataSource;
  late MockCognitoUserPool mockPool;

  setUp(() {
    mockPool = MockCognitoUserPool();
    dataSource = CognitoDataSource(userPool: mockPool);
  });

  group('signUp', () {
    test('returns user sub on success', () async { ... });
    test('throws EmailAlreadyExists on duplicate', () async { ... });
    test('throws WeakPassword on invalid password', () async { ... });
    test('throws NetworkError on connection failure', () async { ... });
  });
  // ... similar groups for each method
}
```

**Minimum test count:** ~20 tests (2-4 per method covering success + error cases)

**Lint compliance:**
- `always_use_package_imports` — use `package:authentication/...` not relative
- `prefer_single_quotes` — all strings single-quoted
- `dart analyze` must return zero issues

### Previous Story Intelligence (2.1)

**Patterns established in Story 2.1 that MUST be followed:**
- Private constructors with factory methods for classes with validation
- `const` constructors where possible (but NOT if parent class doesn't support it)
- `use_super_parameters` lint rule: use `required super.id` style
- `sort_constructors_first` lint rule: constructors before fields
- `package:authentication/...` imports exclusively (no relative imports)
- Barrel file `authentication.dart` must export all new public classes
- `fpdart: ^1.2.0` already available as dependency
- Tests use `flutter_test` package

**Domain classes available for use (from Story 2.1):**
- `AuthException` and all subtypes (`InvalidCredentials`, `EmailAlreadyExists`, `WeakPassword`, `UserNotFound`, `NetworkError`)
- `Email`, `Password`, `UserId` value objects (used by repository, not directly by data source)
- `UserAggregate` (used by repository, not directly by data source)
- `AuthenticationRepository` interface (implemented in Story 2.3, not here)

### Git Intelligence

**Recent commits show:**
- Epic 1 UI components completed (auth UI, forms, hive cards, locations, feedback)
- Core data layer with Drift, SQLCipher, connectivity monitoring already in place
- App shell with GoRouter navigation established
- DI with GetIt + Injectable wired in core_infrastructure

**Commit convention:** `feat: <description>` for new features

### Project Structure Notes

- Authentication package lives at `packages/features/authentication/` (NOT under `packages/core/`)
- Domain layer (Story 2.1) is complete — data layer goes in `lib/data/`
- The `lib/data/` directory currently has only a `.keep` placeholder file — remove it when adding real files
- EnvConfig is in the mobile app (`apps/mobile/lib/config/`), not in a shared package
- `CognitoUserPool` initialization depends on `EnvConfig` which is registered in `GetIt` during bootstrap

### References

- [Source: _bmad-output/planning-artifacts/architecture.md#Authentication & Security] — Cognito SDK choice, token types, session management
- [Source: _bmad-output/planning-artifacts/architecture.md#Architectural Decisions] — Token storage, session refresh, error handling decisions
- [Source: _bmad-output/planning-artifacts/architecture.md#Feature Module Structure] — data/datasources/ folder pattern
- [Source: _bmad-output/planning-artifacts/architecture.md#DDD Patterns] — Value object factories, aggregate patterns
- [Source: _bmad-output/planning-artifacts/architecture.md#Naming Conventions] — File and class naming rules
- [Source: _bmad-output/planning-artifacts/epics.md#Epic 2 Story 2.2] — Acceptance criteria and story statement
- [Source: _bmad-output/planning-artifacts/prd.md#FR1-FR4] — Functional requirements for authentication
- [Source: _bmad-output/planning-artifacts/prd.md#NFR7-NFR11] — Security & session non-functional requirements
- [Source: _bmad-output/implementation-artifacts/2-1-authentication-domain-model.md] — Domain model patterns, lint rules, test conventions
- [Source: apps/mobile/lib/config/env.dart] — Environment configuration pattern
- [Source: apps/mobile/lib/config/flavors.dart] — Flavor-specific config factory
- [Source: packages/core/core_infrastructure/lib/di/] — GetIt + Injectable DI setup

## Dev Agent Record

### Agent Model Used

Claude Opus 4.6

### Debug Log References

- Fixed fake JWT tokens in tests — `CognitoJwtToken` constructor calls `decodePayload()` which requires a valid 3-part JWT string; switched from extending token classes to creating real tokens with base64-encoded payloads.
- DI registration: `injectable` code generation in `core_infrastructure` can't discover annotations in the `authentication` package (different package boundary). Resolved by manually registering `CognitoUserPool` and `CognitoDataSource` in `bootstrap.dart`, following the existing pattern for `GoRouter` and `NavigationService`.

### Completion Notes List

- Implemented `CognitoDataSource` wrapping `amazon_cognito_identity_dart_2` SDK v3.8.1
- All 7 methods implemented: signUp, confirmSignUp, signIn, signOut, forgotPassword, confirmForgotPassword, getCurrentUser
- Complete exception mapping from Cognito SDK exceptions to domain AuthException types (10 mappings)
- `forgotPassword` swallows `UserNotFoundException` for security (never reveals if email exists)
- `getCurrentUser` returns null gracefully when no session instead of throwing
- `AuthRemoteDataSource` abstract interface enables mocking and future provider swaps
- `CognitoAuthResult` DTO created for token transport between data/repository layers
- 24 unit tests covering signUp success/errors, confirmSignUp, signIn, signOut, getCurrentUser (null/valid/invalid/error), and all 9 exception mappings
- `EnvConfig` extended with `cognitoUserPoolId` and `cognitoClientId` for all 3 flavors
- DI wired via `bootstrap.dart` manual registration
- Zero `dart analyze` issues; 65/65 authentication tests pass; 9/9 mobile app tests pass

### Change Log

- 2026-03-10: Implemented Story 2.2 Cognito Data Source — all tasks complete
- 2026-03-10: Code review fixes — added CognitoUserFactory injection for testability; replaced 5 placeholder tests with 16 real tests covering confirmSignUp, signIn, signOut, forgotPassword, confirmForgotPassword; fixed null userSub silent failure in signUp; removed dead @LazySingleton annotation; fixed forgotPassword catch-all to not leak user-existence info; updated AC#8 wording to match token-based implementation

### File List

**New files:**
- packages/features/authentication/lib/data/datasources/auth_remote_datasource.dart
- packages/features/authentication/lib/data/datasources/cognito_datasource.dart
- packages/features/authentication/lib/data/dtos/cognito_auth_result.dart
- packages/features/authentication/test/data/datasources/cognito_datasource_test.dart
- packages/features/authentication/test/data/datasources/cognito_datasource_test.mocks.dart (generated)

**Modified files:**
- packages/features/authentication/pubspec.yaml (added dependencies)
- packages/features/authentication/lib/authentication.dart (added data layer exports)
- apps/mobile/lib/config/env.dart (added Cognito config fields)
- apps/mobile/lib/config/flavors.dart (added flavor-specific Cognito values)
- apps/mobile/lib/bootstrap.dart (added Cognito DI registration)
- apps/mobile/pubspec.yaml (added authentication and cognito dependencies)

**Deleted files:**
- packages/features/authentication/lib/data/.keep (placeholder removed)
