---
applyTo: "packages/ui/**/*"
---

# UI Package Instructions

The `packages/ui` package is a reusable design system and component library. It serves as the single source of truth for UI components, themes, and design tokens across all applications in the workspace.

## Package Structure

- **`lib/src/components/`**: Organized by feature area (buttons, inputs, feedback, surfaces, typography).
- **`lib/src/theme/`**: Design tokens and Material 3 theme configuration.
- **`lib/ui.dart`**: Public barrel file exporting the public API.

## Core Principles

### 1. Library Organization & Public API

- **DO** organize all components in libraries within `lib/src/` by category.
- **DO** export public components and themes through the main `lib/ui.dart` barrel file.
- **DO** keep the public API minimal and intention-revealing.
- **DON'T** export internal implementation details (private classes, utilities).
- **PREFER** exporting complete feature areas via category barrels (e.g., `components/buttons.dart`).
- **DO** use `export` statements in barrel files to compose the public API.

### 2. Theme & Design Tokens

- **DO** define all design tokens in dedicated theme files (`hives_colors.dart`, `hives_spacings.dart`, etc.).
- **DO** prefer `Theme.of(context)` values over hardcoded colors, text styles, shapes, and sizes.
- **DO** prefer `ColorScheme` roles (e.g., `theme.colorScheme.primary`) instead of raw `Color(0xFF...)`.
- **DO** prefer `TextTheme` (e.g., `theme.textTheme.titleMedium`) instead of hardcoded `TextStyle(...)`.
- **DO** prefer Material component theming (`FilledButtonThemeData`, `InputDecorationTheme`, etc.) instead of styling every widget inline.
- **AVOID** hardcoded spacing values scattered throughout components.
- **PREFER** a centralized spacing system via `hives_spacings.dart` or consistent `Theme` extension access.
- **DO** document design token purpose and usage in comments or doc strings.

### 3. Widget Implementation Best Practices

#### Material Design Compliance
- **DO** use widgets from the Material library whenever possible.
- **NEVER** reimplement widgets from scratch unless there is a compelling reason (custom gestures, unique interaction, brand-specific behavior).
- **PREFER** composing and extending existing Material widgets over complete rewrites.
- **DO** use Material 3 (`useMaterial3: true`) as the foundation.
- **DO** ensure all custom components respect Material 3 design principles.

#### Widget Composition
- **DO** keep components small and focused.
- **PREFER** `const` constructors for all components when possible.
- **DO** make all component fields final.
- **DO** document component behavior, parameters, and usage in comprehensive doc comments.
- **DON'T** include navigation, dialogs, or platform-specific IO in components.
- **PREFER** callback parameters for user interactions (e.g., `onPressed`, `onChanged`) over side effects.

#### Styling & Customization
- **AVOID** exposing low-level styling parameters (raw colors, fonts, sizes) in component constructors.
- **PREFER** semantic, high-level parameters that map to design tokens.
- **DO** allow theme-based overrides where appropriate via Material's theming system.
- **CONSIDER** providing optional style parameters for justified customization, but validate they don't violate design principles.

### 4. Documentation & Code Quality

- **DO** use `///` doc comments to document all public components and their parameters.
- **DO** start doc comments with a single-sentence summary describing the component's purpose.
- **DO** document all parameters, return values, and exceptions in doc comments.
- **DO** include code samples in doc comments for complex components.
- **DO** follow [Effective Dart](https://dart.dev/effective-dart) guidelines.
- **DO** format code using `dart format`.
- **PREFER** lines 80 characters or fewer.
- **DO** use meaningful, intention-revealing names for components and parameters.

### 5. Widgetbook Integration

- **DO** create Widgetbook use cases for all reusable components.
- **DO** use `widgetbook_annotations` for use case definitions.
- **DO** organize use cases in folders reflecting the component structure.
- **DO** document component variations, states, and usage patterns in use case descriptions.
- **DO** include edge cases (empty states, long text, loading states) in Widgetbook previews.

### 6. Consistency & Patterns

- **DO** maintain consistent naming patterns across components (e.g., `onPressed`, `onChanged`).
- **DO** use consistent parameter ordering (required first, optional with defaults last).
- **PREFER** sealed classes or enums for state management within components (e.g., button states, input validation states).
- **DO** ensure all components handle null-safe parameters correctly.
- **DO** test edge cases (empty strings, very long text, boundary conditions).

### 7. Dependencies

- **DO** limit external dependencies; components should depend only on Flutter and shared packages.
- **PREFER** using Flutter and Material libraries over third-party packages when feasible.
- **DO** document why any external dependency is necessary.

### 8. Accessibility

- **DO** ensure all interactive components are keyboard-accessible.
- **DO** provide semantic labels for complex components.
- **DO** ensure sufficient color contrast; don't rely on color alone for information.
- **DO** use Material components' built-in accessibility features (tooltips, semantics).
- **PREFER** adequate tap target sizes (minimum 48x48 dp) for interactive elements.

### 9. Testing

- **DO** write widget tests for all custom components.
- **DO** test component state changes, callbacks, and edge cases.
- **PREFER** golden tests for visually critical components.
- **DO** test both light and dark theme variants.
- **DO** test text scaling and responsive behavior.


