# Story 1.2: Core Domain Package

Status: done

## Story

As a developer,
I want a complete `shared` package (core_domain equivalent) with DDD base classes, Failure types, and UniqueId utility,
So that all feature modules can use consistent domain modeling patterns.

## Acceptance Criteria

1. **Given** the shared package exists **When** I import `package:shared/shared.dart` **Then** it exports AggregateRoot, Entity, ValueObject, DomainEvent base classes
2. **And** DomainException abstract class is exported for typed domain errors
3. **And** Failure sealed class hierarchy is exported with pattern-matching support
4. **And** UniqueId utility class generates UUID v4 identifiers
5. **And** all base classes have comprehensive unit tests with 100% coverage
6. **And** `melos run analyze` passes with no errors in the shared package
7. **And** `melos run test` passes for the shared package

## Tasks / Subtasks

- [x] Task 1: Create barrel export file (AC: #1)
  - [x] 1.1 Create `packages/shared/lib/shared.dart` barrel file
  - [x] 1.2 Export all domain base classes through single entry point
  - [x] 1.3 Verify import works from other packages

- [x] Task 2: Add DomainException base class (AC: #2)
  - [x] 2.1 Create `packages/shared/lib/domain/exceptions/domain_exception.dart`
  - [x] 2.2 Implement abstract DomainException with `message` getter
  - [x] 2.3 Add to barrel export

- [x] Task 3: Implement Failure sealed class hierarchy (AC: #3)
  - [x] 3.1 Create `packages/shared/lib/domain/failures/failure.dart`
  - [x] 3.2 Implement `sealed class Failure` with common failure types
  - [x] 3.3 Add subtypes: ServerFailure, CacheFailure, NetworkFailure, ValidationFailure, UnexpectedFailure
  - [x] 3.4 Ensure exhaustive pattern matching works with switch expressions
  - [x] 3.5 Add to barrel export

- [x] Task 4: Implement UniqueId utility (AC: #4)
  - [x] 4.1 Add `uuid` package to shared/pubspec.yaml dependencies
  - [x] 4.2 Create `packages/shared/lib/domain/value_objects/unique_id.dart`
  - [x] 4.3 Implement UniqueId as ValueObject with UUID v4 generation
  - [x] 4.4 Add factory constructor for generating new IDs
  - [x] 4.5 Add factory constructor for reconstituting from string
  - [x] 4.6 Add to barrel export

- [x] Task 5: Write comprehensive unit tests (AC: #5)
  - [x] 5.1 Add `test` package to shared/pubspec.yaml dev_dependencies
  - [x] 5.2 Create `test/domain/aggregate_root_test.dart`
  - [x] 5.3 Create `test/domain/entity_test.dart`
  - [x] 5.4 Create `test/domain/value_object_test.dart`
  - [x] 5.5 Create `test/domain/domain_event_test.dart`
  - [x] 5.6 Create `test/domain/exceptions/domain_exception_test.dart`
  - [x] 5.7 Create `test/domain/failures/failure_test.dart`
  - [x] 5.8 Create `test/domain/value_objects/unique_id_test.dart`

- [x] Task 6: Verify melos commands pass (AC: #6, #7)
  - [x] 6.1 Run `melos bootstrap` to update dependencies
  - [x] 6.2 Run `melos run analyze` - fix any errors
  - [x] 6.3 Run `melos run test` - ensure all tests pass

## Dev Notes

### CRITICAL: Existing Project State

**This story ENHANCES an existing package.** The `packages/shared/` package already contains:

```
packages/shared/
├── pubspec.yaml              # resolution: workspace, sdk ^3.10.3
└── lib/
    └── domain/
        ├── aggregate_root.dart   # ✅ DONE - AggregateRoot<ID> with event tracking
        ├── entity.dart           # ✅ DONE - Entity<ID> with identity equality
        ├── value_object.dart     # ✅ DONE - ValueObject with props equality
        └── domain_event.dart     # ✅ DONE - DomainEvent with aggregateId, occurredAt
```

**What Needs to Be Added:**

| Component | Status | Location |
|-----------|--------|----------|
| Barrel export | ❌ NEW | `lib/shared.dart` |
| DomainException | ❌ NEW | `lib/domain/exceptions/domain_exception.dart` |
| Failure sealed class | ❌ NEW | `lib/domain/failures/failure.dart` |
| UniqueId | ❌ NEW | `lib/domain/value_objects/unique_id.dart` |
| Unit tests | ❌ NEW | `test/domain/**/*_test.dart` |

### Architecture Patterns (MUST FOLLOW)

**From architecture.md - DomainException Hierarchy:**

```dart
// In core_domain (shared package)
abstract class DomainException implements Exception {
  String get message;
}

// Feature modules extend this:
// abstract class HiveException extends DomainException {}
// class HiveNotFoundException extends HiveException { ... }
```

**From architecture.md - Failure Pattern:**

The architecture specifies using `Either<DomainException, T>` for repository return types. However, the epics mention a `Failure` sealed class. We should implement BOTH:

1. `DomainException` - for throwing typed exceptions
2. `Failure` - sealed class for functional error handling with Either

**Dart 3 Sealed Class Pattern:**

```dart
sealed class Failure {
  const Failure([this.message]);
  final String? message;
}

final class ServerFailure extends Failure {
  const ServerFailure([super.message]);
}

final class CacheFailure extends Failure {
  const CacheFailure([super.message]);
}
// etc.
```

**UniqueId Pattern (from architecture.md):**

```dart
class UniqueId extends ValueObject {
  final String value;

  const UniqueId._(this.value);

  factory UniqueId() => UniqueId._(const Uuid().v4());

  factory UniqueId.fromString(String id) => UniqueId._(id);

  @override
  List<Object?> get props => [value];
}
```

### Technical Requirements

**uuid Package (2026 Latest):**
- Package: `uuid: ^4.5.1` (latest stable)
- Supports RFC4122 v1, v4, v5 and RFC9562 v6, v7, v8
- Use `Uuid().v4()` for cryptographically secure random IDs
- Consider v7 for time-ordered IDs in future (database optimization)

**Dart 3 Sealed Classes:**
- Use `sealed` keyword for exhaustive pattern matching
- Subclasses must be in same library file
- Use `final class` for subtypes that shouldn't be extended
- Pattern matching with `switch` expressions is fully supported

**Test Package:**
- Use `test: ^1.25.0` for pure Dart packages (not flutter_test)
- Tests should mirror lib/ structure
- Aim for 100% coverage on base classes

### Naming Conventions (MUST FOLLOW)

| Element | Convention | Example |
|---------|------------|---------|
| Files | snake_case | `domain_exception.dart`, `unique_id.dart` |
| Classes | UpperCamelCase | `DomainException`, `UniqueId` |
| Test files | snake_case + _test | `domain_exception_test.dart` |

### Dependency Rules

- `packages/shared` has NO external Flutter dependencies
- Only pure Dart packages allowed: `uuid`, `test`
- This package is imported by ALL feature modules
- Keep it minimal to avoid dependency bloat

### Previous Story Learnings (from Story 1-1)

1. **Package imports required** - Use `import 'package:shared/...'` not relative imports
2. **Resolution workspace** - pubspec.yaml must have `resolution: workspace`
3. **Melos bootstrap** - Always run after adding dependencies
4. **Test package for Dart** - Use `test: ^1.25.0` not flutter_test

### File Structure After Completion

```
packages/shared/
├── pubspec.yaml
├── lib/
│   ├── shared.dart                           # NEW: Barrel export
│   └── domain/
│       ├── aggregate_root.dart               # EXISTS
│       ├── entity.dart                       # EXISTS
│       ├── value_object.dart                 # EXISTS
│       ├── domain_event.dart                 # EXISTS
│       ├── exceptions/
│       │   └── domain_exception.dart         # NEW
│       ├── failures/
│       │   └── failure.dart                  # NEW
│       └── value_objects/
│           └── unique_id.dart                # NEW
└── test/
    └── domain/
        ├── aggregate_root_test.dart          # NEW
        ├── entity_test.dart                  # NEW
        ├── value_object_test.dart            # NEW
        ├── domain_event_test.dart            # NEW
        ├── exceptions/
        │   └── domain_exception_test.dart    # NEW
        ├── failures/
        │   └── failure_test.dart             # NEW
        └── value_objects/
            └── unique_id_test.dart           # NEW
```

### References

- [Source: architecture.md#DDD-Patterns] - Value Object, Entity, Aggregate patterns
- [Source: architecture.md#Error-Handling-Patterns] - DomainException hierarchy
- [Source: architecture.md#Implementation-Patterns] - Naming conventions
- [Source: epics.md#Story-1.2] - Original AC
- [Source: uuid package](https://pub.dev/packages/uuid) - UUID v4 generation
- [Source: Dart sealed classes](https://dart.dev/language/class-modifiers#sealed) - Exhaustive pattern matching

### Latest Technical Information

**uuid Package 4.5.x (2026):**
- RFC4122 v4 provides cryptographically secure random UUIDs
- Use `const Uuid()` for singleton instance
- `uuid.v4()` generates 36-character string format
- Consider binary storage (16 bytes) for database optimization

**Dart 3 Sealed Classes:**
- `sealed` modifier restricts subclasses to same library
- Enables exhaustive `switch` expressions
- Compiler warns on missing cases
- Use `final class` for leaf subtypes

**Sources:**
- [uuid | Dart package](https://pub.dev/packages/uuid)
- [fpdart | Dart package](https://pub.dev/packages/fpdart)
- [Dart Sealed Classes - zetcode](https://www.zetcode.com/dart/sealed-classes/)

## Dev Agent Record

### Agent Model Used

Claude Opus 4.5 (claude-opus-4-5-20251101)

### Debug Log References

- melos bootstrap: SUCCESS (12 packages bootstrapped)
- melos run analyze: SUCCESS (shared package: no errors, only info warnings)
- dart test packages/shared: SUCCESS (99 tests pass)
- coverage: 100% line coverage on all lib/ files

### Completion Notes List

1. **Task 1 Complete:** Created `packages/shared/lib/shared.dart` barrel file exporting all domain classes: AggregateRoot, Entity, ValueObject, DomainEvent, DomainException, Failure hierarchy, and UniqueId. Used `library;` directive to satisfy linting rules.

2. **Task 2 Complete:** Created `DomainException` abstract class implementing `Exception` with `message` getter. Includes comprehensive documentation with examples for feature module extension patterns.

3. **Task 3 Complete:** Implemented `Failure` sealed class hierarchy with 5 final subclasses: `ServerFailure`, `CacheFailure`, `NetworkFailure`, `ValidationFailure`, and `UnexpectedFailure`. All support exhaustive pattern matching with `switch` expressions. `ValidationFailure` has custom equality for `errors` list. `ServerFailure` includes factory for HTTP status codes.

4. **Task 4 Complete:** Implemented `UniqueId` extending `ValueObject` with UUID v4 generation via `uuid: ^4.5.1` package. Provides two constructors: `UniqueId()` for new IDs and `UniqueId.fromString()` for reconstitution.

5. **Task 5 Complete:** Created 7 comprehensive test files with 90 tests total:
   - `aggregate_root_test.dart` - 10 tests
   - `entity_test.dart` - 8 tests
   - `value_object_test.dart` - 12 tests
   - `domain_event_test.dart` - 10 tests
   - `domain_exception_test.dart` - 10 tests
   - `failure_test.dart` - 28 tests (including pattern matching tests)
   - `unique_id_test.dart` - 12 tests

6. **Task 6 Complete:** Verified all commands pass:
   - `melos bootstrap`: 12 packages bootstrapped successfully
   - `melos run analyze`: No errors in shared package (only info-level warnings)
   - `dart test packages/shared`: All 99 tests pass (9 new tests added during code review)

7. **Code Review Fixes:**
   - Added UUID format validation to `UniqueId.fromString()` - throws `FormatException` for invalid UUIDs
   - Made `ValidationFailure.errors` immutable using `List.unmodifiable()` to prevent mutation
   - Added `coverage: ^1.9.2` dev dependency for coverage verification
   - Added 9 new tests for validation and immutability
   - Verified 100% line coverage on all lib/ files

### File List

**New Files Created:**
- packages/shared/lib/shared.dart
- packages/shared/lib/domain/exceptions/domain_exception.dart
- packages/shared/lib/domain/failures/failure.dart
- packages/shared/lib/domain/value_objects/unique_id.dart
- packages/shared/test/domain/aggregate_root_test.dart
- packages/shared/test/domain/entity_test.dart
- packages/shared/test/domain/value_object_test.dart
- packages/shared/test/domain/domain_event_test.dart
- packages/shared/test/domain/exceptions/domain_exception_test.dart
- packages/shared/test/domain/failures/failure_test.dart
- packages/shared/test/domain/value_objects/unique_id_test.dart

**Modified Files:**
- packages/shared/pubspec.yaml (added uuid dependency and test dev_dependency)

## Change Log

- 2026-02-23: Story created with comprehensive context from epics, architecture, and previous story learnings.
- 2026-02-23: Story implemented - all 6 tasks complete. Created barrel export, DomainException, Failure sealed class hierarchy, UniqueId utility, and 90 comprehensive unit tests. All tests pass. Status → review.
- 2026-02-23: Code review completed. Fixed UniqueId validation (throws FormatException for invalid UUIDs), fixed ValidationFailure.errors immutability (uses List.unmodifiable), added coverage tooling, added 9 new tests. 99 tests pass, 100% coverage verified. Status → done.
