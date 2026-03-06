# Story 1.11: Feedback & Confirmation Components

Status: done

<!-- Note: Validation is optional. Run validate-create-story for quality check before dev-story. -->

## Story

As a developer,
I want empty state and destructive confirmation components in the widget library,
so that all list screens and delete flows across Epics 3-5 have a consistent, design-reviewed UX.

## Acceptance Criteria

1. **HivesEmptyState** accepts `title`, `subtitle`, optional `ctaLabel`/`onCta`, and an `illustration` widget; renders vertically centered with 96px illustration, 18px SemiBold title, 15px `#A8A29E` subtitle, and optional primary CTA button; variants: `noLocations`, `noHives`, `noTasks`, `noResults`
2. **HivesDangerButton** matches `PrimaryButton` sizing (54px height, 16px radius), fills `#EF4444`, applies `0 6px 16px rgba(239,68,68,0.30)` shadow, supports `loading` (spinner) and `disabled` (low opacity) states
3. **HivesConfirmDialog** is a bottom sheet (28px top radius) accepting `icon`, `title`, `body`, `confirmLabel`, `onConfirm`, `onCancel`; renders icon 48px top-center, title 18px SemiBold, body 15px `#A8A29E`, `HivesDangerButton` confirm + ghost cancel; variants: `danger` (red) and `warning` (amber)
4. All components are exported via `package:ui/ui.dart`
5. Each component has a Widgetbook story documenting all variants and states
6. `dart analyze` passes with zero issues and all widget tests pass

## Tasks / Subtasks

- [x] Task 1: Create HivesEmptyState widget (AC: #1)
  - [x] 1.1 Create `packages/ui/lib/src/components/feedback/hives_empty_state.dart`
  - [x] 1.2 Implement `HivesEmptyStateVariant` enum: `noLocations`, `noHives`, `noTasks`, `noResults`
  - [x] 1.3 Accept `title` (String), `subtitle` (String), optional `ctaLabel` (String?), optional `onCta` (VoidCallback?), `illustration` (Widget)
  - [x] 1.4 Render vertically centered Column: 96px illustration, 18px SemiBold title (AppTypography), 15px subtitle in `#A8A29E` (AppColors.onSurfaceVariant), optional PrimaryButton CTA
  - [x] 1.5 Add factory constructors or static methods per variant with default title/subtitle/illustration
  - [x] 1.6 Write widget tests for all 4 variants and CTA callback
  - [x] 1.7 Create Widgetbook use cases in `apps/storybook/lib/usecases/feedback/`

- [x] Task 2: Create HivesDangerButton widget (AC: #2)
  - [x] 2.1 Create `packages/ui/lib/src/components/buttons/hives_danger_button.dart`
  - [x] 2.2 Match PrimaryButton API: `label`, `onPressed`, `isLoading`, `isEnabled`, `icon`, `iconLeading`, `width`, `height`
  - [x] 2.3 Use `FilledButton` with urgent red fill: `AppColors.urgentStatus` (`#EF4444`) background, white text
  - [x] 2.4 Apply `BoxShadow(color: Color(0x4CEF4444), offset: Offset(0, 6), blurRadius: 16)` via DecoratedBox or Container wrapper
  - [x] 2.5 Sizing: 54px min height (`AppSpacing.buttonHeight`), 16px radius (`AppSpacing.buttonRadius`)
  - [x] 2.6 `isLoading` state: show `HivesLoadingIndicator` (spinner) centered, disable press
  - [x] 2.7 `isEnabled=false`: reduce opacity to 0.5 (ButtonThemeTokens.disabledOpacity)
  - [x] 2.8 Write widget tests: default render, loading state, disabled state, onPressed callback, icon support
  - [x] 2.9 Create Widgetbook use cases in `apps/storybook/lib/usecases/buttons/`

- [x] Task 3: Create HivesConfirmDialog widget (AC: #3)
  - [x] 3.1 Create `packages/ui/lib/src/components/feedback/hives_confirm_dialog.dart`
  - [x] 3.2 Implement `HivesConfirmDialogVariant` enum: `danger` (red), `warning` (amber)
  - [x] 3.3 Accept params: `icon` (IconData), `title` (String), `body` (String), `confirmLabel` (String), `onConfirm` (VoidCallback), `onCancel` (VoidCallback?)
  - [x] 3.4 Render as bottom sheet content (use existing `showHivesBottomSheet` wrapper): icon 48px top-center, title 18px SemiBold, body 15px in `#A8A29E`, HivesDangerButton for confirm, PlainTextButton for cancel
  - [x] 3.5 `danger` variant: red icon tint (`AppColors.urgentStatus`), HivesDangerButton
  - [x] 3.6 `warning` variant: amber icon tint (`AppColors.primary`), PrimaryButton (amber) for confirm instead of danger
  - [x] 3.7 Create static `show()` method that wraps `showHivesBottomSheet` for convenient one-liner invocation
  - [x] 3.8 Write widget tests: both variants render correctly, confirm callback fires, cancel callback fires, icon/title/body display
  - [x] 3.9 Create Widgetbook use cases in `apps/storybook/lib/usecases/feedback/`

- [x] Task 4: Export and integrate (AC: #4, #5, #6)
  - [x] 4.1 Add HivesEmptyState and HivesConfirmDialog exports to `packages/ui/lib/src/components/feedback/feedback.dart`
  - [x] 4.2 Add HivesDangerButton export to `packages/ui/lib/src/components/buttons/buttons.dart`
  - [x] 4.3 Verify exports visible via `package:ui/ui.dart` (already exports feedback.dart and buttons.dart barrels)
  - [x] 4.4 Run `dart run build_runner build` in `apps/storybook/` to regenerate
  - [x] 4.5 Run `dart analyze` across all packages and fix any issues
  - [x] 4.6 Run full test suite: `melos run test` and ensure all pass

## Dev Notes

### Component Architecture

**HivesEmptyState** goes in `packages/ui/lib/src/components/feedback/` — the existing feedback directory that already contains `status_badge.dart`, `hives_loading_indicator.dart`, `snack_bar_service.dart`, etc.

**HivesDangerButton** goes in `packages/ui/lib/src/components/buttons/` — alongside existing `primary_button.dart`, `secondary_button.dart`, `highlight_button.dart`, `text_button.dart`.

**HivesConfirmDialog** goes in `packages/ui/lib/src/components/feedback/` — it's a feedback/confirmation component, logically grouped with other feedback widgets.

### Widget Patterns to Follow (from existing codebase)

- `PrimaryButton` is the reference implementation for HivesDangerButton — same API shape, shimmer loading pattern, StatefulWidget with SingleTickerProviderStateMixin for animation
- `showHivesBottomSheet()` in `packages/ui/lib/src/components/surfaces/hives_bottom_sheet.dart` is the base for HivesConfirmDialog — wraps `showModalBottomSheet` with 28px top radius and drag handle
- `PlainTextButton` in `packages/ui/lib/src/components/buttons/text_button.dart` is the ghost cancel button
- `HivesLoadingIndicator` in `packages/ui/lib/src/components/feedback/hives_loading_indicator.dart` for loading spinner
- Access theme via `context.colors`, `context.spacings`, `context.textTheme` (from `HivesContextExtension` in `packages/ui/lib/src/extensions/context_extensions.dart`)
- All color values come from `AppColors`/`HivesColors` — NO hardcoded hex values in widget code
- Follow existing naming: `Hives` prefix for all public widgets
- `const` constructors wherever possible

### Critical Design Token Mapping

Map spec colors to existing theme tokens:

| Spec Color | Token | Usage |
|---|---|---|
| `#EF4444` | `AppColors.urgentStatus` / `HivesColors.urgentRed` | HivesDangerButton fill, danger icon tint |
| `#A8A29E` | `AppColors.onSurfaceVariant` / `HivesColors.surfaceOnMuted` | Subtitle text in empty states, body text in confirm dialog |
| `#F59E0A` | `AppColors.primary` / `context.colorScheme.primary` | Warning variant icon tint, amber confirm button |
| `#1C1917` | `AppColors.onSurface` | Title text |
| `#FFFFFF` | `context.colorScheme.onError` or `Colors.white` | Text on danger button |
| `rgba(239,68,68,0.30)` | `AppColors.urgentStatus.withValues(alpha: 0.30)` | Danger button shadow |

**CRITICAL**: Always use theme tokens, never hardcode hex values. Check `packages/ui/lib/src/theme/app_colors.dart` and `hives_colors.dart` for exact token names.

### HivesDangerButton Implementation Notes

- **Follow PrimaryButton pattern exactly** — same constructor parameters, same StatefulWidget approach if shimmer loading is needed, or StatelessWidget if a simple spinner is sufficient
- Use `FilledButton` as base (like PrimaryButton) but override `backgroundColor` to `AppColors.urgentStatus`
- For the shadow: wrap in `DecoratedBox` or use `Container` with `BoxDecoration(boxShadow: [BoxShadow(...)])` since Material buttons don't natively support custom `boxShadow`
- Alternative: use `FilledButton.styleFrom(backgroundColor: urgentColor, shadowColor: urgentColor.withOpacity(0.3), elevation: 6)` — test if Material elevation gives close enough shadow
- Disabled state: `Opacity(opacity: 0.5, child: IgnorePointer(...))` or use `FilledButton.styleFrom` with disabled colors
- Loading state: replace label with `SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))` or use existing `HivesLoadingIndicator`

### HivesEmptyState Implementation Notes

- StatelessWidget with Column layout centered in parent
- Illustration: accept any Widget (allows flexibility for Material Icons, SVG, Lottie, etc.)
- Each variant factory should provide sensible defaults:
  - `noLocations`: title="No locations yet", subtitle="Add your first apiary to get started", illustration=Icons.location_off (48px, gray)
  - `noHives`: title="No hives here", subtitle="Add your first hive to this location", illustration=Icons.hive (48px, gray)
  - `noTasks`: title="All caught up!", subtitle="No tasks need your attention right now", illustration=Icons.check_circle_outline (48px, green)
  - `noResults`: title="No results found", subtitle="Try adjusting your search or filters", illustration=Icons.search_off (48px, gray)
- If `ctaLabel` and `onCta` are both provided, show a PrimaryButton below the subtitle
- Use `AppSpacing` for all gaps: `AppSpacing.lg` (16px) between elements

### HivesConfirmDialog Implementation Notes

- This is NOT a standalone widget — it's content rendered inside `showHivesBottomSheet`
- Create a `HivesConfirmDialog` widget class for the bottom sheet content
- Create a static `HivesConfirmDialog.show()` convenience method that wraps `showHivesBottomSheet`
- Layout: Padding around Column with `icon` (48px, tinted by variant color), `SizedBox(height: 16)`, title (18px SemiBold), `SizedBox(height: 8)`, body (15px, onSurfaceVariant), `SizedBox(height: 24)`, confirm button (full width), `SizedBox(height: 12)`, cancel PlainTextButton (full width), `SizedBox(height: 16)` bottom padding
- `danger` variant: icon uses `AppColors.urgentStatus`, confirm is HivesDangerButton
- `warning` variant: icon uses `AppColors.primary`, confirm is PrimaryButton (amber)
- Cancel always uses PlainTextButton with label "Cancel" (or accept custom cancelLabel)
- `onCancel` defaults to `Navigator.pop(context)` if not provided

### Existing Widgets to REUSE (DO NOT Reinvent)

| Widget | Location | Usage |
|---|---|---|
| `PrimaryButton` | `buttons/primary_button.dart` | CTA in empty state, warning confirm button |
| `PlainTextButton` | `buttons/text_button.dart` | Ghost cancel button in confirm dialog |
| `HivesLoadingIndicator` | `feedback/hives_loading_indicator.dart` | Loading state for danger button |
| `showHivesBottomSheet` | `surfaces/hives_bottom_sheet.dart` | Bottom sheet wrapper for confirm dialog |
| `AppSpacing` | `theme/app_spacing.dart` | All spacing constants (buttonHeight, buttonRadius, modalTopRadius) |
| `AppColors` | `theme/app_colors.dart` | All color tokens (urgentStatus, onSurfaceVariant, primary) |

### Project Structure Notes

- HivesEmptyState and HivesConfirmDialog go in `packages/ui/lib/src/components/feedback/` (existing directory)
- HivesDangerButton goes in `packages/ui/lib/src/components/buttons/` (existing directory)
- NO new directories needed — all target directories already exist
- Export chain: `feedback.dart` barrel already exported in `ui.dart`; `buttons.dart` barrel already exported in `ui.dart`
- Widget tests go in `packages/ui/test/components/feedback/` (NEW directory) and `packages/ui/test/components/buttons/` (NEW directory)
- Widgetbook use cases go in existing `apps/storybook/lib/usecases/feedback/` and `apps/storybook/lib/usecases/buttons/`
- This story does NOT create screens — only reusable widget building blocks for Epics 3-5

### Testing Standards

**Widget test pattern** (from existing `packages/ui/test/` and story 1-10):
- Test each variant/state renders correctly
- Test interactions (tap, input) trigger expected callbacks
- Test accessibility (semantic labels)
- Use `pumpWidget` with `MaterialApp(theme: AppTheme.lightTheme)` wrapper
- `setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false)` at top of test file
- Avoid testing implementation details; test behavior and visual output

**Minimum test coverage:**
- HivesEmptyState: 6 tests — one per variant, CTA callback fires, CTA hidden when no callback
- HivesDangerButton: 5 tests — default render, loading state shows spinner, disabled state, onPressed fires, renders without error in dark mode
- HivesConfirmDialog: 5 tests — danger variant renders, warning variant renders, confirm callback fires, cancel callback fires, icon/title/body display

### Previous Story Intelligence (1-10: Auth UI Components)

**Patterns established that MUST be followed:**
- Material 3 components (use M3 APIs, not M2)
- `const` constructors everywhere possible
- Theme tokens for all visual values — no hardcoded colors/sizes
- Widget tests use `pumpWidget` with `MaterialApp(theme: AppTheme.lightTheme)` wrapper
- `GoogleFonts.config.allowRuntimeFetching = false` in `setUpAll`
- Barrel exports follow `package:ui/ui.dart` chain
- `dart analyze` must pass with zero issues before completion
- Widgetbook use cases use `@widgetbook.UseCase(name: '...', type: WidgetType)` annotation
- Run `dart run build_runner build` in `apps/storybook/` to regenerate after adding use cases

**Review issues from story 1-10 to AVOID:**
- Focus listeners must be added in `initState()` and removed in `dispose()` — never create FocusNodes in `build()`
- Animation controllers must use proper `TweenAnimationBuilder<Color?>` for smooth color transitions
- All resources (controllers, focus nodes, listeners) MUST be disposed

**Codebase state after story 1-10:**
- 174+ UI widget tests passing (24 auth + 150 existing)
- `dart analyze` clean
- Auth components in `packages/ui/lib/src/components/auth/`
- No other pending changes that would conflict

### Git Intelligence

**Recent commit patterns:**
- Commit style: `feat:` prefix for new features
- Stories create focused, cohesive commits
- All packages tested as a unit (`melos run test`)
- `dart analyze` verified clean before committing

**Last 5 commits:**
- `feat: implement app shell with bottom navigation using GoRouter`
- `feat: update project metadata, enhance feedback components, and add loading and status indicators`
- `feat: enhance UI components with updated theme tokens, spacing, and new HivesListTile and HivesBottomSheet implementations`
- `feat: add core data layer with Drift, SQLCipher support, and base repository pattern`
- `feat: refresh UX design specification`

### Latest Technical Notes

**Flutter/Dart versions:**
- Dart SDK: ^3.9.0 (per Melos workspace)
- Flutter: latest stable channel
- Widgetbook: ^3.20.2 with annotation ^3.9.0

**No new dependencies needed** for this story — all 3 components use standard Flutter widgets (`FilledButton`, `TextButton`, `Column`, `Container`, `BoxDecoration`, `showModalBottomSheet`) and existing library widgets (`PrimaryButton`, `PlainTextButton`, `showHivesBottomSheet`, `HivesLoadingIndicator`).

### References

- [Source: _bmad-output/planning-artifacts/epics.md#Story 1.11]
- [Source: _bmad-output/planning-artifacts/ux-design-specification.md#Feedback Components]
- [Source: _bmad-output/planning-artifacts/architecture.md#UI Layer Patterns]
- [Source: _bmad-output/planning-artifacts/architecture.md#Testing Standards]
- [Source: packages/ui/lib/src/components/buttons/primary_button.dart] — Button with loading/animation pattern
- [Source: packages/ui/lib/src/components/buttons/secondary_button.dart] — OutlinedButton pattern
- [Source: packages/ui/lib/src/components/buttons/text_button.dart] — Ghost/text button pattern
- [Source: packages/ui/lib/src/components/surfaces/hives_bottom_sheet.dart] — Bottom sheet wrapper
- [Source: packages/ui/lib/src/components/feedback/feedback.dart] — Feedback barrel export
- [Source: packages/ui/lib/src/components/feedback/hives_loading_indicator.dart] — Loading spinner
- [Source: packages/ui/lib/src/theme/app_colors.dart] — Color token definitions
- [Source: packages/ui/lib/src/theme/app_spacing.dart] — Spacing and shape constants
- [Source: packages/ui/lib/src/extensions/context_extensions.dart] — Theme access pattern
- [Source: _bmad-output/implementation-artifacts/1-10-auth-ui-components.md] — Previous story patterns and review learnings

## Dev Agent Record

### Agent Model Used

Claude Opus 4.6

### Debug Log References

N/A

### Completion Notes List

- **Task 1 (HivesEmptyState)**: Implemented StatelessWidget with 4 factory constructors (`noLocations`, `noHives`, `noTasks`, `noResults`). Each provides default title, subtitle, and Material Icon illustration. Accepts optional `ctaLabel`/`onCta` to render a PrimaryButton CTA. Uses `AppTypography.titleMedium` (18px SemiBold) for title, `AppColors.onSurfaceVariant` for subtitle. 6 widget tests passing.
- **Task 2 (HivesDangerButton)**: Implemented StatelessWidget matching PrimaryButton API (`label`, `onPressed`, `isLoading`, `isEnabled`, `icon`, `iconLeading`, `width`, `height`). Uses `FilledButton` with `AppColors.urgentStatus` background, `DecoratedBox` wrapper for `BoxShadow(color: Color(0x4CEF4444), offset: Offset(0, 6), blurRadius: 16)`. Loading state shows white `CircularProgressIndicator`, disabled state applies `Opacity(0.5)`. 5 widget tests passing.
- **Task 3 (HivesConfirmDialog)**: Implemented as content widget + static `show()` method wrapping `showHivesBottomSheet<bool>`. Two variants: `danger` (red icon tint + HivesDangerButton) and `warning` (amber icon tint + PrimaryButton). Accepts `icon`, `title`, `body`, `confirmLabel`, `onConfirm`, `onCancel`, `cancelLabel`. 5 widget tests passing.
- **Task 4 (Export & Integration)**: Updated `feedback.dart` and `buttons.dart` barrel exports. `dart analyze` clean (zero new issues, only pre-existing info-level lints). Full test suite: 190 passed, 1 pre-existing failure (`hives_otp_field_test.dart` paste test from Story 1-10). Widgetbook regenerated via `build_runner`.

### File List

**New files (9):**
- `packages/ui/lib/src/components/feedback/hives_empty_state.dart`
- `packages/ui/lib/src/components/buttons/hives_danger_button.dart`
- `packages/ui/lib/src/components/feedback/hives_confirm_dialog.dart`
- `packages/ui/test/components/feedback/hives_empty_state_test.dart`
- `packages/ui/test/components/buttons/hives_danger_button_test.dart`
- `packages/ui/test/components/feedback/hives_confirm_dialog_test.dart`
- `apps/storybook/lib/usecases/feedback/empty_state_usecases.dart`
- `apps/storybook/lib/usecases/buttons/danger_button_usecases.dart`
- `apps/storybook/lib/usecases/feedback/confirm_dialog_usecases.dart`

**Modified files (3):**
- `packages/ui/lib/src/components/feedback/feedback.dart` — added exports for `hives_confirm_dialog.dart`, `hives_empty_state.dart`
- `packages/ui/lib/src/components/buttons/buttons.dart` — added export for `hives_danger_button.dart`
- `packages/ui/lib/ui.dart` — export for `auth.dart` added (from story 1.10 uncommitted changes; included in this commit as part of the combined working tree)

**Modified files from other stories (uncommitted, included in working tree):**
- `packages/features/authentication/` — story 2.1 authentication domain model (uncommitted)
- `packages/ui/lib/src/components/auth/` — story 1.10 auth UI components (uncommitted)
- `apps/storybook/lib/usecases/auth/` — story 1.10 storybook use cases (uncommitted)

### Change Log

| Date | Change | Reason |
|---|---|---|
| 2026-03-05 | Implemented HivesEmptyState, HivesDangerButton, HivesConfirmDialog with tests and Widgetbook use cases | Story 1.11 implementation |
| 2026-03-05 | Fixed shadow color from hardcoded `Color(0x4CEF4444)` to `AppColors.urgentStatus.withValues(alpha: 0.30)` in `hives_danger_button.dart` | M1: project token mandate violation |
| 2026-03-05 | Added `ctaLabel`/`onCta` params to `noTasks` and `noResults` factory constructors in `hives_empty_state.dart` | M4: AC #1 extensibility |
| 2026-03-05 | Added `semanticLabel` to all factory constructor `Icon` illustrations in `hives_empty_state.dart` | L1: accessibility |
| 2026-03-05 | Reordered `onConfirm()` before `Navigator.pop()` in `HivesConfirmDialog.show()` | L2: prevent use-after-dismiss |
| 2026-03-05 | Removed `maxLength: 1` from `HivesOTPField` TextField to fix paste test (story 1.10 pre-existing failure) in `hives_otp_field.dart` | M3: paste test regression |
