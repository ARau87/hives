# Story 1.7: Core UI Package - Status & Feedback Widgets

Status: done

<!-- Note: Validation is optional. Run validate-create-story for quality check before dev-story. -->

## Story

As a developer,
I want status indicators and feedback widgets,
so that users get clear visual feedback on app state.

## Acceptance Criteria

1. **Given** base widgets exist in `core_ui` **When** `StatusBadge` is implemented **Then** it exists with `healthy/attention/urgent/unknown` variants using status colors from `HivesColors`
2. **And** `StatusBadge` includes both color AND icon for accessibility (not color-only) — healthy: check icon, attention: warning icon, urgent: error icon, unknown: help icon
3. **And** `HivesLoadingIndicator` exists with branded styling using `honey` color (`#F59E0A`) as indicator color
4. **And** `SyncStatusIndicator` shows `offline/syncing/synced/error` states with icon and label
5. **And** `HivesHaptics` utility provides `lightImpact()`, `mediumImpact()`, `heavyImpact()` on supported devices (wraps Flutter's `HapticFeedback` from `package:flutter/services.dart`)
6. **And** `SnackBarService` shows success/error/info messages with consistent styling (status colors, icons, floating behavior)
7. **And** all feedback responds within 100ms (NFR6) — no animations that block or delay UI updates
8. **And** widget tests verify all `StatusBadge` variants and `SyncStatusIndicator` states render correctly
9. **And** all new files exported through `lib/src/components/feedback/feedback.dart` barrel — **no `ui.dart` changes needed**

## Tasks / Subtasks

- [x] Task 1: Create `StatusBadge` widget (AC: #1, #2)
  - [x] 1.1 Create `lib/src/components/feedback/status_badge.dart`
  - [x] 1.2 Define `enum HivesStatusVariant { healthy, attention, urgent, unknown }` at top of file
  - [x] 1.3 Implement `StatusBadge extends StatelessWidget` with required `variant` and optional `size` (double, default `24.0`)
  - [x] 1.4 Background fill: `healthy→colors.healthyFill`, `attention→colors.attentionFill`, `urgent→colors.urgentFill`, `unknown→colors.unknownFill`
  - [x] 1.5 Icon color: `healthy→colors.healthyStatus`, `attention→colors.attentionStatus`, `urgent→colors.urgentStatus`, `unknown→colors.unknownStatus`
  - [x] 1.6 Icons: `healthy→Icons.check_circle`, `attention→Icons.warning`, `urgent→Icons.error`, `unknown→Icons.help_outline`
  - [x] 1.7 Layout: circular `Container` (diameter: `size`, fill background, `shape: BoxShape.circle`, `alignment: Alignment.center`) wrapping `Icon` (icon color, `size: size * 0.6`)
  - [x] 1.8 Add to `feedback.dart` barrel

- [x] Task 2: Create `HivesLoadingIndicator` widget (AC: #3)
  - [x] 2.1 Create `lib/src/components/feedback/hives_loading_indicator.dart`
  - [x] 2.2 Implement `HivesLoadingIndicator extends StatelessWidget`
  - [x] 2.3 Props: `strokeWidth` (double, default `3.0`), `size` (double?, default `null`)
  - [x] 2.4 Use `CircularProgressIndicator` with `valueColor: AlwaysStoppedAnimation<Color>(context.colors.honey)` and `strokeWidth: strokeWidth`
  - [x] 2.5 When `size != null`, wrap in `SizedBox(width: size, height: size)`; otherwise return indicator unsized
  - [x] 2.6 Add to `feedback.dart` barrel

- [x] Task 3: Create `SyncStatusIndicator` widget (AC: #4)
  - [x] 3.1 Create `lib/src/components/feedback/sync_status_indicator.dart`
  - [x] 3.2 Define `enum SyncState { offline, syncing, synced, error }` at top of file
  - [x] 3.3 Implement `SyncStatusIndicator extends StatelessWidget` with required `state`
  - [x] 3.4 State mapping:
    - `offline`: icon `Icons.cloud_off`, color `colors.unknownStatus`, label `'Offline'`
    - `syncing`: icon `Icons.sync`, color `colors.honey`, label `'Syncing...'`
    - `synced`: icon `Icons.cloud_done`, color `colors.healthyStatus`, label `'Synced'`
    - `error`: icon `Icons.sync_problem`, color `colors.urgentStatus`, label `'Sync Error'`
  - [x] 3.5 Layout: `Row(mainAxisSize: MainAxisSize.min)` → `Icon(size: 16)` + `SizedBox(width: AppSpacing.xs)` + `Text`
  - [x] 3.6 Text style: `context.textTheme.labelSmall?.copyWith(color: <stateColor>)`
  - [x] 3.7 Add to `feedback.dart` barrel

- [x] Task 4: Create `HivesHaptics` utility (AC: #5)
  - [x] 4.1 Create `lib/src/components/feedback/hives_haptics.dart`
  - [x] 4.2 Implement `abstract final class HivesHaptics` (static-only, cannot be instantiated)
  - [x] 4.3 `static Future<void> lightImpact() => HapticFeedback.lightImpact();`
  - [x] 4.4 `static Future<void> mediumImpact() => HapticFeedback.mediumImpact();`
  - [x] 4.5 `static Future<void> heavyImpact() => HapticFeedback.heavyImpact();`
  - [x] 4.6 Import: **`import 'package:flutter/services.dart';`** — NOT `flutter/material.dart` (services.dart is where HapticFeedback lives)
  - [x] 4.7 Add to `feedback.dart` barrel

- [x] Task 5: Create `SnackBarService` utility (AC: #6)
  - [x] 5.1 Create `lib/src/components/feedback/snack_bar_service.dart`
  - [x] 5.2 Implement `abstract final class SnackBarService`
  - [x] 5.3 Implement `static void showSuccess(BuildContext context, String message)`:
    - background: `context.colors.healthyStatus`, icon: `Icons.check_circle`, duration: 3s
  - [x] 5.4 Implement `static void showError(BuildContext context, String message)`:
    - background: `context.colors.urgentStatus`, icon: `Icons.error`, duration: 4s
  - [x] 5.5 Implement `static void showInfo(BuildContext context, String message)`:
    - background: `context.colors.honey`, icon: `Icons.info`, duration: 3s
  - [x] 5.6 All variants use `SnackBarBehavior.floating`, `shape: RoundedRectangleBorder(borderRadius: AppSpacing.chipRadius)` (12px)
  - [x] 5.7 SnackBar content: `Row` → `Icon(color: Colors.white, size: 20)` + `SizedBox(width: AppSpacing.sm)` + `Expanded(child: Text(message, style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white)))`
  - [x] 5.8 Show via `ScaffoldMessenger.of(context).showSnackBar(snackBar)`
  - [x] 5.9 Add to `feedback.dart` barrel

- [x] Task 6: Update barrel exports (AC: #9)
  - [x] 6.1 Update `lib/src/components/feedback/feedback.dart` to export all 5 new files
  - [x] 6.2 Verify `lib/ui.dart` already exports `feedback/feedback.dart` — **NO changes to `ui.dart` needed**

- [x] Task 7: Write widget tests (AC: #8)
  - [x] 7.1 Create `test/widgets/status_badge_test.dart`:
    - All 4 variants render without error
    - Each variant shows its expected `Icon` widget (using `find.byIcon(Icons.check_circle)` etc.)
    - `HivesStatusVariant.healthy` → no error icon found for other variants
    - Renders in dark mode without error
  - [x] 7.2 Create `test/widgets/sync_status_indicator_test.dart`:
    - All 4 states render without error
    - Each state shows expected label text (`'Offline'`, `'Syncing...'`, `'Synced'`, `'Sync Error'`)
    - Renders in dark mode without error
  - [x] 7.3 Create `test/widgets/hives_loading_indicator_test.dart`:
    - Renders `CircularProgressIndicator`
    - With `size: 48.0`, renders within a `SizedBox` (verified via ancestor finder)
    - Renders in dark mode without error

- [x] Task 8: Verify full suite
  - [x] 8.1 Run `dart analyze` in `packages/ui` — zero errors or warnings (57 pre-existing info hints only)
  - [x] 8.2 Run `flutter test --no-pub` in `packages/ui` — all 137 tests pass (112 existing + 25 new)
  - [x] 8.3 Run `melos run analyze` from root — SUCCESS across all packages, no regressions

## Dev Notes

### CRITICAL: Package & Import Context

**Package:** `packages/ui` (Dart package name: `ui`)
**Consumer import:** `import 'package:ui/ui.dart';`
**Internal import:** `import 'package:ui/src/components/feedback/status_badge.dart';`
**NEVER use relative imports** — `always_use_package_imports` lint is enforced.
**ALWAYS single quotes** — `prefer_single_quotes` lint enforced.
**`const` everywhere** — `prefer_const_constructors` lint enforced (use `const` on constructors wherever possible).

### CRITICAL: Naming Conflict — Flutter's `HapticFeedback` vs Our Wrapper

Flutter already has a class named `HapticFeedback` in `package:flutter/services.dart`.
**Our wrapper MUST be named `HivesHaptics`** to avoid ambiguity and lint conflicts.
Never name it `HapticFeedback`, `HapticService`, or any alias of the Flutter class.

```dart
// hives_haptics.dart
import 'package:flutter/services.dart'; // ← services.dart, NOT material.dart

abstract final class HivesHaptics {
  static Future<void> lightImpact() => HapticFeedback.lightImpact();
  static Future<void> mediumImpact() => HapticFeedback.mediumImpact();
  static Future<void> heavyImpact() => HapticFeedback.heavyImpact();
}
```

### Existing Widgets — DO NOT RE-IMPLEMENT

| Widget | File | Status |
|--------|------|--------|
| `PrimaryButton` | `src/components/buttons/primary_button.dart` | ✅ Correct |
| `SecondaryButton` | `src/components/buttons/secondary_button.dart` | ✅ Fixed in 1.6 (buttonRadius + buttonHeight) |
| `HighlightButton` | `src/components/buttons/highlight_button.dart` | ✅ Correct |
| `PlainTextButton` | `src/components/buttons/text_button.dart` | ✅ Correct |
| `HivesCard` | `src/components/surfaces/hives_card.dart` | ✅ 24px radius (from SurfaceThemeTokens) |
| `HivesTextField` | `src/components/inputs/hives_text_field.dart` | ✅ Correct |
| `HivesChip` | `src/components/feedback/hives_chip.dart` | ✅ Correct |
| `HivesListTile` | `src/components/surfaces/hives_list_tile.dart` | ✅ New in 1.6 |
| `showHivesBottomSheet` | `src/components/surfaces/hives_bottom_sheet.dart` | ✅ New in 1.6 |

This story ADDS to `lib/src/components/feedback/`:
`status_badge.dart`, `hives_loading_indicator.dart`, `sync_status_indicator.dart`, `hives_haptics.dart`, `snack_bar_service.dart`

### Design Token References

**Status Colors (from `HivesColors` ThemeExtension — requires `BuildContext`):**

```dart
// Access via: context.colors.XXX  OR  Theme.of(context).hivesColors.XXX

context.colors.healthyStatus   // #22C55E  green — icon/text on fill
context.colors.healthyFill     // #DCFCE7  green light — badge background
context.colors.attentionStatus // #F59E0B  amber — icon/text on fill
context.colors.attentionFill   // #FEF3C7  amber light — badge background
context.colors.urgentStatus    // #EF4444  red — icon/text on fill
context.colors.urgentFill      // #FEE2E2  red light — badge background
context.colors.unknownStatus   // #94A3B8  slate — icon/text on fill
context.colors.unknownFill     // #F1F5F9  slate light — badge background
context.colors.honey           // #F59E0A  primary amber — loading indicator, info snackbar
```

**App Spacing (static constants — no `BuildContext`):**

```dart
AppSpacing.xs = 4.0     // icon-to-text gap in SyncStatusIndicator
AppSpacing.sm = 8.0     // icon-to-text gap in SnackBar content
AppSpacing.chipRadius   = BorderRadius.all(Radius.circular(12))  // SnackBar shape
```

**Context Extension (`context_extensions.dart`):**

```dart
context.colors      // → Theme.of(context).hivesColors  (HivesColors extension)
context.textTheme   // → Theme.of(context).textTheme
context.colorScheme // → Theme.of(context).colorScheme
```

### StatusBadge Implementation Reference

```dart
import 'package:flutter/material.dart';
import 'package:ui/src/extensions/context_extensions.dart';

enum HivesStatusVariant { healthy, attention, urgent, unknown }

class StatusBadge extends StatelessWidget {
  final HivesStatusVariant variant;
  final double size;

  const StatusBadge({
    super.key,
    required this.variant,
    this.size = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final (fillColor, iconColor, icon) = switch (variant) {
      HivesStatusVariant.healthy => (colors.healthyFill, colors.healthyStatus, Icons.check_circle),
      HivesStatusVariant.attention => (colors.attentionFill, colors.attentionStatus, Icons.warning),
      HivesStatusVariant.urgent => (colors.urgentFill, colors.urgentStatus, Icons.error),
      HivesStatusVariant.unknown => (colors.unknownFill, colors.unknownStatus, Icons.help_outline),
    };

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: fillColor,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: iconColor, size: size * 0.6),
    );
  }
}
```

**Note on Dart record destructuring:** The `switch` expression with record destructuring requires Dart 3.0+ (SDK `^3.10.3` in pubspec — ✅ supported). If unfamiliar, a traditional `switch` with local variables works identically.

### HivesLoadingIndicator Implementation Reference

```dart
import 'package:flutter/material.dart';
import 'package:ui/src/extensions/context_extensions.dart';

class HivesLoadingIndicator extends StatelessWidget {
  final double strokeWidth;
  final double? size;

  const HivesLoadingIndicator({
    super.key,
    this.strokeWidth = 3.0,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final indicator = CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(context.colors.honey),
      strokeWidth: strokeWidth,
    );

    if (size == null) return indicator;
    return SizedBox(width: size, height: size, child: indicator);
  }
}
```

### SyncStatusIndicator Implementation Reference

```dart
import 'package:flutter/material.dart';
import 'package:ui/src/extensions/context_extensions.dart';
import 'package:ui/src/theme/app_spacing.dart';

enum SyncState { offline, syncing, synced, error }

class SyncStatusIndicator extends StatelessWidget {
  final SyncState state;

  const SyncStatusIndicator({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final (icon, color, label) = switch (state) {
      SyncState.offline => (Icons.cloud_off, colors.unknownStatus, 'Offline'),
      SyncState.syncing => (Icons.sync, colors.honey, 'Syncing...'),
      SyncState.synced  => (Icons.cloud_done, colors.healthyStatus, 'Synced'),
      SyncState.error   => (Icons.sync_problem, colors.urgentStatus, 'Sync Error'),
    };

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: AppSpacing.xs),
        Text(
          label,
          style: context.textTheme.labelSmall?.copyWith(color: color),
        ),
      ],
    );
  }
}
```

### SnackBarService Implementation Reference

```dart
import 'package:flutter/material.dart';
import 'package:ui/src/extensions/context_extensions.dart';
import 'package:ui/src/theme/app_spacing.dart';

abstract final class SnackBarService {
  static void showSuccess(BuildContext context, String message) =>
      _show(context, message, context.colors.healthyStatus, Icons.check_circle, const Duration(seconds: 3));

  static void showError(BuildContext context, String message) =>
      _show(context, message, context.colors.urgentStatus, Icons.error, const Duration(seconds: 4));

  static void showInfo(BuildContext context, String message) =>
      _show(context, message, context.colors.honey, Icons.info, const Duration(seconds: 3));

  static void _show(
    BuildContext context,
    String message,
    Color backgroundColor,
    IconData icon,
    Duration duration,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                message,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(
          borderRadius: AppSpacing.chipRadius,
        ),
        duration: duration,
      ),
    );
  }
}
```

### Updated `feedback.dart` Barrel

```dart
library feedback;

export 'hives_chip.dart';
export 'hives_haptics.dart';
export 'hives_loading_indicator.dart';
export 'snack_bar_service.dart';
export 'status_badge.dart';
export 'sync_status_indicator.dart';
```

`lib/ui.dart` already exports `src/components/feedback/feedback.dart` — **no changes needed to `ui.dart`**.

### Testing Pattern

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/src/components/feedback/status_badge.dart';
import 'package:ui/src/theme/app_theme.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false); // ← REQUIRED — prevents network calls

  group('StatusBadge', () {
    Widget buildWidget(Widget child, {ThemeData? theme}) => MaterialApp(
      theme: theme ?? AppTheme.lightTheme,
      home: Scaffold(body: child),
    );

    testWidgets('healthy variant renders check_circle icon', (tester) async {
      await tester.pumpWidget(buildWidget(
        const StatusBadge(variant: HivesStatusVariant.healthy),
      ));
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    });

    testWidgets('attention variant renders warning icon', (tester) async {
      await tester.pumpWidget(buildWidget(
        const StatusBadge(variant: HivesStatusVariant.attention),
      ));
      expect(find.byIcon(Icons.warning), findsOneWidget);
    });

    testWidgets('renders in dark mode without error', (tester) async {
      await tester.pumpWidget(buildWidget(
        const StatusBadge(variant: HivesStatusVariant.healthy),
        theme: AppTheme.darkTheme,
      ));
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    });
  });
}
```

**Critical test setup reminders:**
- `setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false)` — **mandatory in every test file**
- Import theme from `package:ui/src/theme/app_theme.dart`
- Wrap all widgets in `MaterialApp(theme: AppTheme.lightTheme, home: Scaffold(...))`
- Use `package:` imports (never relative)

### Project Structure After Completion

```
packages/ui/
├── lib/
│   ├── ui.dart                           # UNCHANGED — already exports feedback/feedback.dart
│   └── src/
│       └── components/
│           └── feedback/
│               ├── feedback.dart         # UPDATED: 5 new exports added
│               ├── hives_chip.dart       # UNCHANGED
│               ├── status_badge.dart     # NEW (HivesStatusVariant enum + StatusBadge)
│               ├── hives_loading_indicator.dart  # NEW
│               ├── sync_status_indicator.dart    # NEW (SyncState enum + SyncStatusIndicator)
│               ├── hives_haptics.dart    # NEW (abstract final class)
│               └── snack_bar_service.dart        # NEW (abstract final class)
└── test/
    └── widgets/
        ├── hives_list_tile_test.dart     # EXISTING — do not touch
        ├── hives_bottom_sheet_test.dart  # EXISTING — do not touch
        ├── secondary_button_test.dart    # EXISTING — do not touch
        ├── status_badge_test.dart        # NEW
        ├── sync_status_indicator_test.dart  # NEW
        └── hives_loading_indicator_test.dart  # NEW
```

### Previous Story Learnings (Stories 1.1–1.6)

1. **Package imports only** — `import 'package:ui/src/...'` not `'../...'` (lint: `always_use_package_imports`)
2. **Single quotes** — all string literals (lint: `prefer_single_quotes`)
3. **`const` constructors** — wherever possible (lint: `prefer_const_constructors`)
4. **`flutter_test` SDK** — already in dev_dependencies; do NOT add `test` package separately
5. **`GoogleFonts.config.allowRuntimeFetching = false`** in `setUpAll` — prevents network calls in tests
6. **`dart analyze` before done** — zero errors/warnings required
7. **`melos run analyze`** from root — checks regressions across all packages
8. **No new dependencies needed** — this story uses only Flutter SDK + google_fonts (already present)
9. **`abstract final class`** pattern for static-only utilities (e.g., `AppSpacing`, `AppColors`) — matches existing pattern

### Downstream Impact

Stories in Epic 2–7 consume these widgets:
- `StatusBadge` → hive status display in Epic 4 (hive list, hive detail), Epic 5 (inspection results)
- `SyncStatusIndicator` → Epic 7 (dashboard sync status, story 7-6)
- `HivesLoadingIndicator` → all BLoC loading states across every feature screen
- `HivesHaptics` → button press feedback in Epic 4/5 forms, save confirmation
- `SnackBarService` → all save/delete/error feedback in Epics 3–6

Story 1.8 (Widgetbook Documentation) will document all widgets created here — correct implementation now prevents documentation corrections later.

### References

- [Source: epics.md#Story-1.7] — User story statement and acceptance criteria
- [Source: ux-design-specification.md#Status-Feedback] — Status colors, haptic feedback levels, snackbar behavior
- [Source: packages/ui/lib/src/theme/hives_colors.dart] — HivesColors extension with all status color properties
- [Source: packages/ui/lib/src/theme/app_spacing.dart] — AppSpacing constants (chipRadius, xs, sm)
- [Source: packages/ui/lib/src/extensions/context_extensions.dart] — context.colors, context.textTheme extensions
- [Source: packages/ui/lib/src/components/feedback/feedback.dart] — Barrel to update
- [Source: packages/ui/lib/ui.dart] — Root barrel (no changes needed)
- [Source: 1-6-core-ui-package-base-widgets.md#Dev-Notes] — Testing patterns, import rules, lint requirements

## Dev Agent Record

### Agent Model Used

claude-sonnet-4-6

### Debug Log References

- `alignment: Alignment.center` added to `StatusBadge` Container — without explicit alignment, `Icon` would be positioned top-left rather than centered within the circular badge.

### Completion Notes List

- All 8 tasks and all subtasks completed successfully.
- `StatusBadge` created with `HivesStatusVariant` enum (healthy/attention/urgent/unknown), circular Container with fill background and centered icon, both color AND icon for full accessibility compliance.
- `HivesLoadingIndicator` created with honey/amber brand color via `AlwaysStoppedAnimation`, optional `SizedBox` wrapper when `size` is provided.
- `SyncStatusIndicator` created with `SyncState` enum (offline/syncing/synced/error), Row layout with icon + text, all state colors sourced from `HivesColors`.
- `HivesHaptics` created as `abstract final class` wrapping Flutter's `HapticFeedback` from `services.dart` — named to avoid conflict with Flutter's own `HapticFeedback` class.
- `SnackBarService` created as `abstract final class` with shared `_show` private helper, floating snackbars with 12px rounded corners, white icon+text on status-colored background.
- `feedback.dart` barrel updated with 5 new exports — `ui.dart` unchanged.
- 25 new widget tests added across 3 test files; total suite grew from 112 → 137 tests, all passing.
- `dart analyze packages/ui` → 0 errors, 0 warnings (57 pre-existing info hints only).
- `melos run analyze` → SUCCESS across all packages, no regressions.

### Code Review Fixes (v1.1)

- **H1 Fixed**: Created `snack_bar_service_test.dart` — 8 tests covering all 3 variants, icons, durations, floating behavior, dismiss-on-new, dark mode.
- **H2 Fixed**: Added `semanticLabel` to `StatusBadge` Icon widget for all 4 variants (`'Healthy status'`, `'Needs attention'`, `'Urgent'`, `'Unknown status'`).
- **H3 Fixed**: Added `semanticsLabel: 'Loading'` to `CircularProgressIndicator` in `HivesLoadingIndicator`.
- **M1 Fixed**: Added `hideCurrentSnackBar()` cascade in `SnackBarService._show` to dismiss existing snackbar before showing new.
- **M2 Fixed**: Added 2 tests for `StatusBadge` size parameter (badge dimensions + icon scaling) and 1 test for semantic label.
- **M3 Fixed**: Added 2 tests for `HivesLoadingIndicator` (honey color verification + semantics label).
- Total test suite: 150 tests (137 → 150), all passing. `dart analyze` clean.

### File List

**New files:**
- `packages/ui/lib/src/components/feedback/status_badge.dart`
- `packages/ui/lib/src/components/feedback/hives_loading_indicator.dart`
- `packages/ui/lib/src/components/feedback/sync_status_indicator.dart`
- `packages/ui/lib/src/components/feedback/hives_haptics.dart`
- `packages/ui/lib/src/components/feedback/snack_bar_service.dart`
- `packages/ui/test/widgets/status_badge_test.dart`
- `packages/ui/test/widgets/sync_status_indicator_test.dart`
- `packages/ui/test/widgets/hives_loading_indicator_test.dart`
- `packages/ui/test/widgets/snack_bar_service_test.dart`

**Modified files:**
- `packages/ui/lib/src/components/feedback/feedback.dart` — added 5 new exports

### Change Log

| Date | Version | Description | Author |
|------|---------|-------------|--------|
| 2026-03-05 | 1.0 | Initial implementation: StatusBadge, HivesLoadingIndicator, SyncStatusIndicator, HivesHaptics, SnackBarService, widget tests | claude-sonnet-4-6 |
| 2026-03-05 | 1.1 | Code review fixes: added screen reader semantics to StatusBadge and HivesLoadingIndicator, added hideCurrentSnackBar to SnackBarService, added SnackBarService tests, added size/color verification tests | claude-opus-4-6 |
