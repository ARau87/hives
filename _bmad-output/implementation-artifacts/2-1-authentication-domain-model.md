# Story 2.1: Authentication Domain Model

Status: done

<!-- Note: Validation is optional. Run validate-create-story for quality check before dev-story. -->

## Story

As a developer,
I want domain models for authentication,
So that auth logic follows DDD patterns consistent with other modules.

## Acceptance Criteria

1. `UserAggregate` exists extending `AggregateRoot<UserId>` with immutable fields and DDD factory methods
2. `UserId` value object extends `UniqueId` from shared package (UUID v4 validation built-in)
3. `Email` value object with format validation — static factory `Email.create(String)` returns `Either<AuthException, Email>`
4. `Password` value object with strength validation (min 8 chars + complexity) — static factory `Password.create(String)` returns `Either<AuthException, Password>`
5. `AuthRepository` interface defines: `signUp`, `signIn`, `signOut`, `resetPassword`, `getCurrentUser` — all return `Either<AuthException, T>` or `Future<Either<AuthException, T>>`
6. `AuthException` hierarchy exists: `InvalidCredentials`, `EmailAlreadyExists`, `WeakPassword`, `UserNotFound`, `NetworkError`
7. `AuthUserLoggedIn` and `AuthUserLoggedOut` domain events exist (extend `DomainEvent` from shared)
8. All domain classes exported via `packages/features/authentication/lib/authentication.dart` barrel file
9. Unit tests verify all value object validation logic (valid + invalid cases for Email and Password)
10. `dart analyze` passes with 0 errors, all tests pass

## Tasks / Subtasks

- [x] Task 1: Add fpdart dependency (AC: #3, #4, #5)
  - [x] 1.1 Add `fpdart: ^1.2.0` to `packages/features/authentication/pubspec.yaml` dependencies
  - [x] 1.2 Run `melos bootstrap` to wire dependencies

- [x] Task 2: Rework UserId value object (AC: #2)
  - [x] 2.1 Modify `lib/domain/value_objects/user_id.dart` — change to extend `UniqueId` from `package:shared/shared.dart`; provide `UserId()` (generates new UUID) and `UserId.fromString(String value)` (reconstitutes, validates UUID format) constructors

- [x] Task 3: Rework Email value object with validation (AC: #3)
  - [x] 3.1 Modify `lib/domain/value_objects/email.dart` — add private constructor `const Email._(this.value)`; remove public `const Email(value)` constructor; add static factory `Email.create(String input)` returning `Either<AuthException, Email>` using RFC 5322-compatible regex validation; keep `final String value` field and `props` override

- [x] Task 4: Create Password value object (AC: #4)
  - [x] 4.1 Create `lib/domain/value_objects/password.dart` — `Password` extends `ValueObject` with private constructor `const Password._(this.value)` and static factory `Password.create(String input)` returning `Either<AuthException, Password>`; validation rules: min 8 chars, at least 1 uppercase, 1 lowercase, 1 digit; return `WeakPassword` on failure

- [x] Task 5: Create AuthException hierarchy (AC: #6)
  - [x] 5.1 Create `lib/domain/exceptions/auth_exceptions.dart` — `abstract class AuthException extends DomainException`; concrete subtypes: `InvalidCredentials`, `EmailAlreadyExists`, `WeakPassword`, `UserNotFound`, `NetworkError` — each with `@override String get message`

- [x] Task 6: Create domain events (AC: #7)
  - [x] 6.1 Create `lib/domain/events/auth_events.dart` — `AuthUserLoggedIn extends DomainEvent` (constructor takes `UserId userId`, calls `super(aggregateId: userId.value)`); `AuthUserLoggedOut extends DomainEvent` (constructor takes `String userId`, calls `super(aggregateId: userId)`)

- [x] Task 7: Rework UserAggregate with DDD factory pattern (AC: #1)
  - [x] 7.1 Modify `lib/domain/aggregates/user_aggregate.dart` — make all fields `final`; add private constructor `UserAggregate._({required UserId id, required Email email, ...})`; add `UserAggregate.create({required String emailStr})` factory that validates email via `Email.create()`, creates `UserId()`, and raises `AuthUserLoggedIn` via `addEvent()`; add `UserAggregate.reconstitute({required String id, required String email, ...})` factory for DB loading (no events); remove old public constructor

- [x] Task 8: Rework AuthenticationRepository interface (AC: #5)
  - [x] 8.1 Modify `lib/domain/repositories/authentication_repository.dart` — replace existing minimal interface; add all 5 methods: `signUp`, `signIn`, `signOut`, `resetPassword`, `getCurrentUser`; all async methods return `Future<Either<AuthException, T>>`; use typed value objects as parameters (Email, Password) not raw strings

- [x] Task 9: Create barrel file (AC: #8)
  - [x] 9.1 Create `lib/authentication.dart` — export all domain classes: value objects (user_id, email, password), exceptions (auth_exceptions), events (auth_events), aggregates (user_aggregate), repositories (authentication_repository)

- [x] Task 10: Write unit tests (AC: #9, #10)
  - [x] 10.1 Create `test/domain/value_objects/email_test.dart` — test valid email accepted (`Right`), invalid format rejected (`Left(EmailAlreadyExists-adjacentType)`), empty string rejected, no-@ rejected, no-domain rejected
  - [x] 10.2 Create `test/domain/value_objects/password_test.dart` — test valid password (8+ chars, mixed case, digit) accepted (`Right`), too short rejected, no uppercase rejected, no digit rejected; verify `WeakPassword` exception returned
  - [x] 10.3 Create `test/domain/value_objects/user_id_test.dart` — test `UserId()` generates valid UUID, `UserId.fromString(validUUID)` succeeds, `UserId.fromString('invalid')` throws `FormatException`, equality works
  - [x] 10.4 Create `test/domain/aggregates/user_aggregate_test.dart` — test `UserAggregate.create()` with valid email produces aggregate with event, `UserAggregate.reconstitute()` produces aggregate without events
  - [x] 10.5 Run `dart analyze` from `packages/features/authentication/` — zero errors; Run `flutter test` — all tests pass

## Dev Notes

### 🚨 CRITICAL: Partial Stubs Already Exist — MODIFY, DO NOT RECREATE

The authentication package at `packages/features/authentication/` already has **skeleton files that must be MODIFIED**, not deleted and recreated:

| File | Current State | Required Change |
|------|---------------|-----------------|
| `lib/domain/aggregates/user_aggregate.dart` | Bare stub, mutable fields, no factory pattern, no events | Major rework |
| `lib/domain/value_objects/email.dart` | No validation, public constructor | Add `create()` + validation |
| `lib/domain/value_objects/user_id.dart` | Extends ValueObject directly, no UUID | Change to extend UniqueId |
| `lib/domain/repositories/authentication_repository.dart` | Only `login`/`logout`, no Either | Full rework of all methods |

**Missing files to CREATE:**
- `lib/domain/value_objects/password.dart`
- `lib/domain/exceptions/auth_exceptions.dart`
- `lib/domain/events/auth_events.dart`
- `lib/authentication.dart` (barrel)
- `test/` directory and all test files

### Architecture Compliance

- **Package path:** `packages/features/authentication/` (NOT `packages/core/` — this is a feature bounded context)
- **Dependency flow:** `authentication → shared` (core domain base classes). Do NOT import `core_infrastructure`, `ui`, or any other feature packages in Story 2.1 domain files.
- **No Flutter dependency in domain layer:** The domain files (value objects, aggregates, exceptions, events) should NOT import `flutter/material.dart` or any Flutter SDK. Pure Dart only.
- **fpdart is workspace-resolved:** Add `fpdart: ^1.2.0` to the authentication `pubspec.yaml`. Do NOT add it to `shared/pubspec.yaml`.

### Existing Base Classes from `shared` Package — EXACT API

Import via `package:shared/shared.dart`. All exports are in the barrel.

**`ValueObject` (NOT generic — no type parameter):**
```dart
abstract class ValueObject {
  const ValueObject();
  List<Object?> get props;  // Override to define equality
  // == and hashCode implemented via props
}
```

**`UniqueId` extends `ValueObject`:**
```dart
class UniqueId extends ValueObject {
  UniqueId() : value = _uuid.v4();           // generates new UUID v4
  UniqueId.fromString(this.value) {          // reconstitute — throws FormatException if invalid UUID
    if (!_uuidPattern.hasMatch(value)) throw FormatException('Invalid UUID format: $value');
  }
  final String value;
  @override List<Object?> get props => [value];
}
```

**`AggregateRoot<ID>` (typed):**
```dart
abstract class AggregateRoot<ID> {
  AggregateRoot({required this.id});
  final ID id;
  List<DomainEvent> get events;              // unmodifiable view
  void addEvent(DomainEvent event);          // NOTE: addEvent(), NOT addDomainEvent()
  void clearEvents();
}
```

**`DomainEvent` (requires aggregateId as String):**
```dart
abstract class DomainEvent {
  DomainEvent({required this.aggregateId, DateTime? occurredAt});
  final String aggregateId;   // NOTE: String, not typed ID
  final DateTime occurredAt;
}
```

**`DomainException` (abstract):**
```dart
abstract class DomainException implements Exception {
  String get message;         // override this
}
```

### fpdart Either Pattern

Use `package:fpdart/fpdart.dart` for `Either<L, R>`.

```dart
import 'package:fpdart/fpdart.dart';

// Creating Either values:
Either<AuthException, Email> result = left(InvalidCredentials());  // failure
Either<AuthException, Email> result = right(Email._('user@example.com'));  // success

// Or using constructors:
return Left(WeakPassword());
return Right(Email._('user@example.com'));

// Consuming Either (in BLoC, Story 2.4):
result.fold(
  (exception) => print('Error: $exception'),
  (email) => print('Valid: ${email.value}'),
);
// OR
result.match(
  (exception) => ...,
  (value) => ...,
);
```

### Exact Implementation Patterns

**UserId — extend UniqueId:**
```dart
import 'package:shared/shared.dart';

class UserId extends UniqueId {
  UserId() : super();
  UserId.fromString(String value) : super.fromString(value);
}
```

**Email — private constructor + factory validation:**
```dart
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';
import 'package:authentication/domain/exceptions/auth_exceptions.dart';

class Email extends ValueObject {
  const Email._(this.value);

  final String value;

  static Either<AuthException, Email> create(String input) {
    if (!_emailRegex.hasMatch(input.trim())) {
      return left(const InvalidCredentials());  // or a more specific exception
    }
    return right(Email._(input.trim()));
  }

  static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$',
  );

  @override
  List<Object?> get props => [value];
}
```

**Password — strength validation:**
```dart
static Either<AuthException, Password> create(String input) {
  if (input.length < 8) return left(const WeakPassword('Password must be at least 8 characters'));
  if (!RegExp(r'[A-Z]').hasMatch(input)) return left(const WeakPassword('Password must contain an uppercase letter'));
  if (!RegExp(r'[a-z]').hasMatch(input)) return left(const WeakPassword('Password must contain a lowercase letter'));
  if (!RegExp(r'[0-9]').hasMatch(input)) return left(const WeakPassword('Password must contain a digit'));
  return right(Password._(input));
}
```

**AuthException hierarchy:**
```dart
import 'package:shared/shared.dart';

abstract class AuthException extends DomainException {}

final class InvalidCredentials extends AuthException {
  const InvalidCredentials();
  @override String get message => 'Invalid email or password';
}

final class EmailAlreadyExists extends AuthException {
  const EmailAlreadyExists();
  @override String get message => 'Email address is already registered';
}

final class WeakPassword extends AuthException {
  const WeakPassword([this._detail = 'Password does not meet requirements']);
  final String _detail;
  @override String get message => _detail;
}

final class UserNotFound extends AuthException {
  const UserNotFound();
  @override String get message => 'User not found';
}

final class NetworkError extends AuthException {
  const NetworkError([this._detail = 'A network error occurred']);
  final String _detail;
  @override String get message => _detail;
}
```

**DomainEvents:**
```dart
import 'package:shared/shared.dart';
import 'package:authentication/domain/value_objects/user_id.dart';

class AuthUserLoggedIn extends DomainEvent {
  AuthUserLoggedIn({required this.userId})
      : super(aggregateId: userId.value);

  final UserId userId;
}

class AuthUserLoggedOut extends DomainEvent {
  AuthUserLoggedOut({required String userId})
      : super(aggregateId: userId);
}
```

**UserAggregate — DDD factory pattern:**
```dart
class UserAggregate extends AggregateRoot<UserId> {
  UserAggregate._({
    required UserId id,
    required this.email,
    required this.createdAt,
  }) : super(id: id);

  final Email email;
  final DateTime createdAt;

  /// Factory for new user registration. Validates email and raises AuthUserLoggedIn event.
  static Either<AuthException, UserAggregate> create({
    required String email,
  }) {
    return Email.create(email).map((validEmail) {
      final userId = UserId();
      final aggregate = UserAggregate._(
        id: userId,
        email: validEmail,
        createdAt: DateTime.now(),
      );
      aggregate.addEvent(AuthUserLoggedIn(userId: userId));
      return aggregate;
    });
  }

  /// Factory for reconstitution from persistence. No events raised.
  factory UserAggregate.reconstitute({
    required String id,
    required String email,
    required DateTime createdAt,
  }) {
    return UserAggregate._(
      id: UserId.fromString(id),
      email: Email._(email),
      createdAt: createdAt,
    );
  }
}
```

**AuthenticationRepository interface:**
```dart
import 'package:fpdart/fpdart.dart';
import 'package:authentication/domain/aggregates/user_aggregate.dart';
import 'package:authentication/domain/exceptions/auth_exceptions.dart';
import 'package:authentication/domain/value_objects/email.dart';
import 'package:authentication/domain/value_objects/password.dart';

abstract class AuthenticationRepository {
  Future<Either<AuthException, UserAggregate>> signUp({
    required Email email,
    required Password password,
  });

  Future<Either<AuthException, UserAggregate>> signIn({
    required Email email,
    required Password password,
  });

  Future<Either<AuthException, Unit>> signOut();

  Future<Either<AuthException, Unit>> resetPassword({
    required Email email,
  });

  Future<Either<AuthException, UserAggregate?>> getCurrentUser();
}
```

Note: `Unit` is from fpdart — equivalent to `void` but usable as a type.

### File Structure

All work is within `packages/features/authentication/`:

```
packages/features/authentication/
├── pubspec.yaml                          (MODIFY — add fpdart)
├── lib/
│   ├── authentication.dart               (NEW — barrel file)
│   ├── domain/
│   │   ├── aggregates/
│   │   │   └── user_aggregate.dart       (MODIFY — major rework)
│   │   ├── value_objects/
│   │   │   ├── user_id.dart              (MODIFY — extend UniqueId)
│   │   │   ├── email.dart                (MODIFY — add validation + Either)
│   │   │   └── password.dart             (NEW)
│   │   ├── exceptions/
│   │   │   └── auth_exceptions.dart      (NEW)
│   │   ├── events/
│   │   │   └── auth_events.dart          (NEW)
│   │   └── repositories/
│   │       └── authentication_repository.dart  (MODIFY — full rework)
│   ├── data/.keep          (leave as-is, Story 2.2 will populate)
│   ├── app/.keep           (leave as-is, Story 2.4+ will populate)
│   └── ui/.keep            (leave as-is, Story 2.5+ will populate)
└── test/
    └── domain/
        ├── value_objects/
        │   ├── email_test.dart            (NEW)
        │   ├── password_test.dart         (NEW)
        │   └── user_id_test.dart          (NEW)
        └── aggregates/
            └── user_aggregate_test.dart   (NEW)
```

### Important: Naming Discrepancy — Repository File

The existing file is `authentication_repository.dart` with class `AuthenticationRepository`.
The architecture document shows `auth_repository.dart` with class `AuthRepository`.

**Decision: Keep the existing filename and class name** (`authentication_repository.dart`, `AuthenticationRepository`) to avoid breaking the package's existing references. Document this variance in the story.

### Lint Rules (from analysis_options.yaml at root)

- `always_use_package_imports` — use `package:authentication/...`, never relative imports
- `prefer_single_quotes` — all strings
- `prefer_const_constructors` — use `const` where possible (especially for exception instances)

### Testing Patterns

Tests for pure Dart packages use `package:test/test.dart` (not `flutter_test`).
The `shared/pubspec.yaml` uses `test: ^1.25.0`. Do the same in `authentication/pubspec.yaml` dev_dependencies.

```dart
import 'package:test/test.dart';
import 'package:authentication/authentication.dart';

void main() {
  group('Email', () {
    group('create()', () {
      test('accepts valid email', () {
        final result = Email.create('user@example.com');
        expect(result.isRight(), isTrue);
        result.fold(
          (_) => fail('Should be Right'),
          (email) => expect(email.value, 'user@example.com'),
        );
      });

      test('rejects email without @', () {
        final result = Email.create('userexample.com');
        expect(result.isLeft(), isTrue);
      });

      test('rejects empty string', () {
        final result = Email.create('');
        expect(result.isLeft(), isTrue);
      });
    });
  });
}
```

Note: Test runner for pure Dart is `dart test`, not `flutter test`. But `flutter test` also works since authentication depends on flutter SDK.

### Previous Story Learnings (from Story 1.9)

- **Package imports rule:** `always_use_package_imports` is enforced — never use relative imports (`import '../foo.dart'`), always use `package:authentication/...`
- **Dart analyze matters:** Run `dart analyze` to catch import errors, unused imports, and type issues before claiming completion
- **Async bootstrap pattern:** Now async — not directly relevant to domain story, but shows project practices
- **`fpdart` version `^1.2.0`** is already in `packages/core/core_data/pubspec.yaml` — same version to use here

### Git Intelligence

Recent commits follow `feat:` prefix. Each story produces a focused commit. Story 2.1 should be committed as `feat: add authentication domain model with value objects, exceptions, and repository interface`.

### Project Structure Notes

- **`shared` = `core_domain`** in architecture language. Architecture says `import from core_domain` → actual import is `package:shared/shared.dart`
- **`packages/features/authentication/`** not `packages/core/authentication/` — it's a feature bounded context
- **No `core_ui`/`ui` imports in domain layer** — pure domain = no Flutter widgets
- Architecture shows `authentication.dart` barrel but existing stub has NO barrel file — must create

### References

- [Source: _bmad-output/planning-artifacts/epics.md#Story 2.1]
- [Source: _bmad-output/planning-artifacts/epics.md#Epic 2: User Authentication]
- [Source: _bmad-output/planning-artifacts/architecture.md#Authentication & Security]
- [Source: _bmad-output/planning-artifacts/architecture.md#DDD Patterns]
- [Source: _bmad-output/planning-artifacts/architecture.md#Authentication Module Structure (Lines 907-943)]
- [Source: _bmad-output/planning-artifacts/architecture.md#Error Handling Patterns]
- [Source: packages/shared/lib/domain/aggregate_root.dart — AggregateRoot.addEvent() API]
- [Source: packages/shared/lib/domain/value_object.dart — ValueObject (no type param)]
- [Source: packages/shared/lib/domain/value_objects/unique_id.dart — UniqueId pattern]
- [Source: packages/shared/lib/domain/exceptions/domain_exception.dart — DomainException API]
- [Source: packages/shared/lib/domain/domain_event.dart — DomainEvent(aggregateId: String)]
- [Source: packages/features/authentication/lib/domain/aggregates/user_aggregate.dart — existing stub]
- [Source: packages/features/authentication/lib/domain/value_objects/email.dart — existing stub]
- [Source: packages/features/authentication/lib/domain/value_objects/user_id.dart — existing stub]
- [Source: packages/features/authentication/lib/domain/repositories/authentication_repository.dart — existing stub]
- [Source: packages/core/core_data/pubspec.yaml — fpdart: ^1.2.0]

## Dev Agent Record

### Agent Model Used

Claude Sonnet 4.6

### Debug Log References

N/A — No significant debugging required. All issues resolved during implementation.

### Completion Notes List

1. **`Email.fromStorage` added**: The story template showed `Email._(email)` in `UserAggregate.reconstitute()`, but `_` constructors are file-private in Dart. Added `const Email.fromStorage(this.value)` as an explicit public named constructor for trusted-storage reconstitution, avoiding cross-file private access.

2. **`const` removed from exception constructors**: `DomainException` does not define a `const` constructor, so all `final class` exception subtypes cannot use `const`. Removed `const` from all constructors in `auth_exceptions.dart` and from all call-sites (`left(InvalidCredentials())` not `left(const InvalidCredentials())`).

3. **`super.id` parameter**: Used `required super.id` in `UserAggregate._` constructor instead of `required UserId id` + `: super(id: id)` to satisfy `use_super_parameters` lint.

4. **Constructor ordering**: `sort_constructors_first` lint required reorganizing `UserAggregate` — private constructor first, factory constructor second, fields third, static factory method last.

5. **Repository naming**: Kept existing `AuthenticationRepository` / `authentication_repository.dart` convention rather than renaming to `AuthRepository` / `auth_repository.dart` per architecture docs, to avoid breaking package internal references.

6. **Tests use `flutter_test`**: Despite the story dev notes recommending `package:test/test.dart` for pure Dart, the authentication package depends on Flutter SDK (`shared` has Flutter dependency chain), so `package:flutter_test/flutter_test.dart` was used. All 40 tests pass.

7. **`dart analyze` zero issues**: After all fixes, running `dart analyze packages/features/authentication/` returns "No issues found!".

### File List

**Modified:**
- `packages/features/authentication/pubspec.yaml` — added `fpdart: ^1.2.0` and `test: ^1.25.0`
- `packages/features/authentication/lib/domain/value_objects/user_id.dart` — reworked to extend `UniqueId`
- `packages/features/authentication/lib/domain/value_objects/email.dart` — added validation, `Either`, private constructor, `fromStorage` constructor
- `packages/features/authentication/lib/domain/aggregates/user_aggregate.dart` — full DDD rework with factory pattern, immutable fields, domain events
- `packages/features/authentication/lib/domain/repositories/authentication_repository.dart` — full rework with 5 typed `Either`-returning methods

**Created:**
- `packages/features/authentication/lib/authentication.dart` — barrel file exporting all domain classes
- `packages/features/authentication/lib/domain/value_objects/password.dart` — strength-validated password value object
- `packages/features/authentication/lib/domain/exceptions/auth_exceptions.dart` — `AuthException` hierarchy (5 concrete types)
- `packages/features/authentication/lib/domain/events/auth_events.dart` — `AuthUserLoggedIn` and `AuthUserLoggedOut` domain events
- `packages/features/authentication/test/domain/value_objects/email_test.dart` — 11 tests
- `packages/features/authentication/test/domain/value_objects/password_test.dart` — 10 tests
- `packages/features/authentication/test/domain/value_objects/user_id_test.dart` — 10 tests
- `packages/features/authentication/test/domain/aggregates/user_aggregate_test.dart` — 9 tests

### Change Log

| Version | Date | Description |
|---------|------|-------------|
| v1.0 | 2026-03-05 | Initial implementation — all 10 tasks complete, 40/40 tests passing, `dart analyze` zero issues |
| v1.1 | 2026-03-05 | Code review fixes — M1: `AuthUserLoggedOut` now takes typed `UserId` + exposes `final UserId userId` field; M2: Password validation regexes promoted to `static final` constants; L2: removed unused `test: ^1.25.0` dev dependency; L4: added `reconstitute()` FormatException test (41/41 tests passing) |
