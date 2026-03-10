# Story 1.12: Location & Map Components

Status: done

<!-- Note: Validation is optional. Run validate-create-story for quality check before dev-story. -->

## Story

As a developer,
I want location card and map preview components in the widget library,
so that Epic 3 location screens have design-reviewed, reusable building blocks.

## Acceptance Criteria

1. **HivesLocationCard** renders full-width × 160px full-bleed image card with 20px border radius; optional `image` (ImageProvider) fills the background (placeholder landscape icon when null); dark gradient overlay at the bottom with white text for location name (16px SemiBold) and status summary (13px, 80% white); status icon in top-right corner (teal `#14B8A6` check_circle healthy / amber `#F59E0B` warning attention / red `#EF4444` error urgent / gray `#A8A29E` add_circle empty); right chevron; includes `isLoading` shimmer variant; accepts `onTap` callback
2. **HivesMapPreviewWidget** renders full-width × 160px with 20px border radius, displays a map tile content area with a teal `#14B8A6` pin marker (36px `Icons.location_pin`) centered; `noPinSet` variant (`hasPin: false`) shows gray placeholder container with centered `Icons.location_on_outlined` (32px) and "Tap to set location" label in 15px `#A8A29E`; tappable via `onTap` callback; `isLoading` shimmer variant; accepts optional `mapContent` widget for the tile background
3. All components are exported via `package:ui/ui.dart` (through a new `locations.dart` barrel)
4. Each component has a Widgetbook story documenting all variants and states
5. `dart analyze` passes with zero issues and all widget tests pass

## Tasks / Subtasks

- [x] Task 1: Create HivesLocationCard widget (AC: #1)
  - [x] 1.1 Create directory `packages/ui/lib/src/components/locations/` and file `hives_location_card.dart`
  - [x] 1.2 Define `HivesLocationStatus` enum: `healthy`, `attention`, `urgent`, `empty`
  - [x] 1.3 Implement `HivesLocationCard` as StatefulWidget with `SingleTickerProviderStateMixin` (for shimmer animation)
  - [x] 1.4 Accept params: `locationName` (String), `statusSummary` (String), `status` (HivesLocationStatus), `image` (ImageProvider?), `isLoading` (bool, default false), `onTap` (VoidCallback?)
  - [x] 1.5 Build card layout: 160px full-bleed image card with ClipRRect(20px) → Stack: background image (or tealLight placeholder with landscape icon), dark gradient overlay at bottom, status icon top-right, white text + chevron bottom
  - [x] 1.6 Implement shimmer loading variant: AnimationController repeating 1.2s, shimmer sweeps over gray placeholder (160px height, no text)
  - [x] 1.7 Wire `onTap` via `Material`/`InkWell` conditionally rendered (only when `onTap != null`)
  - [x] 1.8 Write widget tests: all 4 status variants with icon assertions, loading shimmer, onTap fires, no tap in loading state, placeholder/image tests (10 tests)
  - [x] 1.9 Create Widgetbook use cases in `apps/storybook/lib/usecases/locations/` (6 use cases incl. "With Image")

- [x] Task 2: Create HivesMapPreviewWidget widget (AC: #2)
  - [x] 2.1 Create `packages/ui/lib/src/components/locations/hives_map_preview_widget.dart`
  - [x] 2.2 Implement as StatefulWidget with `SingleTickerProviderStateMixin` (for shimmer)
  - [x] 2.3 Accept params: `hasPin` (bool, default true), `mapContent` (Widget?, optional background tile), `isLoading` (bool, default false), `onTap` (VoidCallback?)
  - [x] 2.4 Build widget: `SizedBox(height: 160)` → `ClipRRect(borderRadius: 20px)` → `Stack` with: map background (mapContent or warm-gray Container placeholder), centered `Icon(Icons.location_pin, color: AppColors.teal, size: 36)` when `hasPin: true`, full-size `_NoPinSetPlaceholder` when `hasPin: false`
  - [x] 2.5 `noPinSet` placeholder: gray Container (`color: AppColors.outline`) with centered Column: `Icon(Icons.location_on_outlined, size: 32, color: AppColors.onSurfaceVariant)` + 8px gap + Text("Tap to set location", bodyMedium, onSurfaceVariant)
  - [x] 2.6 Implement shimmer loading overlay (same AnimationController + shimmer sweep pattern as LocationCard)
  - [x] 2.7 Wire `onTap` via `Material(color: Colors.transparent, child: InkWell(...))` as topmost Stack layer (disabled when `isLoading: true`)
  - [x] 2.8 Write widget tests: pin variant, noPinSet variant, loading shimmer, onTap fires, dark mode (5 tests)
  - [x] 2.9 Create Widgetbook use cases in `apps/storybook/lib/usecases/locations/` (3 use cases)

- [x] Task 3: Export and integrate (AC: #3, #4, #5)
  - [x] 3.1 Create `packages/ui/lib/src/components/locations/locations.dart` barrel exporting both widgets
  - [x] 3.2 Add `export 'src/components/locations/locations.dart';` to `packages/ui/lib/ui.dart`
  - [x] 3.3 Run `dart run build_runner build` in `apps/storybook/` to regenerate Widgetbook
  - [x] 3.4 Run `dart analyze` across all packages and fix any issues
  - [x] 3.5 Run full test suite: 54/54 widget tests pass (13 new + 41 existing)

## Dev Notes

### Component Architecture

**HivesLocationCard** and **HivesMapPreviewWidget** both go in a NEW directory:
`packages/ui/lib/src/components/locations/` (create it — does not exist yet)

Both are **StatefulWidgets** because they need `AnimationController` for the shimmer loading animation. Follow `PrimaryButton`'s exact shimmer pattern (`SingleTickerProviderStateMixin` + `AnimationController.repeat()` + `AnimatedBuilder`).

### Design Token Mapping (CRITICAL — no hardcoded hex values)

| Spec Value | Token | Usage |
|---|---|---|
| `#14B8A6` | `AppColors.teal` | Healthy accent bar, map pin color |
| `#F59E0B` | `AppColors.attentionStatus` | Attention accent bar |
| `#EF4444` | `AppColors.urgentStatus` | Urgent accent bar |
| `#A8A29E` | `AppColors.onSurfaceVariant` | Empty accent bar, subtitle text, noPinSet text |
| `#1C1917` | `AppColors.onSurface` | Location name text |
| `#FFFFFF` | `AppColors.surface` | Card background |
| `#E7E5E4` | `AppColors.outline` | noPinSet placeholder background |
| `rgba(0,0,0,0.06)` | `Colors.black.withValues(alpha: 0.06)` | Card shadow |
| 16px SemiBold | `AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.w600)` | Location name |
| 13px gray | `AppTypography.label.copyWith(color: AppColors.onSurfaceVariant, fontWeight: FontWeight.w400)` | Status summary |
| 15px gray | `AppTypography.bodyMedium.copyWith(color: AppColors.onSurfaceVariant)` | noPinSet label |
| 20px card radius | `BorderRadius.circular(20)` | Both widgets — NOT `AppSpacing.cardRadius` (which is 24px) |
| `0 4px 16px rgba(0,0,0,0.06)` | `BoxShadow(color: Colors.black.withValues(alpha: 0.06), offset: Offset(0,4), blurRadius: 16)` | LocationCard shadow |

### HivesLocationCard — Detailed Implementation

**Widget class:**
```dart
class HivesLocationCard extends StatefulWidget {
  final String locationName;
  final String statusSummary;  // e.g. "3 hives · All healthy"
  final HivesLocationStatus status;
  final bool isLoading;
  final VoidCallback? onTap;

  const HivesLocationCard({
    super.key,
    required this.locationName,
    required this.statusSummary,
    required this.status,
    this.isLoading = false,
    this.onTap,
  });
}
```

**Accent bar color lookup** (in `_HivesLocationCardState.build()`):
```dart
Color get _accentColor => switch (widget.status) {
  HivesLocationStatus.healthy   => AppColors.teal,
  HivesLocationStatus.attention => AppColors.attentionStatus,
  HivesLocationStatus.urgent    => AppColors.urgentStatus,
  HivesLocationStatus.empty     => AppColors.onSurfaceVariant,
};
```

**Layout structure:**
```
SizedBox(height: 88, child:
  Material(color: Colors.transparent, child:
    InkWell(onTap: isLoading ? null : onTap,
      borderRadius: BorderRadius.circular(20),
      child: Ink(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), offset: Offset(0, 4), blurRadius: 16)],
        ),
        child: Row(
          children: [
            // Accent bar (5px wide, full height, left-side radius only)
            Container(
              width: 5,
              decoration: BoxDecoration(
                color: _accentColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
            ),
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(locationName, style: AppTypography.bodyLarge.copyWith(
                            fontWeight: FontWeight.w600, color: AppColors.onSurface)),
                          const SizedBox(height: AppSpacing.xs),
                          Text(statusSummary, style: AppTypography.label.copyWith(
                            color: AppColors.onSurfaceVariant, fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right, color: AppColors.onSurfaceVariant, size: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ),
)
```

**Shimmer loading state** (replaces full card contents when `isLoading: true`):
Follow the `PrimaryButton` shimmer pattern EXACTLY:
- `_shimmerController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))`
- `_shimmerAnimation = Tween<double>(begin: -0.5, end: 1.5).animate(CurvedAnimation(parent: _shimmerController, curve: Curves.linear))`
- Start with `_shimmerController.repeat()` in `initState()` when `isLoading: true`
- In `didUpdateWidget()`: start/stop based on `isLoading` change
- `dispose()` must call `_shimmerController.dispose()`
- Shimmer base: Container(88px, 20px radius, color: `Color(0xFFF5F5F4)`) with `AnimatedBuilder` + `Positioned.fill` shimmer overlay using LinearGradient (Colors.white.withValues(alpha: 0.0/0.4/0.0))

### HivesMapPreviewWidget — Detailed Implementation

**Widget class:**
```dart
class HivesMapPreviewWidget extends StatefulWidget {
  final bool hasPin;
  final Widget? mapContent;  // optional map tile background; defaults to warm-gray placeholder
  final bool isLoading;
  final VoidCallback? onTap;

  const HivesMapPreviewWidget({
    super.key,
    this.hasPin = true,
    this.mapContent,
    this.isLoading = false,
    this.onTap,
  });
}
```

**Layout structure:**
```
SizedBox(
  width: double.infinity,
  height: 160,
  child: ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Stack(
      fit: StackFit.expand,
      children: [
        // Background: mapContent OR default placeholder
        mapContent ?? Container(color: const Color(0xFFE8EDF2)),  // light blue-gray map placeholder

        // Pin marker (only when hasPin: true)
        if (hasPin && !isLoading)
          Center(
            child: Icon(Icons.location_pin,
              color: AppColors.teal, size: 36,
              semanticLabel: 'Map pin'),
          ),

        // NoPinSet placeholder (only when hasPin: false)
        if (!hasPin && !isLoading)
          Container(
            color: AppColors.outline,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on_outlined, size: 32, color: AppColors.onSurfaceVariant,
                  semanticLabel: 'No location set'),
                const SizedBox(height: AppSpacing.sm),
                Text('Tap to set location',
                  style: AppTypography.bodyMedium.copyWith(color: AppColors.onSurfaceVariant)),
              ],
            ),
          ),

        // Shimmer overlay (only when isLoading: true)
        if (isLoading) _buildShimmerOverlay(),

        // Tap handler (topmost, transparent)
        if (onTap != null && !isLoading)
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(onTap: onTap),
            ),
          ),
      ],
    ),
  ),
)
```

For the shimmer overlay: same `AnimatedBuilder` + `LinearGradient` pattern. Use `Positioned.fill` Container with the gradient.

### Widgetbook Use Cases

Follow the `@widgetbook.UseCase(name: '...', type: WidgetType)` annotation pattern.

**Location card use cases** (`apps/storybook/lib/usecases/locations/location_card_usecases.dart`):
- `'Healthy'` — `HivesLocationCard(locationName: 'Meadow Apiary', statusSummary: '4 hives · All healthy', status: HivesLocationStatus.healthy, onTap: () {})`
- `'Attention'` — status: attention, summary: '3 hives · 1 needs attention'
- `'Urgent'` — status: urgent, summary: '2 hives · 1 urgent'
- `'Empty'` — status: empty, summary: 'No hives yet'
- `'Loading'` — isLoading: true

**Map preview use cases** (`apps/storybook/lib/usecases/locations/map_preview_usecases.dart`):
- `'With Pin'` — `HivesMapPreviewWidget(hasPin: true, onTap: () {})`
- `'No Pin Set'` — `HivesMapPreviewWidget(hasPin: false, onTap: () {})`
- `'Loading'` — `HivesMapPreviewWidget(isLoading: true)`

### Widget Test Patterns to Follow

From stories 1.10 and 1.11:
- `setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false)` at top of every test file
- `pumpWidget(MaterialApp(theme: AppTheme.lightTheme, home: Scaffold(body: widget)))`
- For shimmer tests: call `pumpWidget` then `pump(Duration(milliseconds: 100))` to advance animation; verify `CircularProgressIndicator` absent and text absent
- For tap tests: `await tester.tap(find.byType(HivesLocationCard)); expect(tapped, isTrue)`
- Test files in `packages/ui/test/components/locations/`

**Minimum tests:**

*HivesLocationCard (8 tests):*
1. healthy variant renders location name, status summary, chevron
2. attention variant renders (smoke test — renders without exception)
3. urgent variant renders (smoke test)
4. empty variant renders
5. loading state: no locationName text visible, no tap fires
6. onTap callback fires when tapped
7. does NOT fire onTap when isLoading: true
8. renders in dark mode without exception

*HivesMapPreviewWidget (5 tests):*
1. hasPin: true shows location_pin icon
2. hasPin: false shows "Tap to set location" text and location_on_outlined icon
3. loading state renders without exception, no tap fires
4. onTap fires when tapped
5. renders in dark mode without exception

### Existing Widgets to REUSE

| Widget | Location | Usage |
|---|---|---|
| `AppColors` | `theme/app_colors.dart` | All color tokens (teal, attentionStatus, urgentStatus, onSurfaceVariant, etc.) |
| `AppTypography` | `theme/app_typography.dart` | Text styles (bodyLarge, label, bodyMedium) |
| `AppSpacing` | `theme/app_spacing.dart` | Spacing constants (xs, sm, md, lg, xl) |
| `AppTheme.lightTheme` / `.darkTheme` | `theme/app_theme.dart` | Test wrapper and dark mode test |
| `HivesStatusVariant` | `feedback/status_badge.dart` | Do NOT use in LocationCard — LocationCard has its own HivesLocationStatus enum |

### Project Structure Notes

**New directory required:** `packages/ui/lib/src/components/locations/`

**New export chain:**
1. `hives_location_card.dart` → exported by `locations.dart` barrel
2. `hives_map_preview_widget.dart` → exported by `locations.dart` barrel
3. `locations.dart` barrel → added to `packages/ui/lib/ui.dart`

**ui.dart currently exports:** auth, buttons, feedback, inputs, surfaces, typography — add `locations` after `inputs`:
```dart
export 'src/components/inputs/inputs.dart';
export 'src/components/locations/locations.dart';  // ← ADD THIS
export 'src/components/surfaces/surfaces.dart';
```

**Widgetbook:** New `apps/storybook/lib/usecases/locations/` directory. After creating use cases, run `dart run build_runner build` from `apps/storybook/` to regenerate `storybook.dart`.

### Do NOT Reinvent

- The shimmer animation is pure Flutter (no external package). Copy the `PrimaryButton` `_buildShimmerEffect` approach.
- No map SDK needed for this story. The `mapContent` slot accepts a Widget — for Widgetbook use a solid-color Container, for Epic 3 use `flutter_map` or Google Maps tiles.
- Do NOT create a new barrel for the test directory — test files are directly in `packages/ui/test/components/locations/`.
- The `HivesStatusVariant` enum from `status_badge.dart` is for `StatusBadge` only. LocationCard needs its own `HivesLocationStatus` enum because the "healthy" color is teal (not green) and uses "empty" (not "unknown").

### Previous Story Intelligence (Stories 1.10 & 1.11)

**Mandatory patterns from established stories:**
- Always `const` constructors — `HivesLocationCard` has no const constructor (needs AnimationController), `HivesLocationStatus` enum IS const-able
- Material 3 components — use `Material`/`InkWell` for tap ripple, NOT `GestureDetector`
- `Opacity(opacity: 0.5)` not needed here (no disabled state in these components)
- Shadow: use `Colors.black.withValues(alpha: x)` NOT `.withOpacity(x)` (withOpacity is deprecated in Dart 3.x+)
- Theme tokens ALWAYS — no hardcoded hex values in widget code
- `dispose()` must call `_shimmerController.dispose()`; never create controllers in `build()`
- `didUpdateWidget()` must start/stop animation when `isLoading` changes

**Review issues from stories 1.10-1.11 to AVOID:**
- Never hardcode color values (e.g., `Color(0x4CEF4444)`) — always use `AppColors.xxx.withValues(alpha:)`
- Do not use `maxLength` on TextField inputs if paste behavior needed (not relevant here)
- Factory constructors that don't accept optional params break extensibility — LocationCard has no factory constructors, so N/A
- `onConfirm()` before `Navigator.pop()` for proper context handling (not relevant here)

### Git Intelligence

**Recent commit patterns:**
- Prefix: `feat:` for new features
- Style: Single commit per story covering all new components
- Pre-commit: `dart analyze` clean + `melos run test` all pass

**Current codebase state:** 41 widget tests passing. Auth components (story 1.10), HivesEmptyState, HivesDangerButton, HivesConfirmDialog (story 1.11) all complete. Both stories' files are uncommitted in working tree (alongside story 2.1 authentication domain).

### References

- [Source: _bmad-output/planning-artifacts/epics.md#Story 1.12] — AC, story statement
- [Source: _bmad-output/planning-artifacts/epics.md#Epic 3] — LocationCard/MapPreview will be used by 3.5, 3.7, 3.8 screens
- [Source: _bmad-output/planning-artifacts/ux-design-specification.md] — teal for location features (#14B8A6), card shadow `0 4px 16px rgba(0,0,0,0.06)`
- [Source: _bmad-output/planning-artifacts/architecture.md#Module Structure] — locations feature module, `packages/features/locations/`
- [Source: packages/ui/lib/src/components/buttons/primary_button.dart] — shimmer animation pattern (AnimationController, AnimatedBuilder, LinearGradient)
- [Source: packages/ui/lib/src/components/feedback/status_badge.dart] — HivesStatusVariant enum pattern (DO NOT reuse — LocationCard has different colors)
- [Source: packages/ui/lib/src/theme/app_colors.dart] — `AppColors.teal`, `AppColors.attentionStatus`, `AppColors.urgentStatus`, `AppColors.onSurfaceVariant`, `AppColors.surface`, `AppColors.outline`
- [Source: packages/ui/lib/src/theme/app_spacing.dart] — `AppSpacing.xs/sm/md/lg/xl`
- [Source: packages/ui/lib/src/theme/app_typography.dart] — `AppTypography.bodyLarge`, `AppTypography.label`, `AppTypography.bodyMedium`
- [Source: packages/ui/lib/ui.dart] — export chain pattern
- [Source: _bmad-output/implementation-artifacts/1-11-feedback-and-confirmation-components.md] — previous story patterns, review learnings

## Dev Agent Record

### Agent Model Used

Claude Sonnet 4.6

### Debug Log References

N/A

### Completion Notes List

- HivesLocationCard redesigned as full-bleed image card with dark gradient overlay and status icon (Destination Cards UI style)
- Optional `image` (ImageProvider?) param; placeholder shows tealLight background with landscape icon
- Status indicated by top-right icon (check_circle/warning/error/add_circle) with semantic labels
- Shimmer animation follows PrimaryButton pattern exactly (AnimationController + AnimatedBuilder + LinearGradient)
- Used Material/InkWell for tap ripple (not GestureDetector), conditionally rendered only when `onTap != null`
- HivesLocationStatus enum is separate from HivesStatusVariant (different colors: teal vs green for healthy)
- Both widgets use `didUpdateWidget()` to handle `isLoading` transitions correctly
- Default map background uses `Color(0xFFE8EDF2)` — only hardcoded color, intentionally not a token (placeholder for real map tiles)
- 15 new widget tests (10 LocationCard + 5 MapPreview), 56 total tests pass including regression
- 9 Widgetbook use cases (6 LocationCard + 3 MapPreview)
- Storybook assets: meadow landscape image (Unsplash CC0) for "With Image" use case

### File List (10 files)

| File | Action | Description |
|---|---|---|
| `packages/ui/lib/src/components/locations/hives_location_card.dart` | Created | Full-bleed image HivesLocationCard with gradient overlay, status icon, HivesLocationStatus enum |
| `packages/ui/lib/src/components/locations/hives_map_preview_widget.dart` | Created | HivesMapPreviewWidget with pin/noPinSet/loading variants |
| `packages/ui/lib/src/components/locations/locations.dart` | Created | Barrel export for location components |
| `packages/ui/lib/ui.dart` | Modified | Added locations barrel export |
| `packages/ui/test/components/locations/hives_location_card_test.dart` | Created | 10 widget tests for HivesLocationCard |
| `packages/ui/test/components/locations/hives_map_preview_widget_test.dart` | Created | 5 widget tests for HivesMapPreviewWidget |
| `apps/storybook/lib/usecases/locations/location_card_usecases.dart` | Created | 6 Widgetbook use cases for HivesLocationCard (incl. With Image) |
| `apps/storybook/lib/usecases/locations/map_preview_usecases.dart` | Created | 3 Widgetbook use cases for HivesMapPreviewWidget |
| `apps/storybook/pubspec.yaml` | Modified | Added assets/ folder declaration |
| `apps/storybook/assets/meadow_apiary.jpg` | Created | Meadow landscape image for Widgetbook "With Image" use case |

### Change Log

| Date | Change | Reason |
|---|---|---|
| 2026-03-06 | Story created | Story 1.12 create-story workflow |
| 2026-03-06 | Implementation complete — all tasks done | dev-story workflow |
| 2026-03-06 | Code review: fixed H1 (stale ACs/tasks), H2 (incomplete File List), M1 (status icon semanticLabel), M2 (InkWell always rendered), M3 (barrel doc stale), M4 (variant tests missing icon assertions), L1-L3 (stale doc comments/counts) | code-review workflow |
