---
stepsCompleted: ['step-01-validate-prerequisites', 'step-02-design-epics', 'step-03-create-stories', 'step-04-final-validation']
status: complete
completedAt: '2026-02-21'
inputDocuments:
  - prd.md
  - architecture.md
  - ux-design-specification.md
  - prd-validation-report.md
---

# hives - Epic Breakdown

## Overview

This document provides the complete epic and story breakdown for hives, decomposing the requirements from the PRD, UX Design if it exists, and Architecture requirements into implementable stories.

## Requirements Inventory

### Functional Requirements

FR1: Users can create an account using AWS authentication
FR2: Users can sign in to access their data
FR3: Users can sign out from the app
FR4: Users can recover access if they forget credentials
FR5: Users can create locations (apiaries) with a name
FR6: Users can set a map pin for each location
FR7: Users can view all locations on a map
FR8: Users can edit location details
FR9: Users can delete a location (with confirmation)
FR10: Users can view a list of all their locations
FR11: Users can add hives to a location
FR12: Users can name hives (custom naming)
FR13: Users can record optional hive metadata (acquisition date, queen age)
FR14: Users can edit hive details
FR15: Users can delete a hive (with confirmation)
FR16: Users can view all hives at a location
FR17: Users can view hive history (past inspections)
FR18: Users can start a new inspection for a hive
FR19: Users can record queenright status
FR20: Users can record brood assessment
FR21: Users can record bee population assessment
FR22: Users can record reserve levels (honey/pollen)
FR23: Users can record varroa observations
FR24: Users can record illness observations
FR25: Users can record bee behavior notes
FR26: Users can add free-text notes to an inspection
FR27: Users can attach photos to an inspection
FR28: Users can complete an inspection without filling all fields
FR29: Users can view past inspections for a hive
FR30: Users can create tasks manually
FR31: Users can assign tasks to specific hives
FR32: Users can set due dates for tasks
FR33: Users can add equipment/supplies to tasks
FR34: Tasks can be auto-generated from inspection observations
FR35: Users can mark tasks as complete
FR36: Users can edit task details
FR37: Users can delete tasks
FR38: Users can view tasks filtered by location
FR39: Users can see a dashboard showing hives needing attention
FR40: Users can see prioritized tasks across all locations
FR41: Users can see visual status indicators per hive
FR42: Users can see visual status indicators per location (on map)
FR43: Users can filter view by location
FR44: Users can perform all core functions without network connectivity
FR45: App automatically syncs data when connectivity is restored
FR46: Photos queue locally and upload when connected
FR47: Users can see sync status
FR48: Users can receive push notifications for scheduled tasks
FR49: Users can enable/disable notification categories
FR50: Users can receive sync error notifications (optional)

### NonFunctional Requirements

NFR1: Inspection logging screen loads within 500ms
NFR2: Inspection can be completed (all taps to save) within 30 seconds
NFR3: App launches to usable state within 2 seconds
NFR4: Dashboard renders with 50+ hives in under 1 second
NFR5: Map view loads and displays all locations within 2 seconds
NFR6: All user actions provide visual feedback within 100ms
NFR7: User authentication via AWS Cognito (or equivalent)
NFR8: All data encrypted in transit (HTTPS/TLS)
NFR9: Local data encrypted at rest on device
NFR10: Users can only access their own data
NFR11: Session tokens expire and require re-authentication appropriately
NFR12: App functions fully without network connectivity
NFR13: No user data lost during offline operation
NFR14: Sync conflict rate below 1% under normal usage
NFR15: Photo uploads resume automatically after interruption
NFR16: App gracefully handles sync failures with clear user feedback
NFR17: Data persists across app updates and device restarts

### Additional Requirements

**From Architecture:**
- Starter: Custom Melos Monorepo with DDD architecture (Epic 1, Story 1 foundation)
- Monorepo: Melos 7 with pub workspaces (Dart SDK ^3.9.0)
- Architecture: Clean Architecture with DDD tactical patterns
- State: flutter_bloc for UI state management
- Database: Drift (SQLite) with sqlcipher encryption at rest
- GraphQL: AWS AppSync backend with ferry client (type-safe codegen)
- Auth: AWS Cognito direct SDK (amazon_cognito_identity_dart_2)
- Token Storage: flutter_secure_storage (native Keychain/Keystore)
- DI: GetIt + Injectable for dependency injection
- Navigation: GoRouter for declarative routing
- Background: WorkManager (Android) / BGTaskScheduler (iOS) for photo uploads
- Sync: Last-write-wins with timestamps, background sync on connectivity
- Module Communication: Event bus for cross-module messaging (no direct feature imports)
- CI/CD: GitHub Actions (PR checks) + Codemagic (builds/releases)
- Environments: dev, staging, production flavors
- Infrastructure: AWS serverless (AppSync, Cognito, DynamoDB, S3, Lambda) with Pulumi IaC

**From UX Design:**
- Widget Library: Full custom widget library in core_ui package, documented with Widgetbook
- Core Experience: 30-second inspection logging (tap-to-log pattern)
- Design System: Material Design 3 with custom theming
- Touch Targets: 48px minimum for glove-friendly field use
- Status Colors: Green (healthy), Yellow (attention), Red (urgent) with icons
- Dashboard: Task hero section at top, hive cards below
- Navigation: Bottom navigation (Home, Locations, Tasks, Settings)
- Feedback: Haptic + visual confirmation on every tap
- Progressive Disclosure: Essential options visible, details expandable
- Auto-save: Each tap immediately saves (no submit button)
- Field Conditions: Large taps, high contrast, one-handed operation
- Typography: Larger base sizes (16px+) for outdoor readability
- Spacing: 8px grid, generous padding for touch accuracy

### FR Coverage Map

| FR | Epic | Description |
|----|------|-------------|
| FR1 | Epic 2 | Create account using AWS authentication |
| FR2 | Epic 2 | Sign in to access data |
| FR3 | Epic 2 | Sign out from app |
| FR4 | Epic 2 | Recover access (forgot credentials) |
| FR5 | Epic 3 | Create locations with name |
| FR6 | Epic 3 | Set map pin for location |
| FR7 | Epic 3 | View all locations on map |
| FR8 | Epic 3 | Edit location details |
| FR9 | Epic 3 | Delete location (with confirmation) |
| FR10 | Epic 3 | View list of all locations |
| FR11 | Epic 4 | Add hives to location |
| FR12 | Epic 4 | Name hives (custom naming) |
| FR13 | Epic 4 | Record optional hive metadata |
| FR14 | Epic 4 | Edit hive details |
| FR15 | Epic 4 | Delete hive (with confirmation) |
| FR16 | Epic 4 | View all hives at location |
| FR17 | Epic 4 | View hive history (past inspections) |
| FR18 | Epic 5 | Start new inspection for hive |
| FR19 | Epic 5 | Record queenright status |
| FR20 | Epic 5 | Record brood assessment |
| FR21 | Epic 5 | Record bee population assessment |
| FR22 | Epic 5 | Record reserve levels |
| FR23 | Epic 5 | Record varroa observations |
| FR24 | Epic 5 | Record illness observations |
| FR25 | Epic 5 | Record bee behavior notes |
| FR26 | Epic 5 | Add free-text notes |
| FR27 | Epic 5 | Attach photos to inspection |
| FR28 | Epic 5 | Complete inspection without all fields |
| FR29 | Epic 5 | View past inspections for hive |
| FR30 | Epic 6 | Create tasks manually |
| FR31 | Epic 6 | Assign tasks to specific hives |
| FR32 | Epic 6 | Set due dates for tasks |
| FR33 | Epic 6 | Add equipment/supplies to tasks |
| FR34 | Epic 6 | Auto-generate tasks from observations |
| FR35 | Epic 6 | Mark tasks as complete |
| FR36 | Epic 6 | Edit task details |
| FR37 | Epic 6 | Delete tasks |
| FR38 | Epic 6 | View tasks filtered by location |
| FR39 | Epic 7 | Dashboard showing hives needing attention |
| FR40 | Epic 7 | Prioritized tasks across all locations |
| FR41 | Epic 7 | Visual status indicators per hive |
| FR42 | Epic 7 | Visual status indicators per location |
| FR43 | Epic 7 | Filter view by location |
| FR44 | Epic 5 | All core functions work offline |
| FR45 | Epic 5 | Auto-sync when connectivity restored |
| FR46 | Epic 5 | Photos queue locally, upload when connected |
| FR47 | Epic 7 | See sync status |
| FR48 | Epic 8 | Push notifications for scheduled tasks |
| FR49 | Epic 8 | Enable/disable notification categories |
| FR50 | Epic 8 | Sync error notifications (optional) |

## Epic List

### Epic 1: Project Foundation & Design System
App shell exists with polished design system ready for features. Establishes Melos monorepo, core packages (core_domain, core_data, core_ui, core_infrastructure), custom widget library documented in Widgetbook, Drift database with encryption, event bus, and dependency injection.
**FRs covered:** Foundation for all FRs
**NFRs addressed:** NFR3, NFR6, NFR9, NFR17

### Epic 2: User Authentication
Users can create accounts and securely access their data. Implements AWS Cognito integration with sign up, sign in, sign out, and password recovery flows.
**FRs covered:** FR1, FR2, FR3, FR4
**NFRs addressed:** NFR7, NFR8, NFR10, NFR11

### Epic 3: Location Management
Users can organize their apiaries by location with map visualization. Full CRUD for locations with map pins and list/map views.
**FRs covered:** FR5, FR6, FR7, FR8, FR9, FR10
**NFRs addressed:** NFR5, NFR12, NFR13

### Epic 4: Hive Management
Users can manage all their hives, track metadata, and view inspection history. Full CRUD for hives with flexible metadata fields.
**FRs covered:** FR11, FR12, FR13, FR14, FR15, FR16, FR17
**NFRs addressed:** NFR12, NFR13, NFR17

### Epic 5: Inspection Logging (Core Experience)
Users can log inspections in 30 seconds, even offline. The defining experience with tap-to-log pattern, photo capture with background upload, and full offline support.
**FRs covered:** FR18, FR19, FR20, FR21, FR22, FR23, FR24, FR25, FR26, FR27, FR28, FR29, FR44, FR45, FR46
**NFRs addressed:** NFR1, NFR2, NFR6, NFR12, NFR13, NFR14, NFR15

### Epic 6: Task Management
Users know what needs attention and can plan their work. Manual task creation plus auto-generation from inspection observations.
**FRs covered:** FR30, FR31, FR32, FR33, FR34, FR35, FR36, FR37, FR38
**NFRs addressed:** NFR12, NFR13

### Epic 7: Dashboard & Overview
Users see their entire operation at a glance. Task hero section, hive status cards, visual indicators, and sync status visibility.
**FRs covered:** FR39, FR40, FR41, FR42, FR43, FR47
**NFRs addressed:** NFR4, NFR16

### Epic 8: Notifications
Users get timely reminders for scheduled tasks. Push notification service with user-configurable preferences.
**FRs covered:** FR48, FR49, FR50
**NFRs addressed:** None specific

---

## Epic 1: Project Foundation & Design System

App shell exists with polished design system ready for features. Establishes Melos monorepo, core packages (core_domain, core_data, core_ui, core_infrastructure), custom widget library documented in Widgetbook, Drift database with encryption, event bus, and dependency injection.

### Story 1.1: Initialize Melos Monorepo

As a developer,
I want a properly structured Melos monorepo with all packages defined,
So that I have a solid foundation for building modular features.

**Acceptance Criteria:**

**Given** a fresh project directory
**When** the monorepo is initialized
**Then** the root pubspec.yaml contains workspace configuration for all packages
**And** Melos 7 is configured with pub workspaces (Dart SDK ^3.9.0)
**And** the following package directories exist: core/core_domain, core/core_data, core/core_ui, core/core_infrastructure, features/authentication, features/locations, features/hives, features/inspections, features/tasks, features/dashboard, app
**And** each package has a valid pubspec.yaml with `resolution: workspace`
**And** `melos bootstrap` runs successfully
**And** `melos run analyze` passes with no errors
**And** shared analysis_options.yaml enforces project lint rules

### Story 1.2: Core Domain Package

As a developer,
I want DDD base classes in core_domain,
So that all feature modules use consistent domain modeling patterns.

**Acceptance Criteria:**

**Given** the core_domain package exists
**When** the base classes are implemented
**Then** AggregateRoot base class exists with ID type parameter and domain event collection
**And** Entity base class exists with ID and equality based on ID
**And** ValueObject base class exists with value-based equality
**And** DomainEvent base class exists with occurredAt timestamp
**And** DomainException abstract class exists with message property
**And** all classes are exported via core_domain.dart barrel file
**And** unit tests verify equality and event handling behavior
**And** the package has zero external dependencies (pure Dart)

### Story 1.3: Core Infrastructure Package

As a developer,
I want event bus, DI, and navigation infrastructure,
So that modules can communicate without direct dependencies.

**Acceptance Criteria:**

**Given** the core_infrastructure package exists
**When** infrastructure services are implemented
**Then** EventBus service exists for publishing and subscribing to domain events
**And** GetIt service locator is configured with Injectable code generation
**And** injection.dart setup file exists for app-level DI wiring
**And** NavigationService wraps GoRouter for type-safe navigation
**And** all services are registered as singletons
**And** event subscriptions can be disposed to prevent memory leaks
**And** unit tests verify event publishing and subscription
**And** barrel file exports all public APIs

### Story 1.4: Core Data Package - Database Foundation

As a developer,
I want an encrypted local database with sync infrastructure,
So that the app can store data securely and work offline.

**Acceptance Criteria:**

**Given** the core_data package exists
**When** the database foundation is implemented
**Then** Drift database is configured with sqlcipher_flutter_libs for AES-256 encryption
**And** AppDatabase class exists as the central database instance
**And** database encryption key is stored securely using flutter_secure_storage
**And** BaseRepository abstract class defines standard CRUD + sync patterns
**And** SyncQueue table exists for tracking pending mutations
**And** ConnectivityService monitors network state changes
**And** database schema version is tracked for migrations
**And** unit tests verify encryption is active (NFR9)
**And** data persists across app restarts (NFR17)

### Story 1.5: Core UI Package - Design Tokens

As a developer,
I want design tokens matching the UX specification,
So that the app has a consistent visual language.

**Acceptance Criteria:**

**Given** the core_ui package exists
**When** design tokens are implemented
**Then** AppColors class defines brand palette (Amber #F59E0B primary, Warm White #FFFBEB background)
**And** AppColors defines status colors (Green #16A34A, Yellow #F59E0B, Red #DC2626)
**And** AppTypography defines text styles with 16px base size for field readability
**And** AppSpacing defines 8px grid system with standard spacing values (4, 8, 12, 16, 24, 32)
**And** AppTheme configures Material 3 with useMaterial3: true
**And** ThemeData includes custom ColorScheme, TextTheme, and component themes
**And** all touch targets default to 48px minimum height (glove-friendly)
**And** tokens are documented with usage examples

### Story 1.6: Core UI Package - Base Widgets

As a developer,
I want foundational UI components,
So that feature screens have consistent, reusable building blocks.

**Acceptance Criteria:**

**Given** design tokens exist in core_ui
**When** base widgets are implemented
**Then** HivesButton exists with primary, secondary, and text variants
**And** HivesTextField exists with label, hint, error state, and 48px touch target
**And** HivesCard exists with elevation, padding, and rounded corners (12px radius)
**And** HivesListTile exists for consistent list item layout
**And** HivesBottomSheet exists for modal content
**And** all widgets use design tokens (no hardcoded values)
**And** all widgets support dark mode theming
**And** widget tests verify rendering and interaction states

### Story 1.7: Core UI Package - Status & Feedback Widgets

As a developer,
I want status indicators and feedback widgets,
So that users get clear visual feedback on app state.

**Acceptance Criteria:**

**Given** base widgets exist in core_ui
**When** status and feedback widgets are implemented
**Then** StatusBadge exists with healthy/attention/urgent/unknown variants using status colors
**And** StatusBadge includes both color and icon for accessibility (not color-only)
**And** HivesLoadingIndicator exists with branded styling
**And** SyncStatusIndicator shows offline/syncing/synced/error states
**And** HapticFeedback utility provides light/medium/heavy feedback on supported devices
**And** SnackBarService shows success/error/info messages with consistent styling
**And** all feedback responds within 100ms (NFR6)
**And** widget tests verify all status variants render correctly

### Story 1.8: Widgetbook Documentation

As a developer,
I want all core_ui components documented in Widgetbook,
So that the design system is browsable and testable.

**Acceptance Criteria:**

**Given** all core_ui widgets are implemented
**When** Widgetbook is configured
**Then** Widgetbook app exists as a separate entry point
**And** all design tokens are documented (colors, typography, spacing)
**And** all base widgets have use cases showing variants and states
**And** all status widgets have use cases showing all status variants
**And** interactive knobs allow testing different props
**And** Widgetbook builds and runs without errors
**And** component documentation includes usage guidelines

### Story 1.9: App Shell with Navigation

As a user,
I want to launch the app and see a working navigation structure,
So that I can navigate between main sections.

**Acceptance Criteria:**

**Given** all core packages are implemented
**When** the app shell is created
**Then** main.dart entry points exist for dev, staging, and production flavors
**And** App widget initializes DI, theme, and router
**And** GoRouter is configured with bottom navigation routes (Home, Locations, Tasks, Settings)
**And** BottomNavigationBar uses core_ui styling with 4 tabs
**And** placeholder screens exist for each main section
**And** app launches to usable state within 2 seconds (NFR3)
**And** navigation transitions are smooth (< 300ms)
**And** deep linking is configured for future use
**And** app runs on both iOS and Android simulators

---

## Epic 2: User Authentication

Users can create accounts and securely access their data. Implements AWS Cognito integration with sign up, sign in, sign out, and password recovery flows.

### Story 2.1: Authentication Domain Model

As a developer,
I want domain models for authentication,
So that auth logic follows DDD patterns consistent with other modules.

**Acceptance Criteria:**

**Given** core_domain base classes exist
**When** the authentication domain is implemented
**Then** UserAggregate exists extending AggregateRoot with UserId
**And** UserId value object exists with UUID validation
**And** Email value object exists with format validation (returns Either<AuthException, Email>)
**And** Password value object exists with strength validation (min 8 chars, complexity rules)
**And** AuthRepository interface defines signUp, signIn, signOut, resetPassword, getCurrentUser methods
**And** AuthException hierarchy exists (InvalidCredentials, EmailAlreadyExists, WeakPassword, UserNotFound, NetworkError)
**And** AuthUserLoggedIn and AuthUserLoggedOut domain events exist
**And** all classes exported via authentication.dart barrel file
**And** unit tests verify value object validation logic

### Story 2.2: Cognito Data Source

As a developer,
I want AWS Cognito integration,
So that users can authenticate with a secure, managed service.

**Acceptance Criteria:**

**Given** authentication domain model exists
**When** Cognito data source is implemented
**Then** CognitoDataSource class wraps amazon_cognito_identity_dart_2 SDK
**And** signUp method creates user with email and password
**And** confirmSignUp method handles email verification code
**And** signIn method authenticates and returns tokens (access, id, refresh)
**And** signOut method clears session
**And** forgotPassword method initiates reset flow
**And** confirmForgotPassword method completes reset with code and new password
**And** getCurrentUser method returns authenticated user or null
**And** Cognito pool configuration loaded from environment (flavor-specific)
**And** all network calls use HTTPS (NFR8)

### Story 2.3: Auth Repository Implementation

As a developer,
I want the auth repository to connect domain to infrastructure,
So that auth operations are properly abstracted.

**Acceptance Criteria:**

**Given** Cognito data source exists
**When** AuthRepositoryImpl is implemented
**Then** repository implements AuthRepository interface
**And** tokens are stored securely using flutter_secure_storage (NFR7)
**And** signIn stores tokens and publishes AuthUserLoggedIn event
**And** signOut clears tokens and publishes AuthUserLoggedOut event
**And** getCurrentUser checks token validity and refreshes if needed
**And** all methods return Either<AuthException, T> for error handling
**And** repository is registered with GetIt as singleton
**And** integration tests verify token storage and retrieval

### Story 2.4: Auth BLoC & State Management

As a developer,
I want auth state management via BLoC,
So that UI can react to authentication state changes.

**Acceptance Criteria:**

**Given** AuthRepository exists
**When** AuthBloc is implemented
**Then** AuthEvent sealed class includes: CheckAuthStatus, SignUp, SignIn, SignOut, ResetPassword
**And** AuthState sealed class includes: AuthInitial, AuthLoading, Authenticated(user), Unauthenticated, AuthError(exception)
**And** bloc checks auth status on initialization
**And** bloc emits Authenticated state with user data on successful sign in
**And** bloc emits Unauthenticated state on sign out or token expiry
**And** bloc emits AuthError with specific exception for failures
**And** bloc is provided at app root level
**And** unit tests verify all state transitions

### Story 2.5: Sign Up Screen

As a new user,
I want to create an account with my email and password,
So that I can start using the app to manage my hives.

**Acceptance Criteria:**

**Given** I am on the sign up screen
**When** I enter a valid email and password
**Then** the sign up button is enabled
**And** tapping sign up shows loading indicator
**And** successful sign up navigates to email verification screen
**And** email verification screen accepts 6-digit code
**And** successful verification navigates to main app

**Given** I enter an invalid email format
**When** I tap the email field away
**Then** validation error "Please enter a valid email" appears

**Given** I enter a weak password
**When** I tap the password field away
**Then** validation error shows password requirements

**Given** the email is already registered
**When** sign up is attempted
**Then** error message "Email already in use" is displayed

**And** all form fields have 48px touch targets
**And** screen uses core_ui components (HivesTextField, HivesButton)

### Story 2.6: Sign In Screen

As a returning user,
I want to sign in with my credentials,
So that I can access my hive data.

**Acceptance Criteria:**

**Given** I am on the sign in screen
**When** I enter valid email and password and tap sign in
**Then** loading indicator appears
**And** successful sign in navigates to dashboard
**And** user session is persisted (NFR11)

**Given** I enter incorrect credentials
**When** sign in is attempted
**Then** error message "Invalid email or password" is displayed
**And** password field is cleared for retry

**Given** I tap "Forgot Password?"
**When** the link is tapped
**Then** I navigate to password recovery screen

**Given** I am already signed in
**When** I launch the app
**Then** I am taken directly to dashboard (skip sign in)

**And** sign in form has "Remember me" option (optional)
**And** screen follows UX design with warm amber accent

### Story 2.7: Password Recovery Flow

As a user who forgot my password,
I want to reset it via email,
So that I can regain access to my account.

**Acceptance Criteria:**

**Given** I am on the forgot password screen
**When** I enter my registered email and tap "Send Reset Code"
**Then** confirmation message appears
**And** I am navigated to code entry screen

**Given** I received the reset code
**When** I enter the code and new password
**Then** password is updated successfully
**And** success message confirms reset
**And** I am navigated to sign in screen

**Given** I enter an invalid or expired code
**When** I submit the reset form
**Then** error message "Invalid or expired code" appears
**And** option to resend code is available

**Given** the email is not registered
**When** I request password reset
**Then** generic message appears (no indication if email exists for security)

### Story 2.8: Auth Guard & Session Management

As a user,
I want my session managed automatically,
So that I stay signed in but am protected from unauthorized access.

**Acceptance Criteria:**

**Given** I am not authenticated
**When** I try to access a protected route
**Then** I am redirected to sign in screen
**And** after sign in, I am returned to the originally requested route

**Given** my session token is expired
**When** I make an authenticated request
**Then** token refresh is attempted automatically
**And** if refresh succeeds, request continues transparently
**And** if refresh fails, I am signed out and redirected to sign in

**Given** I tap sign out
**When** sign out completes
**Then** all tokens are cleared from secure storage
**And** local user data remains (offline access)
**And** I am redirected to sign in screen

**And** GoRouter redirect guards protect all authenticated routes
**And** AuthBloc state changes trigger appropriate navigation
**And** session tokens expire appropriately (NFR11)

---

## Epic 3: Location Management

Users can organize their apiaries by location with map visualization. Full CRUD for locations with map pins and list/map views.

### Story 3.1: Location Domain Model

As a developer,
I want domain models for locations,
So that apiary location management follows DDD patterns.

**Acceptance Criteria:**

**Given** core_domain base classes exist
**When** the locations domain is implemented
**Then** LocationAggregate exists extending AggregateRoot with LocationId
**And** LocationId value object exists with UUID generation and validation
**And** LocationName value object exists with non-empty validation (1-100 chars)
**And** Coordinates value object exists with latitude (-90 to 90) and longitude (-180 to 180) validation
**And** LocationRepository interface defines create, update, delete, getById, getAll methods
**And** LocationException hierarchy exists (LocationNotFound, InvalidCoordinates, DuplicateName)
**And** LocationCreated, LocationUpdated, LocationDeleted domain events exist
**And** all classes exported via locations.dart barrel file
**And** unit tests verify value object validation and aggregate behavior

### Story 3.2: Location Local Data Source

As a developer,
I want local storage for locations,
So that location data persists offline.

**Acceptance Criteria:**

**Given** core_data database foundation exists
**When** location local data source is implemented
**Then** locations Drift table exists with columns: id, name, latitude, longitude, notes, created_at, updated_at, sync_status
**And** LocationLocalDataSource class provides CRUD operations
**And** getAll returns locations sorted by name
**And** insert/update operations set updated_at timestamp
**And** sync_status tracks: synced, pending_create, pending_update, pending_delete
**And** LocationDto maps between Drift row and domain model
**And** data persists across app restarts (NFR17)
**And** unit tests verify all CRUD operations

### Story 3.3: Location Repository Implementation

As a developer,
I want the location repository with offline-first pattern,
So that locations work without connectivity.

**Acceptance Criteria:**

**Given** location local data source exists
**When** LocationRepositoryImpl is implemented
**Then** repository implements LocationRepository interface
**And** create operation saves locally first, queues sync
**And** update operation saves locally first, queues sync
**And** delete operation marks for deletion locally, queues sync
**And** getAll returns local data immediately (offline-first)
**And** all methods return Either<LocationException, T>
**And** domain events are published on successful operations
**And** repository is registered with GetIt
**And** no data is lost during offline operation (NFR13)

### Story 3.4: Location BLoC & State Management

As a developer,
I want location state management via BLoC,
So that UI can react to location changes.

**Acceptance Criteria:**

**Given** LocationRepository exists
**When** LocationBloc is implemented
**Then** LocationEvent sealed class includes: LoadLocations, CreateLocation, UpdateLocation, DeleteLocation, SelectLocation
**And** LocationState sealed class includes: LocationInitial, LocationLoading, LocationLoaded(locations, selected?), LocationError(exception)
**And** bloc loads locations on initialization
**And** bloc emits updated state after CRUD operations
**And** bloc handles optimistic updates for responsiveness
**And** bloc listens for sync events to refresh state
**And** unit tests verify all state transitions

### Story 3.5: Location List Screen

As a beekeeper,
I want to see all my apiary locations,
So that I can manage and navigate to each one.

**Acceptance Criteria:**

**Given** I have locations saved
**When** I navigate to the Locations tab
**Then** I see a list of location cards with name and hive count
**And** each card shows status indicator (aggregate of hive statuses)
**And** tapping a card navigates to location detail
**And** list loads within 2 seconds (NFR5)

**Given** I have no locations yet
**When** I navigate to the Locations tab
**Then** I see an empty state with illustration
**And** "Add your first apiary" button is prominent
**And** tapping the button opens create location form

**And** pull-to-refresh reloads location list
**And** FAB button allows adding new location
**And** screen uses core_ui components

### Story 3.6: Create/Edit Location Form

As a beekeeper,
I want to add or edit apiary locations,
So that I can organize my hives by physical location.

**Acceptance Criteria:**

**Given** I am on the create location form
**When** I enter a location name and tap save
**Then** the location is created successfully
**And** I am navigated back to location list
**And** success snackbar confirms creation

**Given** I am editing an existing location
**When** I modify the name and tap save
**Then** the location is updated successfully
**And** changes are reflected immediately

**Given** I enter an empty name
**When** I tap save
**Then** validation error "Location name is required" appears

**Given** I am offline
**When** I create or edit a location
**Then** the operation succeeds locally
**And** sync indicator shows pending status (NFR12)

**And** form has optional notes field for additional details
**And** "Set Map Pin" button navigates to map pin selection
**And** all fields have 48px touch targets

### Story 3.7: Location Map Pin Selection

As a beekeeper,
I want to set a map pin for my apiary,
So that I can see it on a map and get directions.

**Acceptance Criteria:**

**Given** I am on the map pin selection screen
**When** I tap a location on the map
**Then** a pin marker appears at that position
**And** coordinates are displayed

**Given** I want to use my current location
**When** I tap the "Current Location" button
**Then** the map centers on my GPS position
**And** pin is placed at current location
**And** location permission is requested if not granted

**Given** I have placed a pin
**When** I tap "Confirm Location"
**Then** coordinates are saved to the location
**And** I return to the location form

**Given** location permission is denied
**When** I try to use current location
**Then** helpful message explains how to enable permission
**And** manual pin placement still works

**And** map supports pinch-to-zoom and pan gestures
**And** existing pin location is shown when editing

### Story 3.8: Location Map Overview

As a beekeeper with multiple apiaries,
I want to see all locations on a map,
So that I can visualize my operation and plan routes.

**Acceptance Criteria:**

**Given** I have multiple locations with coordinates
**When** I view the location map overview
**Then** all locations appear as pins on the map
**And** map auto-fits to show all pins
**And** each pin shows location name on tap
**And** map loads within 2 seconds (NFR5)

**Given** a location has hives needing attention
**When** I view the map
**Then** that location's pin shows attention status color (yellow/red)
**And** status icon accompanies the color (FR42)

**Given** I tap a location pin
**When** the info window appears
**Then** I see location name and hive count
**And** "View Details" button navigates to location detail

**Given** a location has no coordinates set
**When** I view the map
**Then** that location does not appear on map
**And** list view still shows all locations

### Story 3.9: Delete Location with Confirmation

As a beekeeper,
I want to delete a location I no longer use,
So that my location list stays organized.

**Acceptance Criteria:**

**Given** I am viewing a location's details
**When** I tap the delete option
**Then** a confirmation dialog appears
**And** dialog warns about associated hives

**Given** the location has hives
**When** confirmation dialog shows
**Then** message states "This location has X hives. Delete location and all hives?"
**And** destructive action button is clearly styled (red)

**Given** I confirm deletion
**When** delete completes
**Then** location and associated hives are removed
**And** I am navigated back to location list
**And** success message confirms deletion

**Given** I cancel deletion
**When** I tap "Cancel"
**Then** dialog closes
**And** no changes are made

**Given** I am offline
**When** I delete a location
**Then** deletion is queued for sync
**And** location is hidden from UI immediately (NFR12)

---

## Epic 4: Hive Management

Users can manage all their hives, track metadata, and view inspection history. Full CRUD for hives with flexible metadata fields.

### Story 4.1: Hive Domain Model

As a developer,
I want domain models for hives,
So that hive management follows DDD patterns.

**Acceptance Criteria:**

**Given** core_domain base classes exist
**When** the hives domain is implemented
**Then** HiveAggregate exists extending AggregateRoot with HiveId
**And** HiveId value object exists with UUID generation
**And** HiveName value object exists with validation (1-50 chars)
**And** HiveStatus enum exists with values: healthy, attention, urgent, unknown
**And** Queen entity exists with age (optional date), marked status, origin
**And** HiveAggregate contains optional Queen, acquisition date, notes
**And** HiveRepository interface defines CRUD + getByLocation methods
**And** HiveException hierarchy exists (HiveNotFound, InvalidHiveName, LocationRequired)
**And** HiveCreated, HiveUpdated, HiveDeleted domain events include locationId
**And** unit tests verify aggregate behavior and status calculations

### Story 4.2: Hive Local Data Source

As a developer,
I want local storage for hives,
So that hive data persists offline.

**Acceptance Criteria:**

**Given** core_data database and locations table exist
**When** hive local data source is implemented
**Then** hives Drift table exists with columns: id, location_id (FK), name, status, acquisition_date, queen_age, queen_marked, queen_origin, notes, created_at, updated_at, sync_status
**And** foreign key constraint references locations table
**And** HiveLocalDataSource class provides CRUD operations
**And** getByLocation returns hives filtered by location_id
**And** getAll returns all hives sorted by location then name
**And** HiveDto maps between Drift row and domain model
**And** cascade delete removes hives when location is deleted
**And** data persists across app restarts (NFR17)

### Story 4.3: Hive Repository Implementation

As a developer,
I want the hive repository with offline-first pattern,
So that hive management works without connectivity.

**Acceptance Criteria:**

**Given** hive local data source exists
**When** HiveRepositoryImpl is implemented
**Then** repository implements HiveRepository interface
**And** create requires valid locationId reference
**And** operations save locally first, queue sync
**And** getByLocation returns local data immediately
**And** status updates trigger HiveUpdated events
**And** all methods return Either<HiveException, T>
**And** repository subscribes to LocationDeleted to cascade
**And** no data is lost during offline operation (NFR13)

### Story 4.4: Hive BLoC & State Management

As a developer,
I want hive state management via BLoC,
So that UI can react to hive changes.

**Acceptance Criteria:**

**Given** HiveRepository exists
**When** HiveBloc is implemented
**Then** HiveEvent sealed class includes: LoadHives, LoadHivesByLocation, CreateHive, UpdateHive, DeleteHive, SelectHive
**And** HiveState sealed class includes: HiveInitial, HiveLoading, HiveLoaded(hives, selected?), HiveError(exception)
**And** bloc supports filtering by location
**And** bloc emits updated state after CRUD operations
**And** bloc listens for location deletion events
**And** bloc listens for inspection events to update hive status
**And** unit tests verify all state transitions and filtering

### Story 4.5: Hive List Screen

As a beekeeper,
I want to see all hives at a location,
So that I can manage each hive.

**Acceptance Criteria:**

**Given** I am viewing a location's details
**When** the hive list loads
**Then** I see cards for each hive at this location (FR16)
**And** each card shows hive name, status badge, last inspection date
**And** cards are sorted by status (urgent first) then name
**And** tapping a card navigates to hive detail

**Given** this location has no hives
**When** the hive list loads
**Then** I see an empty state with "Add your first hive" prompt
**And** illustration matches beekeeping theme

**Given** I tap the FAB or "Add Hive" button
**When** the action triggers
**Then** I navigate to create hive form with location pre-selected

**And** pull-to-refresh reloads hive list
**And** hive count shows in location header
**And** status colors match UX spec (green/yellow/red)

### Story 4.6: Create/Edit Hive Form

As a beekeeper,
I want to add or edit hives with relevant details,
So that I can track each colony properly.

**Acceptance Criteria:**

**Given** I am on the create hive form
**When** I enter a hive name and tap save
**Then** the hive is created at the selected location (FR11)
**And** I am navigated to hive detail or back to list
**And** success snackbar confirms creation

**Given** I am creating a hive
**When** I view the form
**Then** name field is required (FR12)
**And** acquisition date is optional with date picker (FR13)
**And** queen section is collapsible (progressive disclosure)
**And** queen fields include: age/date, marked (yes/no), origin (optional text)
**And** notes field allows free text

**Given** I am editing an existing hive
**When** I modify fields and tap save
**Then** the hive is updated successfully (FR14)
**And** changes are reflected immediately

**Given** I am offline
**When** I create or edit a hive
**Then** operation succeeds locally with sync pending indicator

### Story 4.7: Hive Detail Screen

As a beekeeper,
I want to view hive details and take quick actions,
So that I can manage individual colonies efficiently.

**Acceptance Criteria:**

**Given** I tap on a hive card
**When** the detail screen loads
**Then** I see hive name, status badge, and location name
**And** I see metadata section (acquisition date, queen info if set)
**And** I see latest inspection summary (date, key observations)
**And** "Log Inspection" button is prominent (prepares for Epic 5)

**Given** I am on hive detail
**When** I view available actions
**Then** I can tap "Edit" to modify hive details
**And** I can tap "View History" to see past inspections (FR17)
**And** I can tap "Delete" to remove the hive
**And** actions are accessible via app bar or action menu

**Given** the hive has never been inspected
**When** I view the detail
**Then** inspection summary shows "No inspections yet"
**And** "Log First Inspection" is emphasized

### Story 4.8: Hive History View

As a beekeeper,
I want to see inspection history for a hive,
So that I can track colony progress over time.

**Acceptance Criteria:**

**Given** I tap "View History" on hive detail
**When** the history screen loads
**Then** I see a timeline of past inspections (FR17)
**And** each entry shows date, key observations, status at time
**And** entries are sorted newest first
**And** tapping an entry shows full inspection details

**Given** the hive has no inspection history
**When** the history screen loads
**Then** I see empty state "No inspections recorded"
**And** "Log First Inspection" button is available

**Given** the hive has many inspections
**When** I scroll the history
**Then** list loads efficiently with pagination/lazy loading
**And** scrolling is smooth

**And** history view works offline with local data
**And** this screen prepares the UI pattern for Epic 5 inspection data

### Story 4.9: Delete Hive with Confirmation

As a beekeeper,
I want to delete a hive I no longer manage,
So that my hive list stays accurate.

**Acceptance Criteria:**

**Given** I am on hive detail or hive list
**When** I tap delete on a hive
**Then** a confirmation dialog appears (FR15)

**Given** the hive has inspection history
**When** confirmation dialog shows
**Then** message states "This will delete the hive and all X inspections"
**And** destructive action is clearly styled

**Given** I confirm deletion
**When** delete completes
**Then** hive and associated inspections are removed
**And** I am navigated back to hive list
**And** success message confirms deletion
**And** location hive count updates

**Given** I am offline
**When** I delete a hive
**Then** deletion queues for sync
**And** hive is hidden from UI immediately

**And** cancel button closes dialog without changes

---

## Epic 5: Inspection Logging (Core Experience)

Users can log inspections in 30 seconds, even offline. The defining experience with tap-to-log pattern, photo capture with background upload, and full offline support.

### Story 5.1: Inspection Domain Model

As a developer,
I want domain models for inspections,
So that the core experience follows DDD patterns.

**Acceptance Criteria:**

**Given** core_domain base classes exist
**When** the inspections domain is implemented
**Then** InspectionAggregate exists extending AggregateRoot with InspectionId
**And** InspectionId value object exists with UUID generation
**And** QueenStatus enum exists: confirmed, unconfirmed, queenless, unknown
**And** BroodAssessment enum exists: excellent, good, fair, poor, none
**And** BeePopulation enum exists: strong, normal, weak, critical
**And** ReserveLevel enum exists: full, adequate, low, empty
**And** VarroaObservation value object exists with count (optional) and treatment status
**And** IllnessObservation value object exists with type and severity
**And** BehaviorNote value object exists for temperament observations
**And** InspectionAggregate contains all observation fields as optional
**And** InspectionRepository interface defines CRUD + getByHive methods
**And** InspectionLogged domain event includes hiveId for cross-module communication
**And** unit tests verify all value objects and aggregate behavior

### Story 5.2: Inspection Local Data Source

As a developer,
I want local storage for inspections and photos,
So that inspection data persists offline.

**Acceptance Criteria:**

**Given** core_data database and hives table exist
**When** inspection local data source is implemented
**Then** inspections Drift table exists with columns: id, hive_id (FK), inspection_date, queen_status, brood_assessment, bee_population, reserve_level, varroa_count, varroa_treatment, illness_type, illness_severity, behavior_notes, free_notes, created_at, updated_at, sync_status
**And** inspection_photos table exists with columns: id, inspection_id (FK), local_path, remote_url, upload_status, created_at
**And** photo upload_status tracks: pending, uploading, completed, failed
**And** InspectionLocalDataSource provides CRUD operations
**And** getByHive returns inspections sorted by date descending
**And** cascade delete removes inspections when hive is deleted
**And** InspectionDto and PhotoDto map to domain models

### Story 5.3: Inspection Repository Implementation

As a developer,
I want the inspection repository with auto-save pattern,
So that every tap saves immediately.

**Acceptance Criteria:**

**Given** inspection local data source exists
**When** InspectionRepositoryImpl is implemented
**Then** repository implements InspectionRepository interface
**And** create initializes inspection with current date and hiveId
**And** updateObservation saves single field immediately (auto-save)
**And** each save updates sync_status to pending
**And** getByHive returns local data immediately (offline-first)
**And** all methods return Either<InspectionException, T>
**And** InspectionLogged event published on completion
**And** repository queues sync for background processing
**And** no data is lost during offline operation (NFR13)

### Story 5.4: Photo Capture & Queue Service

As a developer,
I want photo capture with background upload,
So that photos don't block the inspection flow.

**Acceptance Criteria:**

**Given** camera permission is granted
**When** PhotoService is implemented
**Then** capturePhoto opens camera and returns local file path
**And** pickFromGallery opens photo picker and returns local file path
**And** photos are compressed before storage (max 1MB, 1080p)
**And** photos are saved to app documents directory
**And** PhotoQueueService tracks pending uploads
**And** uploads resume automatically after interruption (NFR15)

**Given** device is offline
**When** a photo is attached
**Then** photo is saved locally with pending status (FR46)
**And** upload queues for when connectivity returns

**Given** device comes online
**When** pending photos exist
**Then** PhotoQueueService uploads in background
**And** upload progress is trackable
**And** failed uploads retry with exponential backoff

### Story 5.5: Inspection BLoC & State Management

As a developer,
I want inspection state management with tap-to-save,
So that UI responds instantly to every observation.

**Acceptance Criteria:**

**Given** InspectionRepository exists
**When** InspectionBloc is implemented
**Then** InspectionEvent includes: StartInspection, UpdateQueenStatus, UpdateBrood, UpdateBees, UpdateReserves, UpdateVarroa, UpdateIllness, UpdateBehavior, UpdateNotes, AttachPhoto, CompleteInspection
**And** InspectionState includes: InspectionInitial, InspectionActive(inspection), InspectionSaving, InspectionComplete, InspectionError
**And** each Update event saves immediately and emits updated state
**And** state updates provide visual feedback within 100ms (NFR6)
**And** bloc handles optimistic updates for responsiveness
**And** bloc tracks dirty state for unsaved changes
**And** unit tests verify tap-to-save behavior

### Story 5.6: Quick Inspection Screen - Core Observations

As a beekeeper,
I want to log key observations with quick taps,
So that I can document inspections in under 30 seconds.

**Acceptance Criteria:**

**Given** I tap "Log Inspection" on a hive
**When** the inspection screen loads
**Then** screen loads within 500ms (NFR1)
**And** date is pre-filled to today
**And** hive name is shown in header

**Given** I am on the inspection screen
**When** I view the core observation section
**Then** I see Queenright status: ✓ Confirmed / ? Unconfirmed / ✗ Queenless (FR19)
**And** I see Brood assessment: Excellent / Good / Fair / Poor (FR20)
**And** I see Bee population: Strong / Normal / Weak (FR21)
**And** I see Reserves level: Full / OK / Low (FR22)
**And** each option is a large tap target (48px+)
**And** options use status colors (green/yellow/red)

**Given** I tap an observation option
**When** the tap registers
**Then** option is visually selected immediately
**And** haptic feedback confirms the tap
**And** data saves automatically (no submit button)
**And** I can change selection by tapping another option

**And** all fields are optional - can complete without filling any (FR28)
**And** entire core flow completable in < 30 seconds (NFR2)

### Story 5.7: Quick Inspection Screen - Extended Observations

As a beekeeper,
I want to record detailed observations when needed,
So that I can track varroa, illness, and behavior.

**Acceptance Criteria:**

**Given** I am on the inspection screen
**When** I view the extended section
**Then** sections are collapsed by default (progressive disclosure)
**And** section headers show: Varroa, Illness, Behavior

**Given** I expand the Varroa section
**When** the section opens
**Then** I can enter optional varroa count (number input) (FR23)
**And** I can mark treatment status (treated/not treated/due)
**And** inputs auto-save on change

**Given** I expand the Illness section
**When** the section opens
**Then** I can select illness type (none, nosema, foulbrood, chalkbrood, other) (FR24)
**And** I can select severity (mild, moderate, severe)
**And** inputs auto-save on change

**Given** I expand the Behavior section
**When** the section opens
**Then** I can select temperament (calm, nervous, aggressive) (FR25)
**And** I can add behavior note text
**And** inputs auto-save on change

**And** expanding sections does not reset other selections
**And** collapsed sections show summary if data entered

### Story 5.8: Inspection Notes & Photos

As a beekeeper,
I want to add notes and photos to inspections,
So that I can capture details that don't fit predefined fields.

**Acceptance Criteria:**

**Given** I am on the inspection screen
**When** I scroll to the notes section
**Then** I see a text field for free-form notes (FR26)
**And** text field expands as I type
**And** notes auto-save after typing pause (debounced 500ms)

**Given** I tap the "Add Photo" button
**When** the action triggers
**Then** I can choose Camera or Gallery (FR27)
**And** photo is captured/selected
**And** thumbnail preview shows in inspection
**And** photo queues for background upload

**Given** I have attached photos
**When** I view the photo section
**Then** I see thumbnails of all attached photos
**And** I can tap to view full size
**And** I can delete a photo with confirmation
**And** upload status indicator shows (pending/uploading/uploaded)

**And** multiple photos can be attached per inspection
**And** photos work offline (stored locally, upload when connected)

### Story 5.9: Inspection Detail View

As a beekeeper,
I want to view a completed inspection,
So that I can review what I observed.

**Acceptance Criteria:**

**Given** I tap an inspection in hive history
**When** the detail view loads
**Then** I see inspection date and hive name
**And** I see all recorded observations with their values
**And** I see attached photos as thumbnails
**And** I see free-form notes if entered
**And** empty fields show "Not recorded" (FR29)

**Given** I want to edit the inspection
**When** I tap "Edit" button
**Then** I am taken to inspection screen with values pre-filled
**And** I can modify any observation
**And** changes auto-save as before

**Given** photos are still uploading
**When** I view the inspection
**Then** upload progress is visible
**And** local thumbnail displays correctly

**And** detail view works fully offline
**And** navigation back returns to hive history

### Story 5.10: Background Sync Service

As a beekeeper,
I want my data to sync automatically,
So that I never lose inspection records.

**Acceptance Criteria:**

**Given** the app is running
**When** ConnectivityService detects network available
**Then** SyncService starts processing pending items (FR45)
**And** sync happens in background without blocking UI

**Given** pending inspections exist
**When** sync processes them
**Then** items are sent to server in order (oldest first)
**And** successful sync updates local sync_status to synced
**And** failed items are retried with exponential backoff

**Given** a sync conflict occurs
**When** server has newer data
**Then** last-write-wins resolution applies (by timestamp)
**And** conflict rate remains below 1% (NFR14)

**Given** sync completes
**When** all pending items are processed
**Then** SyncCompleted event is published
**And** UI can refresh if needed

**And** sync works for locations, hives, inspections, tasks
**And** photos sync via PhotoQueueService separately
**And** app functions fully offline when no connectivity (FR44, NFR12)

---

## Epic 6: Task Management

Users know what needs attention and can plan their work. Manual task creation plus auto-generation from inspection observations.

### Story 6.1: Task Domain Model

As a developer,
I want domain models for tasks,
So that task management follows DDD patterns.

**Acceptance Criteria:**

**Given** core_domain base classes exist
**When** the tasks domain is implemented
**Then** TaskAggregate exists extending AggregateRoot with TaskId
**And** TaskId value object exists with UUID generation
**And** TaskTitle value object exists with validation (1-200 chars)
**And** TaskPriority enum exists: urgent, high, normal, low
**And** TaskStatus enum exists: pending, in_progress, completed, cancelled
**And** TaskAggregate contains: title, description, priority, status, due_date, hive_id (optional), location_id (optional), equipment list, created_at
**And** TaskRepository interface defines CRUD + getByLocation + getByHive + getPending methods
**And** TaskException hierarchy exists (TaskNotFound, InvalidTitle)
**And** TaskCreated, TaskCompleted, TaskDeleted domain events exist
**And** unit tests verify aggregate behavior

### Story 6.2: Task Local Data Source

As a developer,
I want local storage for tasks,
So that task data persists offline.

**Acceptance Criteria:**

**Given** core_data database exists
**When** task local data source is implemented
**Then** tasks Drift table exists with columns: id, title, description, priority, status, due_date, hive_id (nullable FK), location_id (nullable FK), equipment, auto_generated, source_inspection_id, created_at, updated_at, sync_status
**And** equipment stored as JSON array of strings
**And** TaskLocalDataSource provides CRUD operations
**And** getByLocation filters by location_id
**And** getByHive filters by hive_id
**And** getPending returns incomplete tasks sorted by due_date, priority
**And** TaskDto maps between Drift row and domain model

### Story 6.3: Task Repository Implementation

As a developer,
I want the task repository with offline-first pattern,
So that task management works without connectivity.

**Acceptance Criteria:**

**Given** task local data source exists
**When** TaskRepositoryImpl is implemented
**Then** repository implements TaskRepository interface
**And** create saves locally and queues sync
**And** complete updates status and queues sync
**And** getByLocation returns local data immediately
**And** all methods return Either<TaskException, T>
**And** domain events published on state changes
**And** repository handles hive/location deletion (nullify or delete tasks)

### Story 6.4: Task Auto-Generation Service

As a developer,
I want tasks auto-generated from inspections,
So that beekeepers get actionable reminders.

**Acceptance Criteria:**

**Given** InspectionLogged event is published
**When** TaskAutoGenerator processes the event
**Then** inspection observations are analyzed for task triggers

**Given** reserves are marked "Low"
**When** auto-generation runs
**Then** task "Feed hive [hive name]" is created with high priority (FR34)
**And** task links to the hive
**And** task marked as auto_generated = true

**Given** queen status is "Queenless"
**When** auto-generation runs
**Then** task "Check queen status - [hive name]" is created with urgent priority

**Given** varroa treatment is "Due"
**When** auto-generation runs
**Then** task "Apply varroa treatment - [hive name]" is created

**And** duplicate tasks are not created if pending task exists
**And** auto-generated tasks can be edited or deleted by user
**And** service subscribes to InspectionLogged via event bus

### Story 6.5: Task BLoC & State Management

As a developer,
I want task state management via BLoC,
So that UI can react to task changes.

**Acceptance Criteria:**

**Given** TaskRepository exists
**When** TaskBloc is implemented
**Then** TaskEvent includes: LoadTasks, LoadTasksByLocation, CreateTask, UpdateTask, CompleteTask, DeleteTask, FilterTasks
**And** TaskState includes: TaskInitial, TaskLoading, TaskLoaded(tasks, filter), TaskError
**And** bloc supports filtering by location, status, priority
**And** bloc emits updated state after CRUD operations
**And** bloc listens for TaskCreated events (from auto-generation)
**And** unit tests verify all state transitions

### Story 6.6: Task List Screen

As a beekeeper,
I want to see all my tasks,
So that I know what needs to be done.

**Acceptance Criteria:**

**Given** I navigate to the Tasks tab
**When** the task list loads
**Then** I see all pending tasks sorted by due date, then priority
**And** each task card shows: title, priority badge, due date, associated hive/location
**And** overdue tasks are highlighted with urgent styling
**And** auto-generated tasks show subtle indicator

**Given** I have no pending tasks
**When** the task list loads
**Then** I see empty state "All caught up!"
**And** "Create Task" button is available

**Given** I want to filter tasks
**When** I use filter options
**Then** I can filter by location (FR38)
**And** I can filter by status (pending, completed)
**And** I can filter by priority
**And** active filters are visible

**And** pull-to-refresh reloads task list
**And** FAB allows creating new task

### Story 6.7: Create/Edit Task Form

As a beekeeper,
I want to create and edit tasks,
So that I can plan my work.

**Acceptance Criteria:**

**Given** I am on the create task form
**When** I view the form fields
**Then** title field is required (FR30)
**And** description field is optional
**And** priority selector shows: Urgent / High / Normal / Low
**And** due date picker is available (FR32)
**And** hive selector allows linking to specific hive (FR31)
**And** location selector allows linking to location
**And** equipment field allows adding items (FR33)

**Given** I fill required fields and tap save
**When** save completes
**Then** task is created successfully
**And** I return to task list
**And** success message confirms creation

**Given** I am editing an existing task
**When** I modify fields and save
**Then** task is updated (FR36)
**And** changes reflect immediately

**Given** I tap "Add Equipment"
**When** equipment section expands
**Then** I can add multiple items (text input + add button)
**And** I can remove items
**And** common items could be suggested (optional enhancement)

### Story 6.8: Task Detail & Completion

As a beekeeper,
I want to view task details and mark tasks complete,
So that I can track my work.

**Acceptance Criteria:**

**Given** I tap a task card
**When** the detail view loads
**Then** I see full task details (title, description, priority, due date)
**And** I see linked hive/location if set
**And** I see equipment list if set
**And** I see creation date and source (manual or auto-generated)

**Given** I am viewing a pending task
**When** I tap "Mark Complete"
**Then** confirmation appears (optional, could be direct)
**And** task status changes to completed (FR35)
**And** completion date is recorded
**And** I return to task list
**And** success feedback is shown

**Given** I want to edit the task
**When** I tap "Edit"
**Then** I navigate to edit form with values pre-filled

**Given** I want to delete the task
**When** I tap "Delete"
**Then** confirmation dialog appears (FR37)
**And** confirming removes the task

### Story 6.9: Task Quick Actions

As a beekeeper,
I want quick actions on tasks,
So that I can manage tasks efficiently from the list.

**Acceptance Criteria:**

**Given** I am viewing the task list
**When** I swipe a task card right
**Then** "Complete" action is revealed
**And** completing updates task status immediately

**Given** I swipe a task card left
**When** the action is revealed
**Then** "Delete" action is shown
**And** deleting shows confirmation then removes task

**Given** I long-press a task card
**When** context menu appears
**Then** I see options: View, Edit, Complete, Delete
**And** selecting an option performs that action

**And** swipe actions provide haptic feedback
**And** actions work offline with sync queuing

---

## Epic 7: Dashboard & Overview

Users see their entire operation at a glance. Task hero section, hive status cards, visual indicators, and sync status visibility.

### Story 7.1: Dashboard Domain Services

As a developer,
I want aggregation services for dashboard data,
So that dashboard can efficiently display summaries.

**Acceptance Criteria:**

**Given** repositories for locations, hives, tasks, inspections exist
**When** DashboardAggregator service is implemented
**Then** getHivesSummary returns count by status (healthy, attention, urgent)
**And** getTasksSummary returns pending tasks count by priority
**And** getLocationsSummary returns locations with aggregate status
**And** getHivesNeedingAttention returns hives sorted by urgency
**And** getPriorityTasks returns top N most urgent tasks
**And** service queries local data (offline-first)
**And** service caches results with TTL for performance

### Story 7.2: Dashboard BLoC & State Management

As a developer,
I want dashboard state management,
So that the home screen updates reactively.

**Acceptance Criteria:**

**Given** DashboardAggregator exists
**When** DashboardBloc is implemented
**Then** DashboardEvent includes: LoadDashboard, RefreshDashboard, FilterByLocation
**And** DashboardState includes: DashboardInitial, DashboardLoading, DashboardLoaded(summary), DashboardError
**And** bloc loads dashboard data on initialization
**And** bloc refreshes when SyncCompleted event received
**And** bloc refreshes when InspectionLogged event received
**And** bloc refreshes when TaskCompleted event received
**And** dashboard renders with 50+ hives in under 1 second (NFR4)

### Story 7.3: Dashboard Task Hero Section

As a beekeeper,
I want to see today's priorities immediately,
So that I know what to do when I open the app.

**Acceptance Criteria:**

**Given** I open the app and land on dashboard
**When** the dashboard loads
**Then** I see task hero section at top (FR40)
**And** hero shows: "Today: X tasks" with count
**And** hero shows: "X hives need attention" with count (FR39)
**And** priority task cards show below hero

**Given** I have urgent tasks
**When** viewing priority task cards
**Then** up to 3 most urgent tasks are shown
**And** each card shows: task title, hive name, priority badge
**And** tapping card navigates to task detail
**And** "View All Tasks" link goes to Tasks tab

**Given** I have no pending tasks
**When** viewing the hero section
**Then** message shows "All caught up!" or similar positive state
**And** next scheduled task date could be shown if available

### Story 7.4: Dashboard Hive Overview Section

As a beekeeper,
I want to see hive status overview,
So that I can spot problems quickly.

**Acceptance Criteria:**

**Given** I am on the dashboard
**When** I scroll below task hero
**Then** I see "Your Hives" section header with total count
**And** I see summary stats: X healthy, Y need attention, Z urgent (FR41)
**And** I see hive cards for hives needing attention first

**Given** hives have different statuses
**When** viewing hive cards
**Then** each card shows: hive name, location, status badge, last inspection date
**And** status badges use correct colors (green/yellow/red)
**And** status includes icon, not just color (accessibility)

**Given** I tap a hive card
**When** navigation triggers
**Then** I go to hive detail screen
**And** I can quickly log an inspection from there

**Given** I have many hives
**When** viewing the section
**Then** "View All Hives" link navigates to Locations tab
**And** section shows reasonable number (5-10) before truncating

### Story 7.5: Dashboard Location Filter

As a beekeeper with multiple locations,
I want to filter dashboard by location,
So that I can focus on one apiary at a time.

**Acceptance Criteria:**

**Given** I have multiple locations
**When** I view the dashboard
**Then** location filter chips appear below header (FR43)
**And** "All Locations" is selected by default
**And** each location name is shown as a chip

**Given** I tap a location chip
**When** filter applies
**Then** task hero updates to show only tasks for that location
**And** hive overview shows only hives at that location
**And** selected chip is visually highlighted
**And** counts update to reflect filtered data

**Given** I tap "All Locations"
**When** filter resets
**Then** dashboard shows data across all locations
**And** previous location chip is deselected

### Story 7.6: Sync Status Indicator

As a beekeeper,
I want to see sync status,
So that I know if my data is backed up.

**Acceptance Criteria:**

**Given** I am on the dashboard
**When** viewing the app bar or status area
**Then** sync status indicator is visible (FR47)
**And** indicator shows current state: synced / syncing / offline / error

**Given** app is online and synced
**When** viewing status
**Then** green checkmark or "Synced" indicator shows
**And** last sync time could be shown on tap

**Given** app is offline
**When** viewing status
**Then** offline icon shows (cloud with slash)
**And** "Offline - changes will sync when connected" tooltip available

**Given** sync is in progress
**When** viewing status
**Then** syncing animation shows
**And** progress indication if determinable

**Given** sync has errors
**When** viewing status
**Then** error indicator shows (red/warning) (NFR16)
**And** tapping shows details and retry option
**And** user gets clear feedback on sync failures

### Story 7.7: Dashboard Pull-to-Refresh

As a beekeeper,
I want to refresh dashboard data,
So that I see the latest status.

**Acceptance Criteria:**

**Given** I am on the dashboard
**When** I pull down to refresh
**Then** refresh indicator appears
**And** dashboard data reloads from local database
**And** sync is triggered if online
**And** UI updates with fresh data

**Given** I refresh while offline
**When** refresh completes
**Then** local data reloads (may be unchanged)
**And** offline indicator remains visible
**And** no error shown for offline refresh

**And** refresh completes within 1 second for local data
**And** haptic feedback on pull threshold

---

## Epic 8: Notifications

Users get timely reminders for scheduled tasks. Push notification service with user-configurable preferences.

### Story 8.1: Notification Domain Model

As a developer,
I want domain models for notification preferences,
So that user settings persist correctly.

**Acceptance Criteria:**

**Given** core_domain exists
**When** notification domain is implemented
**Then** NotificationPreferences entity exists with: task_reminders_enabled, sync_errors_enabled, reminder_time (hour/minute)
**And** NotificationCategory enum exists: task_reminders, sync_alerts
**And** NotificationRepository interface defines getPreferences, updatePreferences
**And** default preferences enable task reminders, disable sync errors
**And** preferences stored locally with sync support

### Story 8.2: Push Notification Service

As a developer,
I want push notification infrastructure,
So that the app can send local notifications.

**Acceptance Criteria:**

**Given** core_infrastructure package exists
**When** PushNotificationService is implemented
**Then** service initializes notification channels (Android) and permissions (iOS)
**And** service can schedule local notifications at specific times
**And** service can show immediate notifications
**And** notification tap opens relevant screen (deep linking)
**And** service respects user preferences (enabled/disabled)
**And** service is registered with GetIt

### Story 8.3: Task Reminder Notifications

As a beekeeper,
I want reminders for scheduled tasks,
So that I don't forget important work.

**Acceptance Criteria:**

**Given** task reminders are enabled
**When** a task has a due date
**Then** notification is scheduled for reminder time on due date (FR48)
**And** notification shows: task title, hive/location name
**And** tapping notification opens task detail

**Given** a task is completed before due date
**When** completion saves
**Then** scheduled notification is cancelled

**Given** a task due date is changed
**When** update saves
**Then** notification is rescheduled to new date

**Given** reminder time setting is changed
**When** setting saves
**Then** all future notifications use new time

### Story 8.4: Sync Error Notifications

As a beekeeper,
I want to know if sync fails,
So that I can ensure my data is backed up.

**Acceptance Criteria:**

**Given** sync error notifications are enabled
**When** sync fails after retries
**Then** notification shows: "Sync failed - tap to retry" (FR50)
**And** tapping notification opens app with sync retry option

**Given** sync error notifications are disabled
**When** sync fails
**Then** no notification is shown
**And** error is still visible in-app via sync status indicator

**And** notifications don't spam - max 1 per hour for sync errors
**And** notification clears when sync succeeds

### Story 8.5: Notification Settings Screen

As a beekeeper,
I want to control notification settings,
So that I only get notifications I want.

**Acceptance Criteria:**

**Given** I navigate to Settings > Notifications
**When** the settings screen loads
**Then** I see toggle for "Task Reminders" with description (FR49)
**And** I see toggle for "Sync Alerts" with description
**And** I see time picker for reminder time (default: 8:00 AM)
**And** current settings are reflected in toggles

**Given** I toggle a notification category
**When** toggle state changes
**Then** preference saves immediately
**And** future notifications respect new setting
**And** existing scheduled notifications are updated/cancelled

**Given** I change reminder time
**When** new time is selected
**Then** preference saves
**And** all scheduled task reminders are rescheduled

**And** settings work offline (save locally, sync later)
**And** screen uses core_ui toggle components

### Story 8.6: Notification Permission Handling

As a beekeeper,
I want clear notification permission requests,
So that I understand why the app needs permission.

**Acceptance Criteria:**

**Given** I launch the app for the first time
**When** I reach a feature needing notifications
**Then** permission is requested with clear explanation
**And** explanation states: "Get reminders for scheduled tasks"

**Given** I denied notification permission
**When** I try to enable reminders in settings
**Then** message explains permission is needed
**And** "Open Settings" button links to system settings
**And** toggle remains off until permission granted

**Given** I grant permission later via system settings
**When** I return to the app
**Then** notification toggles become functional
**And** I can enable desired notification categories

**And** permission state is checked on app launch
**And** service gracefully handles permission denied
