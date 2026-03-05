# Story 1.5: Core UI Package - Design Tokens

Status: done

<!-- Note: Validation is optional. Run validate-create-story for quality check before dev-story. -->

## Story

As a developer,
I want design tokens matching the UX specification,
So that the app has a consistent visual language.

## Acceptance Criteria

1. **Given** the `packages/ui` package exists **When** design tokens are implemented **Then** `AppColors` class defines the brand palette with Primary Amber `#F59E0A`, Background `#FAFAF8`, and all color constants from the UX spec
2. **And** `AppColors` defines status colors: Healthy Green `#22C55E` + fill `#DCFCE7`, Attention Amber `#F59E0B` + fill `#FEF3C7`, Urgent Red `#EF4444` + fill `#FEE2E2`, Unknown Slate `#94A3B8` + fill `#F1F5F9`
3. **And** `AppTypography` defines text styles using Poppins font (from `google_fonts`) with 16px base size for field readability
4. **And** `AppSpacing` defines base 4px unit with standard named constants: `xs=4`, `sm=8`, `md=12`, `lg=16`, `xl=20`, `xxl=24`, `xxxl=32`
5. **And** existing `HivesColors` ThemeExtension is updated to use UX spec colors (aligning `honey` to `#F59E0A`, secondary to purple `#8B5CF6`, status color fields added)
6. **And** `AppTheme` is updated: `useMaterial3: true`, Poppins applied via `GoogleFonts.poppinsTextTheme()`, ColorScheme updated to UX spec palette, component themes updated (cards 24px radius, buttons 54px height, inputs 14px radius)
7. **And** `context_extensions.dart` provides `BuildContext` extension getters (`context.colors`, `context.spacings`, `context.textTheme`)
8. **And** all touch targets retain 48px minimum height (glove-friendly — existing constraint kept)
9. **And** barrel export `lib/ui.dart` exports all new token files
10. **And** unit/widget tests cover all token classes and confirm `AppTheme` builds without error

## Tasks / Subtasks

- [x] Task 1: Add dependencies to pubspec.yaml (AC: #3)
  - [x] 1.1 Add `google_fonts: ^6.2.1` to dependencies (check pub.dev at implementation time — latest known 6.x; latest overall is 8.x but verify Flutter SDK compat)
  - [x] 1.2 Run `melos bootstrap` (or `dart pub get` in `packages/ui`) to resolve
  - [x] 1.3 Verify analysis is clean after dependency addition

- [x] Task 2: Create `AppColors` static constants class (AC: #1, #2)
  - [x] 2.1 Create `lib/src/theme/app_colors.dart`
  - [x] 2.2 Implement `abstract final class AppColors` (or class with private constructor) with `static const Color` fields
  - [x] 2.3 Add brand palette: `primary #F59E0A`, `primaryDark #D97706`, `primaryLight #FEF3C7`, `secondary #8B5CF6`, `secondaryLight #EDE9FE`, `background #FAFAF8`, `surface #FFFFFF`, `onSurface #1C1917`, `onSurfaceVariant #A8A29E`, `outline #E7E5E4`
  - [x] 2.4 Add status colors: `healthyStatus #22C55E`, `healthyFill #DCFCE7`, `attentionStatus #F59E0B`, `attentionFill #FEF3C7`, `urgentStatus #EF4444`, `urgentFill #FEE2E2`, `unknownStatus #94A3B8`, `unknownFill #F1F5F9`
  - [x] 2.5 Add accent palette: `teal #14B8A6`, `tealLight #CCFBF1`, `blue #3B82F6`, `blueLight #DBEAFE`, `orange #F97316`, `orangeLight #FED7AA`

- [x] Task 3: Create `AppTypography` static class (AC: #3)
  - [x] 3.1 Create `lib/src/theme/app_typography.dart`
  - [x] 3.2 Import `google_fonts` package
  - [x] 3.3 Implement `abstract final class AppTypography` with static `TextStyle` getters using `GoogleFonts.poppins(...)`
  - [x] 3.4 Add styles matching UX spec type scale:
    - `display`: 32px, Bold, letterSpacing -0.5
    - `titleLarge`: 22px, SemiBold (w600), letterSpacing 0
    - `titleMedium`: 18px, SemiBold (w600), letterSpacing 0
    - `bodyLarge`: 16px, Medium (w500), letterSpacing 0
    - `bodyMedium`: 15px, Regular (w400), letterSpacing 0
    - `label`: 13px, SemiBold (w600), letterSpacing +0.3
    - `caption`: 12px, Medium (w500), letterSpacing +0.2
  - [x] 3.5 Add static method `textTheme()` returning a full Flutter `TextTheme` built with `GoogleFonts.poppinsTextTheme()` for direct use in `ThemeData`

- [x] Task 4: Create `AppSpacing` static constants class (AC: #4)
  - [x] 4.1 Create `lib/src/theme/app_spacing.dart`
  - [x] 4.2 Implement `abstract final class AppSpacing` with static `const double` fields: `xs=4`, `sm=8`, `md=12`, `lg=16`, `xl=20`, `xxl=24`, `xxxl=32`
  - [x] 4.3 Add named semantic aliases: `cardPadding=20.0`, `sectionGap=28.0`, `screenMargin=20.0`, `touchTargetMin=48.0`, `buttonHeight=54.0`, `fabDiameter=64.0`
  - [x] 4.4 Add static `BorderRadius` constants: `buttonRadius = BorderRadius.circular(16)`, `cardRadius = BorderRadius.circular(24)`, `chipRadius = BorderRadius.circular(12)`, `inputRadius = BorderRadius.circular(14)`, `modalTopRadius = BorderRadius.vertical(top: Radius.circular(28))`

- [x] Task 5: Update `HivesColors` ThemeExtension to UX spec colors (AC: #5)
  - [x] 5.1 Edit `lib/src/theme/hives_colors.dart`
  - [x] 5.2 Update `HivesColors.light` static const to use `AppColors` values: `honey = AppColors.primary`, `honeyLight = AppColors.primaryLight`, `honeyDark = AppColors.primaryDark`
  - [x] 5.3 Update secondary colors to purple: rename concept or update values to `#8B5CF6` / `#EDE9FE`
  - [x] 5.4 Update nature/green colors to match UX vibrant greens: `#22C55E` / `#DCFCE7`
  - [x] 5.5 Update surface colors: `surface = AppColors.surface`, `outline = AppColors.outline`
  - [x] 5.6 Add status color fields to `HivesColors`: `healthyStatus`, `healthyFill`, `attentionStatus`, `attentionFill`, `urgentStatus`, `urgentFill`, `unknownStatus`, `unknownFill`
  - [x] 5.7 Update `HivesColors.dark` with appropriate dark-mode variants
  - [x] 5.8 Update `copyWith()` and `lerp()` for any new fields

- [x] Task 6: Update `AppTheme` with Poppins + UX spec component themes (AC: #6, #8)
  - [x] 6.1 Edit `lib/src/theme/app_theme.dart`
  - [x] 6.2 Import `google_fonts/google_fonts.dart`
  - [x] 6.3 Update `_lightColorScheme`: `primary = AppColors.primary`, `onPrimary = Colors.white`, `primaryContainer = AppColors.primaryLight`, `secondary = AppColors.secondary`, `surface = AppColors.surface`, `background = AppColors.background`, `error = AppColors.urgentStatus`
  - [x] 6.4 Apply Poppins: replace `textTheme: _textTheme` with `textTheme: AppTypography.textTheme()` (use `GoogleFonts.poppinsTextTheme()`)
  - [x] 6.5 Update card theme: `cardBorderRadius = 24.0` (was 12) to match UX spec
  - [x] 6.6 Update button min height: `minimumSize = Size(64, 54)` (was 48) per UX spec 54px button height; keep 48px as global minimum touch target via separate `minimumTouchTarget` constraint
  - [x] 6.7 Update button border radius to `16px` (was 12): `borderRadius: AppSpacing.buttonRadius`
  - [x] 6.8 Update input border radius to `14px` (was 12): `borderRadius: BorderRadius.circular(14)`
  - [x] 6.9 Update chip theme shape to `12px` radius: `BorderRadius.circular(12)`
  - [x] 6.10 Ensure `SurfaceThemeTokens.standard()` factory is updated to reflect `cardBorderRadius = 24.0`

- [x] Task 7: Create `context_extensions.dart` (AC: #7)
  - [x] 7.1 Create `lib/src/extensions/context_extensions.dart`
  - [x] 7.2 Add `BuildContext` extension providing:
    - `context.colors` → `HivesColors` (via `Theme.of(context).hivesColors`)
    - `context.spacings` → `HivesSpacings` (via `Theme.of(context).spacings`)
    - `context.appColors` → returns `HivesColors` (alias for convenience)
    - `context.colorScheme` → `Theme.of(context).colorScheme`
    - `context.textTheme` → `Theme.of(context).textTheme`
    - `context.theme` → `Theme.of(context)`

- [x] Task 8: Update barrel export (AC: #9)
  - [x] 8.1 Edit `lib/ui.dart`
  - [x] 8.2 Export `app_colors.dart`, `app_typography.dart`, `app_spacing.dart`
  - [x] 8.3 Export `context_extensions.dart`
  - [x] 8.4 Verify all existing exports still present

- [x] Task 9: Write tests (AC: #10)
  - [x] 9.1 Create `test/` directory (does not currently exist)
  - [x] 9.2 Create `test/theme/app_colors_test.dart` — verify all static const colors have correct hex values
  - [x] 9.3 Create `test/theme/app_spacing_test.dart` — verify all spacing constants match spec (xs=4, sm=8, etc.) and BorderRadius values
  - [x] 9.4 Create `test/theme/app_typography_test.dart` — verify `AppTypography.textTheme()` returns non-null TextTheme with Poppins styles
  - [x] 9.5 Create `test/theme/app_theme_test.dart` — widget test that creates `MaterialApp` with `AppTheme.lightTheme` and verifies it renders without error; checks `useMaterial3 == true`, `colorScheme.primary == AppColors.primary`
  - [x] 9.6 Create `test/theme/hives_colors_test.dart` — verify `HivesColors.light` status colors match `AppColors` status values

- [x] Task 10: Verify full suite passes (AC: all)
  - [x] 10.1 Run `dart analyze` in `packages/ui` — fix all errors and warnings
  - [x] 10.2 Run `flutter test --no-pub` in `packages/ui` — all tests pass
  - [x] 10.3 Run `melos run analyze` from root — no regressions in other packages

## Dev Notes

### CRITICAL: Existing Project State

**`packages/ui` is the design system package** — the workspace pubspec.yaml maps `packages/ui` as `# core_ui equivalent - design system`. The architecture doc refers to `core_ui` but **the actual package is `packages/ui` with Dart package name `ui`**. Import as `import 'package:ui/ui.dart'`.

**This story ENHANCES an existing package.** `packages/ui` already has substantial code:

```
packages/ui/
├── pubspec.yaml                   # Flutter SDK only; needs google_fonts added
├── lib/
│   ├── ui.dart                    # Barrel export (exists, needs new exports)
│   └── src/
│       ├── theme/
│       │   ├── app_theme.dart     # EXISTS: AppTheme with light/dark ThemeData, M3
│       │   ├── hives_colors.dart  # EXISTS: HivesColors ThemeExtension (WRONG COLORS)
│       │   ├── hives_spacings.dart# EXISTS: HivesSpacings ThemeExtension (8px grid OK)
│       │   ├── button_theme.dart  # EXISTS: ButtonThemeTokens ThemeExtension
│       │   ├── input_theme.dart   # EXISTS: InputThemeTokens ThemeExtension
│       │   └── surface_theme.dart # EXISTS: SurfaceThemeTokens ThemeExtension
│       ├── components/            # EXISTS: widgets (buttons, inputs, cards, etc.)
│       └── extensions/            # MISSING: create context_extensions.dart here
└── test/                          # MISSING: create test directory
```

**CRITICAL INSIGHT — What already exists vs. what to ADD:**

| Requirement | Existing | Action |
|-------------|---------|--------|
| `AppColors` static class | ❌ Missing | CREATE `app_colors.dart` |
| `AppTypography` static class | ❌ Missing | CREATE `app_typography.dart` |
| `AppSpacing` static class | ❌ Missing | CREATE `app_spacing.dart` |
| `HivesColors` ThemeExtension | ✅ Exists (wrong colors) | UPDATE colors to UX spec |
| `HivesSpacings` ThemeExtension | ✅ Exists (4-32 scale OK) | Keep, no changes needed |
| `AppTheme` | ✅ Exists (wrong colors, no Poppins) | UPDATE |
| `ButtonThemeTokens` | ✅ Exists | Update `minHeight` to 54 |
| `SurfaceThemeTokens` | ✅ Exists | Update `cardBorderRadius` to 24 |
| Context extensions | ❌ Missing | CREATE `context_extensions.dart` |

**DO NOT re-implement or duplicate:** `HivesSpacings`, `ButtonThemeTokens`, `InputThemeTokens`, `SurfaceThemeTokens`, button widgets, `HivesCard`, `HivesTextField`. Extend existing code only.

### Architecture Patterns (MUST FOLLOW)

**Import style:** `import 'package:ui/src/theme/app_colors.dart';` (package: prefix, no relative imports) — enforced by `always_use_package_imports` lint.

**Single quotes** required for all strings (enforce by `prefer_single_quotes` lint).

**ThemeExtension pattern** (used by `HivesColors`, `HivesSpacings`): classes extend `ThemeExtension<T>`, registered in `ThemeData.extensions`. This is the mechanism for accessing custom tokens in the widget tree via `Theme.of(context).extension<HivesColors>()`. The existing `HivesColors` extension is already consumed by `HivesCard` and other widgets — do not break this pattern.

**Static constants vs ThemeExtension:** The new `AppColors`, `AppTypography`, `AppSpacing` are **static constant classes** (not ThemeExtensions). They serve as the source of truth that `HivesColors` ThemeExtension references. This two-layer design means:
- `AppColors.primary` = raw const `Color(0xFFF59E0A)` — no BuildContext needed
- `HivesColors.light.honey` = uses `AppColors.primary` — accessible via ThemeExtension

### Color Changes — What's Changing

**Existing `HivesColors.light` colors vs UX Spec (what to update):**

| Field | Current Value | UX Spec Value | Notes |
|-------|---------------|---------------|-------|
| `honey` (primary) | `#FFC107` | `#F59E0A` | Slightly more orange-tinted amber |
| `honeyLight` | `#FFECB3` | `#FEF3C7` | Lighter warm cream |
| `honeyDark` | `#FFB300` | `#D97706` | Deeper amber |
| `hiveWood` (secondary) | `#795548` (brown) | `#8B5CF6` (purple) | **Concept change: secondary is now purple** |
| `nature` (status healthy) | `#8BC34A` | `#22C55E` | Vibrant green per UX spec |
| `natureLightShade` | `#C5E1A5` | `#DCFCE7` | Green fill background |
| `surface` | `#FFFBFF` | `#FFFFFF` | |

**New ColorScheme values for `_lightColorScheme`:**
```dart
primary: const Color(0xFFF59E0A),     // AppColors.primary
onPrimary: Colors.white,
primaryContainer: const Color(0xFFFEF3C7),
secondary: const Color(0xFF8B5CF6),   // Purple per UX spec
onSecondary: Colors.white,
secondaryContainer: const Color(0xFFEDE9FE),
surface: Colors.white,
error: const Color(0xFFEF4444),       // AppColors.urgentStatus
```

**Note on Epics vs UX Spec discrepancy:** The epics file states status colors as `Green #16A34A`, `Red #DC2626` — these are the older Material 3 tonal values. The UX design specification (refreshed 2026-03) specifies `#22C55E` (Tailwind green-500) and `#EF4444` (Tailwind red-500) for a bolder, more vibrant aesthetic. **Use UX spec values.** Similarly, epics states background `#FFFBEB` but UX spec says `#FAFAF8` — use `#FAFAF8`.

### AppTypography with Poppins — Implementation Pattern

```dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppTypography {
  // Static styles for direct use (no BuildContext)
  static TextStyle get display => GoogleFonts.poppins(
    fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: -0.5,
  );
  static TextStyle get titleLarge => GoogleFonts.poppins(
    fontSize: 22, fontWeight: FontWeight.w600,
  );
  // ... etc.

  // Full TextTheme for ThemeData integration
  static TextTheme textTheme() => GoogleFonts.poppinsTextTheme(
    const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      bodyMedium: TextStyle(fontSize: 15),
      labelLarge: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
    ),
  );
}
```

**IMPORTANT:** `GoogleFonts.poppinsTextTheme(base)` applies Poppins to all text roles in the base TextTheme. The `textTheme()` method is what gets passed to `ThemeData(textTheme: AppTypography.textTheme())`.

### AppTheme Update Pattern

The existing `AppTheme._textTheme` static const will be replaced by `AppTypography.textTheme()` (dynamic, not const, because GoogleFonts creates instances). The `AppTheme` class uses `static ThemeData get lightTheme` and `darkTheme` getters — this is fine because getters (not constants) can compute at call time.

```dart
// In AppTheme.lightTheme getter:
return ThemeData(
  useMaterial3: true,
  colorScheme: _lightColorScheme,  // Updated colors
  textTheme: AppTypography.textTheme(),  // Replaces _textTheme const
  // Component themes updated...
  cardTheme: CardThemeData(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: AppSpacing.cardRadius,  // 24px, was 12px
    ),
    color: Colors.white,
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      minimumSize: const Size(64, 54),  // 54px height, was 48px
      shape: RoundedRectangleBorder(borderRadius: AppSpacing.buttonRadius),  // 16px
    ),
  ),
  // ... etc.
);
```

### Existing Widget Compatibility

Existing widgets (`HivesCard`, `PrimaryButton`, `HivesTextField`) use:
- `theme.extension<SurfaceThemeTokens>()` — update `SurfaceThemeTokens.standard()` factory to `cardBorderRadius: 24.0`
- `theme.extension<ButtonThemeTokens>()` — update `ButtonThemeTokens.standard()` factory to `minHeight: 54.0, borderRadius: 16.0`
- `theme.colorScheme.onPrimary` — this will now be `Colors.white` (correct for amber primary)

**PrimaryButton already uses `FilledButton`** — the ThemeData update will propagate automatically. No widget code changes needed for basic color/size updates.

### Testing Approach

**No tests currently exist** — `packages/ui` has no `test/` directory. Create all test infrastructure from scratch.

Use `flutter_test` (already in pubspec.yaml). No need to add `test` package — `flutter_test` is sufficient.

For `AppTheme` widget tests, use `testWidgets` with `MaterialApp`:
```dart
testWidgets('AppTheme.lightTheme renders without error', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.lightTheme,
      home: const Scaffold(body: Text('test')),
    ),
  );
  expect(find.text('test'), findsOneWidget);
  // Verify Material 3 and primary color
  final theme = Theme.of(tester.element(find.text('test')));
  expect(theme.useMaterial3, isTrue);
  expect(theme.colorScheme.primary, AppColors.primary);
});
```

### File Structure After Completion

```
packages/ui/
├── pubspec.yaml                   # + google_fonts
├── lib/
│   ├── ui.dart                    # Updated: + new exports
│   └── src/
│       ├── theme/
│       │   ├── app_colors.dart    # NEW: AppColors static class
│       │   ├── app_typography.dart# NEW: AppTypography with Poppins
│       │   ├── app_spacing.dart   # NEW: AppSpacing static constants
│       │   ├── app_theme.dart     # UPDATED: Poppins + UX spec colors
│       │   ├── hives_colors.dart  # UPDATED: correct colors + status fields
│       │   ├── hives_spacings.dart# UNCHANGED
│       │   ├── button_theme.dart  # UPDATED: minHeight=54, borderRadius=16
│       │   ├── input_theme.dart   # UPDATED: borderRadius=14
│       │   └── surface_theme.dart # UPDATED: cardBorderRadius=24
│       ├── components/            # UNCHANGED (widgets inherit via theme)
│       └── extensions/
│           └── context_extensions.dart  # NEW
└── test/
    └── theme/
        ├── app_colors_test.dart
        ├── app_spacing_test.dart
        ├── app_typography_test.dart
        ├── app_theme_test.dart
        └── hives_colors_test.dart
```

### Downstream Impact

Stories 1.6 (base widgets) and 1.7 (status widgets) will consume:
- `AppColors.healthyStatus`, `AppColors.urgentStatus` etc. for `StatusBadge` colors
- `AppSpacing.cardRadius`, `AppSpacing.touchTargetMin` for widget dimensions
- `AppTypography.label`, `AppTypography.bodyLarge` for widget text styles
- `context.colors` extension for clean widget code

The `HivesColors` ThemeExtension status color fields added in Task 5 are the mechanism for widgets to access status colors in a theme-aware way.

### Latest Technical Information

**IMPORTANT: Verify all package versions on pub.dev at implementation time.**

**`google_fonts` (2026):**
- Latest: ~8.0.1 (use `^6.2.1` minimum for stability; check compat with workspace Dart SDK `^3.10.3`)
- `GoogleFonts.poppins(...)` — returns a TextStyle with Poppins applied
- `GoogleFonts.poppinsTextTheme(base)` — applies Poppins to every slot in a TextTheme
- Fonts are fetched from network on first use then cached; no assets needed for basic use
- For offline/production: bundle fonts via `pubspec.yaml assets` section — defer to app-level setup (out of scope this story)
- `google_fonts` does NOT require font assets in pubspec; works via HTTP cache by default

**`flutter_svg` (2026):**
- Latest: ~2.x (NOT required for this story — icons are a future concern)
- Do NOT add `flutter_svg` in this story — scope is tokens only, no SVG widgets yet

**Material 3 ColorScheme (Flutter 3.x):**
- Use `const ColorScheme(brightness: Brightness.light, ...)` constructor for explicit control over each slot
- `fromSeed` is simpler but forces tonal palette derivation — avoid for fully custom brand colors
- `background` slot is deprecated in Flutter 3.22+ in favor of `surface` — use `surface` and `scaffoldBackgroundColor` for background

**Dart 3.x syntax notes (already used in existing codebase):**
- `.circular(n)` is shorthand for `BorderRadius.circular(n)` — valid and used in existing `app_theme.dart`
- `abstract final class Foo {}` — valid Dart 3 pattern for non-instantiable static-only classes
- `FontWeight.w600` for SemiBold (not a standard named constant, use `.w600`)

### Previous Story Learnings (from Stories 1-1 to 1-4)

1. **Package import rule** — Use `import 'package:ui/...'` not relative imports (`../`) anywhere in `packages/ui`
2. **Resolution workspace** — `pubspec.yaml` must have `resolution: workspace` (already present)
3. **Melos bootstrap** — Always run after adding dependencies to resolve workspace
4. **Const constructors** — Use `const` everywhere possible; `prefer_const_constructors` lint is enforced
5. **flutter_test for widget tests** — `flutter_test` SDK is already in dev_dependencies
6. **Analysis clean before done** — Run `dart analyze` and fix all issues before marking story done
7. **No redundant imports** — Don't import `package:flutter/material.dart` multiple times
8. **Single quotes** — All string literals use single quotes
9. **Barrel file exports** — Export all public APIs through `lib/ui.dart`; internal files use `src/` prefix

### References

- [Source: ux-design-specification.md#Color-Palette] — Exact hex values for brand and status colors
- [Source: ux-design-specification.md#Typography] — Poppins type scale, sizes, weights
- [Source: ux-design-specification.md#Spacing-System] — 4px base unit, semantic values
- [Source: ux-design-specification.md#Design-Tokens] — Shape language, corner radii, shadows
- [Source: architecture.md#core_ui-structure] — Theme file organization (app_theme, app_colors, app_typography, app_spacing)
- [Source: architecture.md#Technology-Stack] — Flutter 3.x + Dart 3.x + Material 3
- [Source: epics.md#Story-1.5] — Original AC (note: color values superseded by UX spec)
- [Source: packages/ui/lib/src/theme/app_theme.dart] — Existing AppTheme to extend
- [Source: packages/ui/lib/src/theme/hives_colors.dart] — Existing HivesColors to update
- [Source: 1-4-core-data-package-database-foundation.md] — Previous story patterns

## Dev Agent Record

### Agent Model Used

claude-sonnet-4-6

### Debug Log References

- google_fonts async font loading fails in test environment without bundled assets. Fixed by converting unit tests to `testWidgets` and overriding `FlutterError.onError` to suppress expected font-loading errors (font network fetch / `allowRuntimeFetching = false` errors). `GoogleFonts.config.allowRuntimeFetching = false` set in `setUpAll` to prevent network calls.

### Completion Notes List

- ✅ Created `app_colors.dart` — `abstract final class AppColors` with 26 static const Color fields covering brand, status, and accent palettes
- ✅ Created `app_typography.dart` — `abstract final class AppTypography` with 7 named TextStyle getters (display, titleLarge, titleMedium, bodyLarge, bodyMedium, label, caption) and `textTheme()` method using `GoogleFonts.poppinsTextTheme()`
- ✅ Created `app_spacing.dart` — `abstract final class AppSpacing` with 7 base spacing values, 6 semantic aliases, and 5 BorderRadius constants
- ✅ Updated `hives_colors.dart` — replaced `hiveWood` (brown) with `secondary` (purple #8B5CF6), updated all honey/nature colors to UX spec, added 8 status color fields, updated copyWith/lerp/dark
- ✅ Updated `app_theme.dart` — new `_lightColorScheme` and `_darkColorScheme` using AppColors, replaced `_textTheme` const with `AppTypography.textTheme()`, updated card (24px), button (54px height, 16px radius), input (14px radius), chip (12px radius)
- ✅ Updated `button_theme.dart` — `ButtonThemeTokens.standard()`: minHeight=54, borderRadius=16
- ✅ Updated `input_theme.dart` — `InputThemeTokens.standard()`: borderRadius=14
- ✅ Updated `surface_theme.dart` — `SurfaceThemeTokens.standard()`: cardBorderRadius=24
- ✅ Created `lib/src/extensions/context_extensions.dart` — `HivesContextExtension` on `BuildContext` with colors, appColors, spacings, colorScheme, textTheme, theme getters
- ✅ Updated `lib/ui.dart` — exports AppColors, AppSpacing, AppTypography, context_extensions plus all existing exports
- ✅ Created test infrastructure in `test/theme/` — 5 test files, 84 tests, all passing
- ✅ `dart analyze` — 39 info-level hints (38 pre-existing, 0 errors/warnings)
- ✅ `melos run analyze` — no regressions across all packages

### File List

packages/ui/pubspec.yaml
pubspec.lock
packages/ui/lib/ui.dart
packages/ui/lib/src/theme/app_colors.dart
packages/ui/lib/src/theme/app_typography.dart
packages/ui/lib/src/theme/app_spacing.dart
packages/ui/lib/src/theme/app_theme.dart
packages/ui/lib/src/theme/hives_colors.dart
packages/ui/lib/src/theme/button_theme.dart
packages/ui/lib/src/theme/input_theme.dart
packages/ui/lib/src/theme/surface_theme.dart
packages/ui/lib/src/extensions/context_extensions.dart
packages/ui/test/theme/app_colors_test.dart
packages/ui/test/theme/app_spacing_test.dart
packages/ui/test/theme/app_typography_test.dart
packages/ui/test/theme/app_theme_test.dart
packages/ui/test/theme/hives_colors_test.dart
packages/ui/test/theme/context_extensions_test.dart

### Senior Developer Review (AI)

**Reviewer:** Andreas (AI) | **Date:** 2026-03-05

**Outcome:** Changes Requested → Fixed

**Issues Fixed (8):**
- [H1] `AppTypography.textTheme()` now includes all UX spec letterSpacing values (display: -0.5, labelLarge: +0.3, bodySmall: +0.2) — `app_typography.dart`
- [H2] Dark theme button styles now include `textStyle: GoogleFonts.poppins(...)` for all 4 button types, matching light theme — `app_theme.dart`
- [H3] Created `context_extensions_test.dart` with 6 widget tests covering all AC #7 getters — new test file
- [M1] `AppSpacing` shape constants changed from `static final BorderRadius.circular()` to `static const BorderRadius.all(Radius.circular())` — now fully const-compatible — `app_spacing.dart`
- [M2] Added clarifying doc comment on `context.appColors` directing to prefer `context.colors` — `context_extensions.dart`
- [M3] Dark theme `CardThemeData` now explicitly sets `color: _darkColorScheme.surface` — `app_theme.dart`
- [M4] Added `pubspec.lock` and `context_extensions_test.dart` to File List — story file
- [M5] Added explanatory comment in `pubspec.yaml` documenting why `google_fonts` is pinned to `^6.2.1`

**Issues Not Fixed (Low — informational):**
- [L1] `AppColors.primary` (#F59E0A) and `.attentionStatus` (#F59E0B) intentionally differ by 1 bit per UX spec — flag to UX to confirm if visually distinct intent is desired
- [L2] `display.letterSpacing` test added to `app_typography_test.dart`; remaining letterSpacing getters are implicitly covered by H1 fix
- [L3] All new files remain untracked — stage and commit before marking done

## Change Log

- 2026-03-03: Implemented Story 1.5 — Core UI Package Design Tokens. Created AppColors, AppTypography, AppSpacing static token classes; updated HivesColors ThemeExtension with UX spec colors and status fields; updated AppTheme with Poppins + UX spec component themes; created context_extensions.dart; updated barrel export; created 84 passing tests.
- 2026-03-05: Code review fixes — letterSpacing propagation in textTheme(), dark theme button/card parity, AppSpacing const correctness, context_extensions test, pubspec.lock in File List, google_fonts version comment.
