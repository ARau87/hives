14# Story 1.14: Form & Layout Utility Components

Status: done

<!-- Note: Validation is optional. Run validate-create-story for quality check before dev-story. -->

## Story

As a developer,
I want date picker, collapsible form section, and section header components in the widget library,
so that Epic 4 forms and all subsequent list screens have consistent, design-reviewed layout building blocks.

## Acceptance Criteria


1. **HivesDatePicker** renders identically to `HivesTextField` (inherits theming), is read-only tap-triggered, shows calendar icon suffix `#A8A29E`, opens `showDatePicker()` on tap, formats output as "d MMMM yyyy"; variants: `empty` (placeholder "Select date"), `filled`, `disabled`, `error` (red border + message)
2. **HivesFormSection** accepts `title`, `isCollapsible` (default true), `isInitiallyExpanded` (default false), and `child` widget; renders 15px SemiBold header with animated chevron; animates expand/collapse with 300ms ease-in-out; shows 1px `#E7E5E4` separator above header; `required` variant (non-collapsible) always visible
3. **HivesSectionHeader** accepts `title` and optional `actionLabel` + `onAction`; renders 18px SemiBold `#1C1917` title and optional 14px Medium `#F59E0A` text action in a space-between row; respects 20px screen margin; variants: `withAction` and `standalone`
4. All components are exported via `package:ui/ui.dart`
5. Each component has a Widgetbook story documenting all variants and states
6. `dart analyze` passes with zero issues and all widget tests pass

## Tasks / Subtasks

- [x] Task 1: Create `HivesDatePicker` component (AC: #1)
  - [x] 1.1 Create `packages/ui/lib/src/components/forms/hives_date_picker.dart`
  - [x] 1.2 Implement read-only tap-triggered field using `HivesTextField` theming (reuse `InputThemeTokens`)
  - [x] 1.3 Show calendar icon suffix in `#A8A29E` (`AppColors.onSurfaceVariant`)
  - [x] 1.4 Open `showDatePicker()` on tap, format result as "d MMMM yyyy" using `intl` package
  - [x] 1.5 Support variants: `empty`, `filled`, `disabled`, `error`
  - [x] 1.6 Write widget tests: `packages/ui/test/components/forms/hives_date_picker_test.dart`
  - [x] 1.7 Create Widgetbook use cases: `apps/storybook/lib/usecases/forms/hives_date_picker_usecases.dart`

- [x] Task 2: Create `HivesFormSection` component (AC: #2)
  - [x] 2.1 Create `packages/ui/lib/src/components/forms/hives_form_section.dart`
  - [x] 2.2 Accept `title`, `isCollapsible` (default true), `isInitiallyExpanded` (default false), `child`
  - [x] 2.3 Render 15px SemiBold header with animated chevron rotation
  - [x] 2.4 Animate expand/collapse with 300ms ease-in-out using `AnimationController` + `SizeTransition`
  - [x] 2.5 Show 1px `#E7E5E4` (`AppColors.outline`) separator above header
  - [x] 2.6 Support `required` variant: non-collapsible, always visible, no chevron
  - [x] 2.7 Write widget tests: `packages/ui/test/components/forms/hives_form_section_test.dart`
  - [x] 2.8 Create Widgetbook use cases: `apps/storybook/lib/usecases/forms/hives_form_section_usecases.dart`

- [x] Task 3: Create `HivesSectionHeader` component (AC: #3)
  - [x] 3.1 Create `packages/ui/lib/src/components/forms/hives_section_header.dart`
  - [x] 3.2 Accept `title` and optional `actionLabel` + `onAction`
  - [x] 3.3 Render 18px SemiBold `#1C1917` (`AppColors.onSurface`) title
  - [x] 3.4 Render optional 14px Medium `#F59E0A` (`AppColors.primary`) text action, right-aligned
  - [x] 3.5 Use `Row` with `MainAxisAlignment.spaceBetween`
  - [x] 3.6 Write widget tests: `packages/ui/test/components/forms/hives_section_header_test.dart`
  - [x] 3.7 Create Widgetbook use cases: `apps/storybook/lib/usecases/forms/hives_section_header_usecases.dart`

- [x] Task 4: Create barrel exports and integrate (AC: #4)
  - [x] 4.1 Create `packages/ui/lib/src/components/forms/forms.dart` barrel file exporting all 3 components
  - [x] 4.2 Add `export 'src/components/forms/forms.dart';` to `packages/ui/lib/ui.dart`

- [x] Task 5: Verify all quality gates (AC: #5, #6)
  - [x] 5.1 Run `dart analyze` on `packages/ui` — zero issues (info-level only, matching existing codebase)
  - [x] 5.2 Run all widget tests — all 24 new tests pass, zero regressions in full suite
  - [x] 5.3 Verify Widgetbook builds without errors

## Dev Notes

### Architecture Patterns & Constraints

**Component Location:** `packages/ui/lib/src/components/forms/`
- This is a NEW directory — create it fresh
- Follow the established pattern: `{feature}/{component}.dart` + `{feature}.dart` barrel

**Theme Token Usage (CRITICAL — no hardcoded values):**
- Use `Theme.of(context)` and `theme.extension<InputThemeTokens>()` for input styling
- Use `AppColors` for all color references (e.g., `AppColors.onSurfaceVariant`, `AppColors.outline`, `AppColors.primary`)
- Use `AppTypography` for text styles — check actual class for exact style names before using
- Use `AppSpacing` for spacing values (e.g., `AppSpacing.screenMargin` = 20px)

**Existing Components to Reuse (DO NOT reinvent):**
- `HivesTextField` — reuse its theming for `HivesDatePicker` appearance; the date picker should look like a text field
- `InputThemeTokens` — use the same tokens for consistent field styling
- `AppTheme.lightTheme` / `AppTheme.darkTheme` — always test both themes

**Animation Pattern (from 1-13 learnings):**
- Use `StatefulWidget` with `SingleTickerProviderStateMixin` for animated components
- Manage `AnimationController` in `initState()`, `didUpdateWidget()`, and `dispose()`
- Use `CurvedAnimation` with appropriate curves
- For expand/collapse: `SizeTransition` + `AnimationController(duration: 300ms)`

**Widget Best Practices (from previous stories):**
- Always use `const` constructors where possible
- Use `switch` expressions over `if-else` for variant mapping
- Use `.withValues(alpha: x)` NOT deprecated `.withOpacity(x)`
- Add `semanticLabel` to all icons for accessibility
- Use `Material`/`InkWell` for tappable areas (NOT `GestureDetector`)
- Pass `null` to `onTap` when disabled to block interaction

### Testing Standards

**Test Setup Template:**
```dart
void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);
  group('ComponentName', () {
    Widget buildWidget(Widget child, {ThemeData? theme}) => MaterialApp(
      theme: theme ?? AppTheme.lightTheme,
      home: Scaffold(body: child),
    );
    // tests...
  });
}
```

**Required Test Coverage per Component:**
1. Each variant renders correctly
2. Interaction callbacks fire when tapped
3. Disabled state blocks interaction
4. Dark mode renders without exception
5. Animation states transition correctly (for HivesFormSection)
6. Error state displays error message (for HivesDatePicker)

### Widgetbook Pattern

**Use static per-variant use case functions** (NOT interactive knobs, based on recent story patterns):
- Create separate `@widgetbook.UseCase` for each variant
- Wrap in `Center` + `SizedBox(width: 300)` for consistent presentation
- Use knobs for interactive properties where useful

### Date Formatting

**The `intl` package** is needed for "d MMMM yyyy" date formatting:
- Check if `intl` is already a dependency in `packages/ui/pubspec.yaml`
- If not, add it as a dependency
- Use `DateFormat('d MMMM yyyy').format(date)` for output

### Project Structure Notes

- Alignment with unified project structure: New `forms/` directory under `components/` follows established pattern (like `auth/`, `buttons/`, `feedback/`, `surfaces/`, `hives/`, `locations/`)
- Export chain: `forms.dart` barrel → `ui.dart` root barrel (matches `buttons/buttons.dart` → `ui.dart` pattern)
- Test mirror: `test/components/forms/` mirrors `lib/src/components/forms/`
- Storybook mirror: `apps/storybook/lib/usecases/forms/` mirrors component structure

### References

- [Source: _bmad-output/planning-artifacts/epics.md#Story 1.14]
- [Source: _bmad-output/planning-artifacts/architecture.md#Core UI Package Structure]
- [Source: _bmad-output/planning-artifacts/ux-design-specification.md#Forms & Input Components]
- [Source: _bmad-output/planning-artifacts/ux-design-specification.md#Layout Patterns & Spacing System]
- [Source: _bmad-output/planning-artifacts/ux-design-specification.md#Section Headers]
- [Source: _bmad-output/implementation-artifacts/1-13-hive-card-system.md#Dev Notes]
- [Source: packages/ui/lib/src/theme/input_theme.dart]
- [Source: packages/ui/lib/src/components/inputs/hives_text_field.dart]

## Dev Agent Record

### Agent Model Used

Claude Opus 4.6

### Debug Log References

None — clean implementation with no blockers.

### Completion Notes List

- Implemented HivesDatePicker as a read-only tap-triggered field using InputDecorator with InputThemeTokens for consistent styling with HivesTextField. Added `intl` dependency for "d MMMM yyyy" date formatting. Supports empty/filled/disabled/error variants.
- Implemented HivesFormSection with StatefulWidget + SingleTickerProviderStateMixin for animated expand/collapse (300ms ease-in-out). SizeTransition for content, RotationTransition for chevron. Required variant uses named constructor.
- Implemented HivesSectionHeader with Row + spaceBetween layout, 18px SemiBold title (AppColors.onSurface), optional 14px Medium action (AppColors.primary) wrapped in Material/InkWell.
- All components use AppColors (no hardcoded colors), const constructors, semantic labels on icons, Material/InkWell for tap targets, null onTap for disabled states.
- 24 widget tests covering all variants, interaction callbacks, disabled states, dark mode rendering, animation states, and semantic labels.
- 9 Widgetbook use cases (4 date picker, 3 form section, 2 section header) documenting all variants.
- Barrel export chain: forms.dart → ui.dart.

### Change Log

- 2026-03-09: Initial implementation of all 3 form/layout utility components with tests and Widgetbook stories.
- 2026-03-09: Code review fixes applied — replaced all hardcoded AppColors static references with theme-aware colorScheme equivalents (dark mode bug fixes); removed explicit contentPadding override in HivesDatePicker to align with HivesTextField; added minHeight constraint from InputThemeTokens; made HivesFormSectionState private; fixed didUpdateWidget setState; strengthened separator test; updated File List with missing entries.

### File List

- packages/ui/pubspec.yaml (modified — added intl dependency)
- packages/ui/lib/ui.dart (modified — added forms barrel export)
- packages/ui/lib/src/components/forms/forms.dart (new)
- packages/ui/lib/src/components/forms/hives_date_picker.dart (new)
- packages/ui/lib/src/components/forms/hives_form_section.dart (new)
- packages/ui/lib/src/components/forms/hives_section_header.dart (new)
- packages/ui/test/components/forms/hives_date_picker_test.dart (new)
- packages/ui/test/components/forms/hives_form_section_test.dart (new)
- packages/ui/test/components/forms/hives_section_header_test.dart (new)
- apps/storybook/lib/usecases/forms/hives_date_picker_usecases.dart (new)
- apps/storybook/lib/usecases/forms/hives_form_section_usecases.dart (new)
- apps/storybook/lib/usecases/forms/hives_section_header_usecases.dart (new)
- apps/storybook/pubspec.yaml (modified — added assets section for storybook image assets)
- apps/storybook/assets/meadow_apiary.jpg (new — storybook image asset)
- pubspec.lock (modified — updated lock file after adding intl dependency)
- _bmad-output/implementation-artifacts/sprint-status.yaml (modified)
- _bmad-output/implementation-artifacts/1-14-form-and-layout-utility-components.md (modified)
