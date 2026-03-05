# Story 1.6: Core UI Package - Base Widgets

Status: done

<!-- Note: Validation is optional. Run validate-create-story for quality check before dev-story. -->

## Story

As a developer,
I want foundational UI components in `packages/ui`,
So that feature screens have consistent, reusable building blocks that follow the Hives design system.

## Acceptance Criteria

1. **Given** design tokens exist from Story 1.5 **When** `HivesListTile` is implemented **Then** it provides a consistent list item layout with leading, title, subtitle, and trailing slots, minimum 48px touch target, using only AppSpacing/HivesColors tokens (no hardcoded px values)
2. **And** `HivesBottomSheet` is implemented as a `showHivesBottomSheet` utility function with 28px top corner radius, drag handle bar, and surface background
3. **And** `SecondaryButton` is updated to use `AppSpacing.buttonRadius` (16px) instead of hardcoded `14px`, and `AppSpacing.buttonHeight` (54px) instead of hardcoded `48px`
4. **And** all widgets use design tokens (`AppColors`, `AppSpacing`, `HivesColors`, `ButtonThemeTokens`, `InputThemeTokens`, `SurfaceThemeTokens`) — zero hardcoded px values
5. **And** all widgets support dark mode theming via `Theme.of(context)` — no widget-level dark mode branching needed
6. **And** widget tests in `test/widgets/` verify rendering, interaction states, and dark mode for new and fixed components
7. **And** all new files are exported through `lib/src/components/surfaces/surfaces.dart` barrel (already re-exported by `lib/ui.dart` — no change to `ui.dart` needed)

## Tasks / Subtasks

- [x] Task 1: Create `HivesListTile` widget (AC: #1, #4, #5)
  - [x] 1.1 Create `lib/src/components/surfaces/hives_list_tile.dart`
  - [x] 1.2 Implement `HivesListTile extends StatelessWidget` wrapping Flutter `ListTile`
  - [x] 1.3 Props: `title` (required `Widget`), `subtitle` (`Widget?`), `leading` (`Widget?`), `trailing` (`Widget?`), `onTap` (`VoidCallback?`), `isEnabled` (`bool`, default `true`), `showDivider` (`bool`, default `false`)
  - [x] 1.4 Use `contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin)` (20px)
  - [x] 1.5 When `showDivider = true`, wrap tile in `Column` with a `Divider(height: 1)` below
  - [x] 1.6 `isEnabled = false` → pass `null` for `onTap` and set `enabled: false` on `ListTile`

- [x] Task 2: Create `HivesBottomSheet` utility (AC: #2, #4, #5)
  - [x] 2.1 Create `lib/src/components/surfaces/hives_bottom_sheet.dart`
  - [x] 2.2 Implement `Future<T?> showHivesBottomSheet<T>({required BuildContext context, required WidgetBuilder builder, bool isScrollControlled = true, bool isDismissible = true})`
  - [x] 2.3 Use `showModalBottomSheet` with `shape: const RoundedRectangleBorder(borderRadius: AppSpacing.modalTopRadius)` (28px top radius)
  - [x] 2.4 `backgroundColor: Theme.of(context).colorScheme.surface`
  - [x] 2.5 Prepend drag handle: 4×40px `Container` with `borderRadius: BorderRadius.all(Radius.circular(2))`, `color: Theme.of(ctx).colorScheme.outlineVariant`, centered, with `AppSpacing.sm` padding above and below
  - [x] 2.6 `isScrollControlled: isScrollControlled` passed through

- [x] Task 3: Fix `SecondaryButton` hardcoded values (AC: #3, #4)
  - [x] 3.1 Edit `lib/src/components/buttons/secondary_button.dart`
  - [x] 3.2 Add import: `import 'package:ui/src/theme/app_spacing.dart';`
  - [x] 3.3 Replace `BorderRadius.circular(14)` → `AppSpacing.buttonRadius` (16px — button radius, NOT input radius!)
  - [x] 3.4 Replace `minimumSize: const Size(64, 48)` → `minimumSize: const Size(64, AppSpacing.buttonHeight)` (54px per UX spec)
  - [x] 3.5 Run `dart analyze` to confirm zero errors after fix

- [x] Task 4: Update barrel exports (AC: #7)
  - [x] 4.1 Add `hives_list_tile.dart` export to `lib/src/components/surfaces/surfaces.dart`
  - [x] 4.2 Add `hives_bottom_sheet.dart` export to `lib/src/components/surfaces/surfaces.dart`
  - [x] 4.3 Confirm `lib/ui.dart` already exports `src/components/surfaces/surfaces.dart` — NO changes to `ui.dart` needed

- [x] Task 5: Write widget tests (AC: #6)
  - [x] 5.1 Create `test/widgets/` directory
  - [x] 5.2 Create `test/widgets/hives_list_tile_test.dart`:
    - Renders title text
    - Renders subtitle when provided
    - Leading and trailing render when provided
    - `onTap` fires callback on tap
    - `isEnabled = false` → `onTap` is null (not called)
    - `showDivider = true` → `Divider` widget present
    - Dark mode renders without error
  - [x] 5.3 Create `test/widgets/hives_bottom_sheet_test.dart`:
    - `showHivesBottomSheet` displays provided builder content
    - Sheet contains drag handle widget
  - [x] 5.4 Create `test/widgets/secondary_button_test.dart`:
    - Renders label text
    - `onPressed` fires callback
    - `isEnabled = false` → button is disabled
    - `isLoading = true` → `onPressed` not called
    - Dark mode renders without error

- [x] Task 6: Verify full suite (AC: all)
  - [x] 6.1 Run `dart analyze` in `packages/ui` — zero errors or warnings
  - [x] 6.2 Run `flutter test --no-pub` in `packages/ui` — all tests pass (112 total)
  - [x] 6.3 Run `melos run analyze` from root — SUCCESS across all 12 packages, no regressions

## Dev Notes

### CRITICAL: Package & Import Context

**Package:** `packages/ui` (Dart package name: `ui`)
**Consumer import:** `import 'package:ui/ui.dart';`
**Internal import:** `import 'package:ui/src/components/surfaces/hives_list_tile.dart';`
**NEVER use relative imports** — `always_use_package_imports` lint is enforced.
**ALWAYS single quotes** — `prefer_single_quotes` lint enforced.
**`const` everywhere** — `prefer_const_constructors` lint enforced.

### Existing Widgets — DO NOT RE-IMPLEMENT

| Widget | File | Status |
|--------|------|--------|
| `PrimaryButton` | `src/components/buttons/primary_button.dart` | ✅ Correct |
| `SecondaryButton` | `src/components/buttons/secondary_button.dart` | ⚠️ Fix hardcoded values (Task 3) |
| `HighlightButton` | `src/components/buttons/highlight_button.dart` | ✅ Correct |
| `PlainTextButton` | `src/components/buttons/text_button.dart` | ✅ Correct |
| `HivesCard` | `src/components/surfaces/hives_card.dart` | ✅ Correct (24px radius) |
| `HivesTextField` | `src/components/inputs/hives_text_field.dart` | ✅ Correct |
| `HivesChip` | `src/components/feedback/hives_chip.dart` | ✅ Correct |
| `HivesText*` | `src/components/typography/hives_text.dart` | ✅ Correct (full M3 type scale) |

This story creates `HivesListTile` and `HivesBottomSheet` (both NEW), and fixes `SecondaryButton`.

### SecondaryButton Fix — What's Wrong and Why

```dart
// CURRENT (WRONG) — lib/src/components/buttons/secondary_button.dart line 57-65:
final baseStyle = OutlinedButton.styleFrom(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), // BUG: 14px = input radius
  side: BorderSide(color: ..., width: 2),
  minimumSize: const Size(64, 48), // BUG: 48px = touch target min, not button height
);

// CORRECT — after Task 3:
import 'package:ui/src/theme/app_spacing.dart';

final baseStyle = OutlinedButton.styleFrom(
  shape: RoundedRectangleBorder(borderRadius: AppSpacing.buttonRadius), // 16px — buttons use buttonRadius
  side: BorderSide(color: ..., width: 2),
  minimumSize: const Size(64, AppSpacing.buttonHeight), // 54px — UX spec for all buttons
);
```

**Why 16px, not 14px?** UX spec: "Buttons | 16px | Rounded pill-like, friendly feel". `AppSpacing.inputRadius` (14px) is for text fields only. `AppSpacing.buttonRadius` (16px) is for all button types.
**Why 54px, not 48px?** UX spec: "Buttons: 54px height (comfortable for gloved hands)". `AppSpacing.touchTargetMin` (48px) is the minimum touch target for any interactive element. `AppSpacing.buttonHeight` (54px) is specifically for buttons. All 4 button variants should be 54px.

### AppSpacing Token Reference (from lib/src/theme/app_spacing.dart)

```dart
// Base scale
AppSpacing.xs = 4.0     AppSpacing.sm = 8.0     AppSpacing.md = 12.0
AppSpacing.lg = 16.0    AppSpacing.xl = 20.0    AppSpacing.xxl = 24.0
AppSpacing.xxxl = 32.0

// Semantic aliases
AppSpacing.touchTargetMin = 48.0   // minimum touch target (not button height)
AppSpacing.buttonHeight = 54.0     // all button variants
AppSpacing.cardPadding = 20.0
AppSpacing.screenMargin = 20.0     // use for HivesListTile contentPadding
AppSpacing.sectionGap = 28.0
AppSpacing.fabDiameter = 64.0

// Shape constants (all BorderRadius, all const)
AppSpacing.buttonRadius   = BorderRadius.all(Radius.circular(16))  // buttons
AppSpacing.cardRadius     = BorderRadius.all(Radius.circular(24))  // cards
AppSpacing.chipRadius     = BorderRadius.all(Radius.circular(12))  // chips
AppSpacing.inputRadius    = BorderRadius.all(Radius.circular(14))  // text inputs
AppSpacing.modalTopRadius = BorderRadius.vertical(top: Radius.circular(28))  // bottom sheets
```

### HivesColors Token Reference (ThemeExtension — needs BuildContext)

```dart
// Access: context.colors or Theme.of(context).hivesColors
// (via HivesColorsExtension on ThemeData in lib/src/theme/hives_colors.dart)
colors.honey            // #F59E0A primary amber
colors.secondary        // #8B5CF6 purple
colors.healthyStatus    // #22C55E green
colors.healthyFill      // #DCFCE7
colors.attentionStatus  // #F59E0B amber
colors.attentionFill    // #FEF3C7
colors.urgentStatus     // #EF4444 red
colors.urgentFill       // #FEE2E2
colors.unknownStatus    // #94A3B8 slate
colors.unknownFill      // #F1F5F9
colors.outline          // #E7E5E4
```

### HivesListTile Implementation Reference

```dart
import 'package:flutter/material.dart';
import 'package:ui/src/theme/app_spacing.dart';

/// A themed list tile following the Hives design system.
///
/// Wraps Flutter [ListTile] with consistent padding and design token usage.
/// Use [showDivider] for items in a list to add a bottom separator.
class HivesListTile extends StatelessWidget {
  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool isEnabled;
  final bool showDivider;

  const HivesListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.isEnabled = true,
    this.showDivider = false,
  });

  @override
  Widget build(BuildContext context) {
    final tile = ListTile(
      title: title,
      subtitle: subtitle,
      leading: leading,
      trailing: trailing,
      onTap: isEnabled ? onTap : null,
      enabled: isEnabled,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenMargin,
      ),
    );

    if (!showDivider) return tile;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [tile, const Divider(height: 1)],
    );
  }
}
```

### HivesBottomSheet Implementation Reference

```dart
import 'package:flutter/material.dart';
import 'package:ui/src/theme/app_spacing.dart';

/// Shows a themed modal bottom sheet with Hives design language.
///
/// Uses [AppSpacing.modalTopRadius] (28px top corners) and includes
/// a drag handle bar. Returns Future<T?> from the modal.
///
/// Usage:
/// ```dart
/// final result = await showHivesBottomSheet<String>(
///   context: context,
///   builder: (ctx) => const YourContent(),
/// );
/// ```
Future<T?> showHivesBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool isScrollControlled = true,
  bool isDismissible = true,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: isScrollControlled,
    isDismissible: isDismissible,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: AppSpacing.modalTopRadius,
    ),
    builder: (ctx) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: AppSpacing.sm),
        Center(
          child: Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Theme.of(ctx).colorScheme.outlineVariant,
              borderRadius: const BorderRadius.all(Radius.circular(2)),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        builder(ctx),
      ],
    ),
  );
}
```

**IMPORTANT:** `showHivesBottomSheet` is a top-level function, not a class. Export it from `surfaces.dart` like any other symbol.

### Testing Pattern

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui/src/theme/app_theme.dart';
import 'package:ui/src/components/surfaces/hives_list_tile.dart';

void main() {
  group('HivesListTile', () {
    Widget buildWidget(Widget child, {ThemeData? theme}) => MaterialApp(
      theme: theme ?? AppTheme.lightTheme,
      home: Scaffold(body: child),
    );

    testWidgets('renders title', (tester) async {
      await tester.pumpWidget(buildWidget(
        const HivesListTile(title: Text('Hello')),
      ));
      expect(find.text('Hello'), findsOneWidget);
    });

    testWidgets('fires onTap', (tester) async {
      var tapped = false;
      await tester.pumpWidget(buildWidget(
        HivesListTile(title: const Text('T'), onTap: () => tapped = true),
      ));
      await tester.tap(find.byType(ListTile));
      expect(tapped, isTrue);
    });

    testWidgets('disabled ignores tap', (tester) async {
      var tapped = false;
      await tester.pumpWidget(buildWidget(
        HivesListTile(
          title: const Text('T'),
          onTap: () => tapped = true,
          isEnabled: false,
        ),
      ));
      await tester.tap(find.byType(ListTile));
      expect(tapped, isFalse);
    });

    testWidgets('renders in dark mode', (tester) async {
      await tester.pumpWidget(buildWidget(
        const HivesListTile(title: Text('Dark')),
        theme: AppTheme.darkTheme,
      ));
      expect(find.text('Dark'), findsOneWidget);
    });
  });
}
```

**Note on `google_fonts` in tests:** The existing test suite uses `GoogleFonts.config.allowRuntimeFetching = false` in `setUpAll`. Do the same in any new test file to prevent network calls and font-loading errors.

```dart
import 'package:google_fonts/google_fonts.dart';
setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);
```

### Project Structure After Completion

```
packages/ui/
├── lib/
│   ├── ui.dart                           # UNCHANGED — already exports surfaces.dart
│   └── src/
│       ├── components/
│       │   ├── buttons/
│       │   │   ├── secondary_button.dart # UPDATED: AppSpacing.buttonRadius + AppSpacing.buttonHeight
│       │   │   └── ... (unchanged)
│       │   └── surfaces/
│       │       ├── hives_card.dart       # UNCHANGED
│       │       ├── hives_list_tile.dart  # NEW
│       │       ├── hives_bottom_sheet.dart  # NEW
│       │       └── surfaces.dart         # UPDATED: 2 new exports
│       └── ... (all other files unchanged)
└── test/
    ├── theme/                            # EXISTING (from Story 1.5) — do not touch
    └── widgets/                          # NEW directory
        ├── hives_list_tile_test.dart
        ├── hives_bottom_sheet_test.dart
        └── secondary_button_test.dart
```

### HivesCard Note — Epics vs Actual

The epics file states "HivesCard... 12px radius" — **this is the old spec**. Story 1.5 already updated `HivesCard` to use `SurfaceThemeTokens.cardBorderRadius = 24.0` per UX spec. The card is correct at 24px. **Do not change it.**

### Downstream Impact

Stories 1.7 (status/feedback widgets) and 1.9 (app shell navigation) consume:
- `HivesListTile` → hive list views, task lists, settings screens
- `HivesBottomSheet` → inspection flow details, confirmation dialogs, filter panels
- All button variants → all feature screens
- `HivesCard` → hive cards, task cards, dashboard hero

Story 1.7 adds `StatusBadge`, `HivesLoadingIndicator`, `SyncStatusIndicator` on top of this foundation.

### Previous Story Learnings (Stories 1.1–1.5)

1. **Package imports only** — `import 'package:ui/src/...'` not `'../...'`
2. **Single quotes** — all string literals
3. **`const` constructors** — wherever possible
4. **`flutter_test` SDK** — already in dev_dependencies; do NOT add `test` package separately
5. **`GoogleFonts.config.allowRuntimeFetching = false`** in `setUpAll` — prevents network calls in tests
6. **`dart analyze` before done** — zero errors/warnings required
7. **`melos run analyze`** from root — checks regressions across all packages
8. **No new dependencies needed** — this story uses only Flutter SDK + google_fonts (already present)

### References

- [Source: epics.md#Story-1.6] — User story statement and AC
- [Source: ux-design-specification.md#Component-Shape-Language] — Modal Sheets 28px, Buttons 16px radius
- [Source: ux-design-specification.md#Button-Variants] — All buttons 54px height, 16px radius
- [Source: packages/ui/lib/src/theme/app_spacing.dart] — AppSpacing constants
- [Source: packages/ui/lib/src/theme/hives_colors.dart] — HivesColors ThemeExtension
- [Source: packages/ui/lib/src/components/buttons/secondary_button.dart] — Contains the bug to fix (lines 57–65)
- [Source: packages/ui/lib/src/components/surfaces/surfaces.dart] — Barrel to update
- [Source: 1-5-core-ui-package-design-tokens.md#Dev-Notes] — Previous story patterns and learnings

## Dev Agent Record

### Agent Model Used

claude-sonnet-4-6

### Debug Log References

- Fixed unused import warning in `hives_bottom_sheet_test.dart`: removed `package:ui/src/theme/app_spacing.dart` import that was added for reference but not used in assertions.
- Fixed unused local variable warning in `hives_bottom_sheet_test.dart`: removed `handle` variable from the drag-handle test; kept only `decoratedContainers.isNotEmpty` assertion.

### Completion Notes List

- All 6 tasks completed successfully.
- `HivesListTile` created as `StatelessWidget` wrapping Flutter `ListTile` with `AppSpacing.screenMargin` (20px) horizontal padding, divider support, and enabled/disabled state.
- `showHivesBottomSheet<T>` created as a top-level generic function (not a class) using `showModalBottomSheet` with 28px top radius (`AppSpacing.modalTopRadius`), drag handle (4×40px), and surface background color.
- `SecondaryButton` bug fixed: replaced hardcoded `BorderRadius.circular(14)` with `AppSpacing.buttonRadius` (16px) and `minimumSize` height `48` with `AppSpacing.buttonHeight` (54px).
- Barrel `surfaces.dart` updated with two new exports.
- 20 new widget tests added across 3 test files (all passing); total suite grew from 84 → 112 tests.
- `dart analyze packages/ui` → 0 errors, 0 warnings (only pre-existing info hints).
- `melos run analyze` from root → SUCCESS across all 12 packages, no regressions.

### File List

**New files:**
- `packages/ui/lib/src/components/surfaces/hives_list_tile.dart`
- `packages/ui/lib/src/components/surfaces/hives_bottom_sheet.dart`
- `packages/ui/test/widgets/hives_list_tile_test.dart`
- `packages/ui/test/widgets/hives_bottom_sheet_test.dart`
- `packages/ui/test/widgets/secondary_button_test.dart`

**Modified files:**
- `packages/ui/lib/src/components/buttons/secondary_button.dart` — fixed buttonRadius and buttonHeight
- `packages/ui/lib/src/components/surfaces/surfaces.dart` — added 2 exports
- `packages/ui/lib/src/theme/app_spacing.dart` — added dragHandleWidth, dragHandleHeight, dragHandleRadius, dividerSpace constants (code review fix)
- `packages/ui/test/widgets/hives_bottom_sheet_test.dart` — strengthened shape and drag handle assertions (code review fix)

### Change Log

| Date | Version | Description | Author |
|------|---------|-------------|--------|
| 2026-03-05 | 1.0 | Initial implementation: HivesListTile, showHivesBottomSheet, SecondaryButton fix, widget tests | claude-sonnet-4-6 |
| 2026-03-05 | 1.1 | Code review fixes: tokenise drag handle dimensions/radius, divider height; add enableDrag param; strengthen shape and handle tests | claude-sonnet-4-6 |
