# Story 1.8: Widgetbook Documentation

Status: done

## Story

As a developer,
I want all core_ui components documented in Widgetbook,
so that the design system is browsable and testable.

## Acceptance Criteria

1. Widgetbook app exists as a separate entry point (already at `apps/storybook/`)
2. All design tokens are documented (colors, typography, spacing)
3. All base widgets have use cases showing variants and states
4. All status/feedback widgets have use cases showing all status variants
5. Interactive knobs allow testing different props
6. Widgetbook builds and runs without errors (`flutter run` from `apps/storybook/`)
7. Component documentation includes usage guidelines (inline comments in usecases)

## Tasks / Subtasks

- [x] Task 1: Design Token Galleries (AC: #2)
  - [x] 1.1 Create `usecases/tokens/color_palette_usecases.dart` — gallery showing AppColors (primary, secondary, tertiary, error, surface) and HivesColors status colors (healthyStatus/Fill, attentionStatus/Fill, urgentStatus/Fill, unknownStatus/Fill, honey)
  - [x] 1.2 Create `usecases/tokens/spacing_gallery_usecases.dart` — visual gallery showing all AppSpacing constants (xs=4, sm=8, md=12, lg=16, xl=20, xxl=24, xxxl=32, screenMargin=16) and BorderRadius presets (buttonRadius, cardRadius, chipRadius, inputRadius, modalTopRadius)
  - [x] 1.3 Typography already documented via `usecases/typography/typography_usecases.dart` — no action needed

- [x] Task 2: Missing Base Widget Usecases (AC: #3, #5)
  - [x] 2.1 Create `usecases/surfaces/list_tile_usecases.dart` — HivesListTile with usecases: Default (title only), With Subtitle, With Leading/Trailing, With Divider, Disabled, Interactive List (knobs for showDivider boolean, isEnabled boolean)
  - [x] 2.2 Create `usecases/surfaces/bottom_sheet_usecases.dart` — showHivesBottomSheet function demo: Default Content, Scrollable Content, Non-Dismissible (knobs for isDismissible, enableDrag)

- [x] Task 3: Status/Feedback Widget Usecases (AC: #4, #5)
  - [x] 3.1 Create `usecases/feedback/status_badge_usecases.dart` — StatusBadge: All Variants gallery (healthy/attention/urgent/unknown), Custom Size (knob for size double), Single Variant with knob
  - [x] 3.2 Create `usecases/feedback/loading_indicator_usecases.dart` — HivesLoadingIndicator: Default, Custom Size (knob), Custom Stroke Width (knob)
  - [x] 3.3 Create `usecases/feedback/sync_status_usecases.dart` — SyncStatusIndicator: All States gallery (offline/syncing/synced/error), Single State with dropdown knob
  - [x] 3.4 Create `usecases/feedback/snack_bar_usecases.dart` — SnackBarService: Interactive demo with buttons triggering showSuccess/showError/showInfo, message text knob

- [x] Task 4: Regenerate and Verify (AC: #6)
  - [x] 4.1 Run `dart run build_runner build --delete-conflicting-outputs` from `apps/storybook/`
  - [x] 4.2 Verify `main.directories.g.dart` includes all new usecases
  - [x] 4.3 Run `dart analyze` — zero errors
  - [x] 4.4 Run `flutter build web --no-tree-shake-icons` from `apps/storybook/` — builds without errors

- [x] Task 5: Final Verification (AC: #1-7)
  - [x] 5.1 Confirm all widget categories appear in generated directories
  - [x] 5.2 Verify knobs work interactively (string, boolean, double knobs present)
  - [x] 5.3 Verify light/dark theme switching works via existing MaterialThemeAddon

## Dev Notes

### Existing Storybook Infrastructure (DO NOT recreate)

The Widgetbook app already exists at `apps/storybook/` with full configuration:

- **Entry point**: `apps/storybook/lib/main.dart` — `HivesWidgetbook` StatelessWidget using `Widgetbook.material()`
- **Dependencies** in `apps/storybook/pubspec.yaml`:
  - `widgetbook: ^3.20.2`
  - `widgetbook_annotation: ^3.9.0`
  - `widgetbook_generator: ^3.20.1` (dev)
  - `build_runner` (dev)
  - `ui: ^0.0.1` (path dependency)
- **Addons already configured**: MaterialThemeAddon (light+dark), ViewportAddon, ZoomAddon, TextScaleAddon, LocalizationAddon
- **Code generation**: Uses `@widgetbook.UseCase` annotations → `build_runner` generates `main.directories.g.dart`

### Existing Usecases (DO NOT recreate)

These usecases already exist and are working:

| File | Component | Usecases |
|------|-----------|----------|
| `usecases/buttons/primary_button_usecases.dart` | PrimaryButton | Default, Loading, Disabled, With Icon Leading/Trailing |
| `usecases/buttons/secondary_button_usecases.dart` | SecondaryButton | Default, Loading, Disabled, With Icon Leading/Trailing |
| `usecases/buttons/highlight_button_usecases.dart` | HighlightButton | Default, Disabled, Loading, With Icon Leading/Trailing |
| `usecases/buttons/text_button_usecases.dart` | PlainTextButton | Default, Disabled, Loading, Long Text, Custom Width, With Icon Leading/Trailing |
| `usecases/surfaces/card_usecases.dart` | HivesCard | Default, With Content, Clickable, Custom Elevation |
| `usecases/feedback/chip_usecases.dart` | HivesChip | Default, Selected, With Icons, Disabled, Filter Tags |
| `usecases/inputs/text_field_usecases.dart` | HivesTextField | Default, Disabled, Multiline, Password, With Error, With Icons |
| `usecases/typography/typography_usecases.dart` | TypographyGallery | All Typography (full gallery widget) |

### Usecase Pattern to Follow

Every existing usecase file follows this exact pattern:

```dart
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: MyWidget)
Widget myWidgetDefault(BuildContext context) {
  return Center(
    child: MyWidget(
      label: context.knobs.string(label: 'Label', initialValue: 'Hello'),
      isEnabled: context.knobs.boolean(label: 'Enabled', initialValue: true),
    ),
  );
}
```

**Key conventions:**
- Import `package:widgetbook_annotation/widgetbook_annotation.dart` as `widgetbook` (not just `widgetbook_annotation`)
- Import `package:widgetbook/widgetbook.dart` for knobs API (`context.knobs.string()`, `context.knobs.boolean()`, `context.knobs.double.slider()`, `context.knobs.list()`)
- One file per component, multiple `@widgetbook.UseCase` functions per file
- Function names: `camelCase` matching `componentNameVariant` pattern (e.g., `statusBadgeAllVariants`)
- Wrap content in `Center(child: ...)` for single widgets
- Use `context.knobs.*` for interactive properties
- Do NOT import `package:widgetbook/widgetbook.dart` if no knobs are used in that file (see `card_usecases.dart` which only uses annotation import)

### Widget API Reference (for creating usecases)

**StatusBadge** (`package:ui/ui.dart`):
- `StatusBadge({required HivesStatusVariant variant, double size = 24})`
- `HivesStatusVariant` enum: `healthy`, `attention`, `urgent`, `unknown`
- Uses HivesColors ThemeExtension for fill/icon colors
- Icon is 60% of size

**HivesLoadingIndicator** (`package:ui/ui.dart`):
- `HivesLoadingIndicator({double? size, double strokeWidth = 3.0})`
- Uses honey color from `context.colors.honey`
- When `size` is provided, wraps in SizedBox

**SyncStatusIndicator** (`package:ui/ui.dart`):
- `SyncStatusIndicator({required SyncState state})`
- `SyncState` enum: `offline`, `syncing`, `synced`, `error`
- Shows icon + label row, colors from HivesColors

**SnackBarService** (`package:ui/ui.dart`):
- Static methods: `showSuccess(context, message)`, `showError(context, message)`, `showInfo(context, message)`
- Not a widget — needs a Scaffold context and button triggers in usecase
- Uses floating behavior, auto-dismisses current snackbar

**showHivesBottomSheet** (`package:ui/ui.dart`):
- Top-level function: `showHivesBottomSheet<T>({context, builder, isScrollControlled, isDismissible, enableDrag})`
- Not a widget — needs a button trigger in usecase
- Has drag handle bar, 28px top corner radius

**HivesListTile** (`package:ui/ui.dart`):
- `HivesListTile({required Widget title, Widget? subtitle, Widget? leading, Widget? trailing, VoidCallback? onTap, bool isEnabled = true, bool showDivider = false})`

**HivesHaptics** (`package:ui/ui.dart`):
- `abstract final class` with static methods: `lightImpact()`, `mediumImpact()`, `heavyImpact()`
- Non-visual utility — NO usecase needed. Haptics cannot be demonstrated in Widgetbook.

### Design Tokens for Gallery Usecases

**AppColors** (from `packages/ui/lib/src/theme/app_colors.dart`):
- Access via `Theme.of(context).colorScheme` — primary, secondary, tertiary, error, surface, onSurface, etc.

**HivesColors** (from `packages/ui/lib/src/theme/hives_colors.dart`):
- Access via `context.colors` (extension method)
- Status colors: `healthyStatus`, `healthyFill`, `attentionStatus`, `attentionFill`, `urgentStatus`, `urgentFill`, `unknownStatus`, `unknownFill`, `honey`

**AppSpacing** (from `packages/ui/lib/src/theme/app_spacing.dart`):
- Static constants: `xs=4`, `sm=8`, `md=12`, `lg=16`, `xl=20`, `xxl=24`, `xxxl=32`, `screenMargin=16`
- BorderRadius: `buttonRadius=16`, `cardRadius=24`, `chipRadius=12`, `inputRadius=14`, `modalTopRadius=28` (top only), `dragHandleRadius=2`
- Dimensions: `dragHandleWidth=32`, `dragHandleHeight=4`, `dividerSpace=1`

### Special Handling Notes

**For showHivesBottomSheet and SnackBarService usecases:**
These are not widgets — they are functions/services. Create usecases with a wrapper widget containing trigger buttons:

```dart
// Pattern for function-based components:
@widgetbook.UseCase(name: 'Default', type: _SnackBarDemo)
Widget snackBarDemo(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () => SnackBarService.showSuccess(context, 'Saved!'),
            child: const Text('Show Success'),
          ),
          // ... more buttons
        ],
      ),
    ),
  );
}
```

For the `type:` parameter in `@widgetbook.UseCase`, use a private wrapper class name (e.g., `_SnackBarDemo`, `_BottomSheetDemo`) or define a simple placeholder class in the file. The type must exist as a class.

**IMPORTANT**: The `type` parameter in `@widgetbook.UseCase` must reference an actual class. For function-based APIs (showHivesBottomSheet, SnackBarService), define a minimal wrapper widget class in the same file:

```dart
class SnackBarDemo extends StatelessWidget {
  const SnackBarDemo({super.key});
  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
```

Then use `type: SnackBarDemo` in the annotation. Cannot use private classes for the type parameter.

### Token Gallery Pattern

For design token galleries (colors, spacing), use the same pattern as `typography_usecases.dart` — define a gallery StatelessWidget and reference it as the type:

```dart
@widgetbook.UseCase(name: 'All Colors', type: ColorPaletteGallery)
Widget colorPaletteGallery(BuildContext context) {
  return const ColorPaletteGallery();
}

class ColorPaletteGallery extends StatelessWidget { ... }
```

### Project Structure Notes

- All new files go under `apps/storybook/lib/usecases/`
- Follow existing folder structure: `tokens/`, `feedback/`, `surfaces/`
- Use `package:ui/ui.dart` for all UI imports (barrel export)
- Use `package:storybook/...` for internal storybook imports if needed
- After creating files, run `dart run build_runner build --delete-conflicting-outputs` to regenerate `main.directories.g.dart`

### Lint Rules

- `always_use_package_imports` — use `package:ui/ui.dart`, never relative
- `prefer_single_quotes` — all strings
- `prefer_const_constructors` — use const where possible

### References

- [Source: _bmad-output/planning-artifacts/epics.md#Story 1.8]
- [Source: apps/storybook/lib/main.dart — existing Widgetbook configuration]
- [Source: apps/storybook/lib/usecases/ — existing usecase patterns]
- [Source: packages/ui/lib/src/components/ — all widget implementations]
- [Source: packages/ui/lib/src/theme/ — all design token files]
- [Source: _bmad-output/implementation-artifacts/1-7-core-ui-package-status-feedback-widgets.md — previous story]

## Dev Agent Record

### Agent Model Used

Claude Opus 4.6

### Debug Log References

### Completion Notes List

- Created 8 new usecase files covering design tokens (colors, spacing), base widgets (HivesListTile, showHivesBottomSheet), and status/feedback widgets (StatusBadge, HivesLoadingIndicator, SyncStatusIndicator, SnackBarService)
- Used `context.knobs.object.dropdown()` instead of deprecated `context.knobs.list()` for enum selection knobs
- Used `color.toARGB32()` instead of deprecated `color.value` for hex display
- Added explicit `path` annotations for SnackBarDemo and BottomSheetDemo to group them under `components/feedback` and `components/surfaces` respectively
- Typography gallery (existing) counted as design token documentation — no new work needed
- HivesHaptics excluded (non-visual utility, cannot be demonstrated in Widgetbook)
- All 150 existing UI tests pass — zero regressions
- `dart analyze` passes with 0 errors (12 info hints, all pre-existing in other files)
- `flutter build web --no-tree-shake-icons` builds successfully
- `build_runner` regenerates `main.directories.g.dart` with all 16 components (8 existing + 8 new)

#### Code Review Fixes (v1.1)

- H1: Added 6 missing AppColors to color gallery — `teal`, `tealLight`, `blue`, `blueLight` (accent section), `background`, `onSurfaceVariant` (surface section)
- H2: Added 3 missing AppSpacing constants — `dragHandleWidth`, `dragHandleHeight`, `dividerSpace` in new "Dimensions" section; added `dragHandleRadius` to BorderRadius section
- M1: Fixed double `const` in `spacing_gallery_usecases.dart` (`const Wrap(children: const [...])` → `const Wrap(children: [...])`)
- M2: Replaced `ElevatedButton`/`ElevatedButton.icon` with `PrimaryButton`/`SecondaryButton` in `snack_bar_usecases.dart` and `bottom_sheet_usecases.dart`
- M3: Wrapped "With Divider" usecase in `Center` in `list_tile_usecases.dart`
- All 150 tests pass, `dart analyze` 0 errors, `build_runner` regenerated successfully

### Change Log

- v1.1 (2026-03-05): Code review fixes — added missing tokens (H1, H2), fixed double const (M1), replaced ElevatedButton with Hives buttons (M2), added Center wrapping (M3)
- v1.0 (2026-03-05): Initial implementation — 8 usecase files, 2 design token galleries, code gen verified, web build passing

### File List

- `apps/storybook/lib/usecases/tokens/color_palette_usecases.dart` (NEW)
- `apps/storybook/lib/usecases/tokens/spacing_gallery_usecases.dart` (NEW)
- `apps/storybook/lib/usecases/surfaces/list_tile_usecases.dart` (NEW)
- `apps/storybook/lib/usecases/surfaces/bottom_sheet_usecases.dart` (NEW)
- `apps/storybook/lib/usecases/feedback/status_badge_usecases.dart` (NEW)
- `apps/storybook/lib/usecases/feedback/loading_indicator_usecases.dart` (NEW)
- `apps/storybook/lib/usecases/feedback/sync_status_usecases.dart` (NEW)
- `apps/storybook/lib/usecases/feedback/snack_bar_usecases.dart` (NEW)
- `apps/storybook/lib/main.directories.g.dart` (REGENERATED)
- `_bmad-output/implementation-artifacts/sprint-status.yaml` (MODIFIED)
- `_bmad-output/implementation-artifacts/1-8-widgetbook-documentation.md` (MODIFIED)
