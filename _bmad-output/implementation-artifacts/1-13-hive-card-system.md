# Story 1.13: Hive Card System

Status: done

## Story

As a developer,
I want the complete hive card component family in the widget library,
So that Epic 4 hive list and dashboard screens have the vibrant, status-coded cards defined in the UX spec.

## Acceptance Criteria

1. `HiveCardTile` renders ~160x150px with 24px radius, tinted status fill backgrounds (`#DCFCE7` healthy, `#FEF3C7` attention, `#FEE2E2` urgent, `#F1F5F9` unknown), 48px hive icon placeholder, 15px SemiBold name, 12px `#A8A29E` last-inspected label, 28px `StatusBadge` top-right, and a `loading` shimmer variant on `#F5F5F4` background
2. `HiveCardSimple` renders full-width x 110px with 20px radius, 5px status-colored rounded left accent bar, 16px SemiBold name, 13px `#A8A29E` status summary, 28px `StatusBadge` right, `0 4px 16px rgba(0,0,0,0.06)` shadow, and a `loading` shimmer variant
3. `HiveCardCompact` renders full-width x 80px with 16px radius, 5px left status bar, 15px SemiBold name, 13px `#A8A29E` timestamp + last observation, no badge, and a `loading` shimmer variant
4. `HiveCardSkeleton` provides explicit shimmer placeholders for `tile` (160x150px) and `simple` (full x 110px) variants using `#F5F5F4` base and `#EBEBEB` highlight with 1.2s animation loop
5. All four status variants (healthy, attention, urgent, unknown) are supported on each card type
6. All components are exported via `package:ui/ui.dart`
7. Each component has a Widgetbook story documenting all variants and states
8. `dart analyze` passes with zero issues and all widget tests pass

## Tasks / Subtasks

- [x] Task 1: Create hive card status enum and color mappings (AC: #5)
  - [x] 1.1 Create `HivesHiveStatus` enum with `healthy`, `attention`, `urgent`, `unknown` values
  - [x] 1.2 Map fill backgrounds: healthy→`#DCFCE7`, attention→`#FEF3C7`, urgent→`#FEE2E2`, unknown→`#F1F5F9`
  - [x] 1.3 Map accent colors: healthy→`#16A34A`, attention→`#F59E0B`, urgent→`#DC2626`, unknown→`#94A3B8`
  - [x] 1.4 Map to existing `HivesStatusVariant` for `StatusBadge` integration via switch expression

- [x] Task 2: Implement `HiveCardTile` (AC: #1)
  - [x] 2.1 Create `StatefulWidget` with `SingleTickerProviderStateMixin` for shimmer
  - [x] 2.2 Render ~160x150px with 24px `BorderRadius`, tinted status fill background
  - [x] 2.3 Display 48px placeholder hive icon (use `Icons.hexagon_outlined` or similar)
  - [x] 2.4 Show hive name in 15px SemiBold, last-inspected in 12px `AppColors.onSurfaceVariant`
  - [x] 2.5 Position 28px `StatusBadge` top-right using `Stack`/`Positioned`
  - [x] 2.6 Implement `loading` shimmer variant following `PrimaryButton` pattern
  - [x] 2.7 Accept `onTap` callback, disable when `isLoading` is true

- [x] Task 3: Implement `HiveCardSimple` (AC: #2)
  - [x] 3.1 Create `StatefulWidget` with shimmer support
  - [x] 3.2 Render full-width x 110px with 20px `BorderRadius`
  - [x] 3.3 Draw 5px rounded left accent bar using status color
  - [x] 3.4 Show name in 16px SemiBold, status summary in 13px `AppColors.onSurfaceVariant`
  - [x] 3.5 Position 28px `StatusBadge` right-aligned
  - [x] 3.6 Apply `BoxShadow(color: Colors.black.withValues(alpha: 0.06), offset: Offset(0,4), blurRadius: 16)`
  - [x] 3.7 Implement `loading` shimmer variant
  - [x] 3.8 Accept `onTap` callback, disable when `isLoading`

- [x] Task 4: Implement `HiveCardCompact` (AC: #3)
  - [x] 4.1 Create `StatefulWidget` with shimmer support
  - [x] 4.2 Render full-width x 80px with 16px `BorderRadius`
  - [x] 4.3 Draw 5px left status bar (same pattern as `HiveCardSimple`)
  - [x] 4.4 Show name in 15px SemiBold, timestamp + observation in 13px `AppColors.onSurfaceVariant`
  - [x] 4.5 No `StatusBadge` — status conveyed by accent bar only
  - [x] 4.6 Implement `loading` shimmer variant
  - [x] 4.7 Accept `onTap` callback, disable when `isLoading`

- [x] Task 5: Implement `HiveCardSkeleton` (AC: #4)
  - [x] 5.1 Create `StatefulWidget` with `AnimationController` (1200ms loop)
  - [x] 5.2 Accept `variant` param: `tile` (160x150px) or `simple` (full x 110px)
  - [x] 5.3 Use `#F5F5F4` base and `#EBEBEB` highlight sweep colors
  - [x] 5.4 Render rounded placeholder shapes matching card layout

- [x] Task 6: Create barrel exports and integrate (AC: #6)
  - [x] 6.1 Create `packages/ui/lib/src/components/hives/hives.dart` barrel
  - [x] 6.2 Add `export 'src/components/hives/hives.dart';` to `packages/ui/lib/ui.dart`

- [x] Task 7: Create Widgetbook use cases (AC: #7)
  - [x] 7.1 Create `apps/storybook/lib/usecases/hives/hive_card_usecases.dart`
  - [x] 7.2 Add use cases: Tile (4 statuses + loading), Simple (4 statuses + loading), Compact (4 statuses + loading), Skeleton (tile + simple)
  - [x] 7.3 Static per-variant use cases used instead of interactive knobs — consistent with established project pattern in `location_card_usecases.dart`. All variants and loading states are documented via dedicated use case functions.
  - [x] 7.4 Run `dart run build_runner build` from `apps/storybook/`

- [x] Task 8: Write widget tests (AC: #8)
  - [x] 8.1 Create `packages/ui/test/components/hives/hive_card_tile_test.dart`
  - [x] 8.2 Create `packages/ui/test/components/hives/hive_card_simple_test.dart`
  - [x] 8.3 Create `packages/ui/test/components/hives/hive_card_compact_test.dart`
  - [x] 8.4 Create `packages/ui/test/components/hives/hive_card_skeleton_test.dart`
  - [x] 8.5 Test all status variants render correctly for each card type
  - [x] 8.6 Test loading/shimmer states, tap callback, dark mode

- [x] Task 9: Run analysis and verify (AC: #8)
  - [x] 9.1 Run `dart analyze` — zero issues
  - [x] 9.2 Run `melos run test` — all tests pass
  - [x] 9.3 Verify Widgetbook builds and shows all use cases

## Dev Notes

### Architecture Patterns & Constraints

**Widget Pattern:** Follow the exact pattern from `HivesLocationCard` (story 1-12):
- `StatefulWidget` with `SingleTickerProviderStateMixin` for shimmer
- Switch expressions for status-variant color/icon mapping
- `AnimationController` (1200ms) + `AnimatedBuilder` + `LinearGradient` sweep
- Manage controller in `initState()`, `didUpdateWidget()`, `dispose()`
- Use `Material`/`InkWell` for tap ripples, NOT `GestureDetector`
- Conditionally render `InkWell` only when `onTap != null`
- Pass `null` to `onTap` when `isLoading: true` to block interaction

**StatusBadge Reuse:** The existing `StatusBadge` component (from story 1-7) uses `HivesStatusVariant` enum. Map your `HivesHiveStatus` to `HivesStatusVariant` for badge rendering:
```dart
HivesStatusVariant get _badgeVariant => switch (status) {
  HivesHiveStatus.healthy   => HivesStatusVariant.healthy,
  HivesHiveStatus.attention => HivesStatusVariant.attention,
  HivesHiveStatus.urgent    => HivesStatusVariant.urgent,
  HivesHiveStatus.unknown   => HivesStatusVariant.unknown,
};
```

**Separate Enum Required:** Create `HivesHiveStatus` — do NOT reuse `HivesLocationStatus` or `HivesStatusVariant`. Different features use different enums even if values overlap. Hive card fill colors are different from location card accent colors (teal vs green for "healthy").

**Left Accent Bar Pattern (Simple + Compact):** Use a `Container` with `BoxDecoration` and `borderRadius` on the left side only, positioned via `Row` or `Stack`:
```dart
Container(
  width: 5,
  decoration: BoxDecoration(
    color: _accentColor,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(cardRadius),
      bottomLeft: Radius.circular(cardRadius),
    ),
  ),
)
```

### Design Token Mapping (CRITICAL — NO hardcoded hex in widget code)

| Spec Value | Token | Usage |
|---|---|---|
| `#DCFCE7` | New: `AppColors.healthyFill` or inline `Color(0xFFDCFCE7)` in enum | Tile healthy bg |
| `#FEF3C7` | New: `AppColors.attentionFill` or inline `Color(0xFFFEF3C7)` in enum | Tile attention bg |
| `#FEE2E2` | New: `AppColors.urgentFill` or inline `Color(0xFFFEE2E2)` in enum | Tile urgent bg |
| `#F1F5F9` | New: `AppColors.unknownFill` or inline `Color(0xFFF1F5F9)` in enum | Tile unknown bg |
| `#16A34A` | `AppColors.healthyStatus` | Accent bar healthy |
| `#F59E0B` | `AppColors.attentionStatus` | Accent bar attention |
| `#DC2626` | `AppColors.urgentStatus` | Accent bar urgent |
| `#94A3B8` | New: `AppColors.unknownStatus` or inline | Accent bar unknown |
| `#A8A29E` | `AppColors.onSurfaceVariant` | Subtitle/timestamp text |
| `#1C1917` | `AppColors.onSurface` | Title text |
| `#F5F5F4` | Skeleton base color | Shimmer placeholder bg |
| `#EBEBEB` | Skeleton highlight color | Shimmer sweep |
| `rgba(0,0,0,0.06)` | `Colors.black.withValues(alpha: 0.06)` | Card shadow |

**Decision needed:** If `AppColors` doesn't have the fill/background status colors yet, add them to `AppColors` class in `packages/ui/lib/src/theme/app_colors.dart`. Check existing colors before adding. Use `.withValues(alpha: x)` NOT deprecated `.withOpacity(x)`.

### Typography Mapping

| Usage | Style |
|---|---|
| Hive name (Tile) | `AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600)` (15px SemiBold) |
| Hive name (Simple) | `AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.w600)` (16px SemiBold) |
| Hive name (Compact) | `AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600)` (15px SemiBold) |
| Last inspected (Tile) | `AppTypography.caption` (12px) with `AppColors.onSurfaceVariant` |
| Status summary (Simple) | `AppTypography.label` (13px) with `AppColors.onSurfaceVariant` |
| Timestamp + observation (Compact) | `AppTypography.label` (13px) with `AppColors.onSurfaceVariant` |

**Verify these mappings** against actual `AppTypography` class before using. The exact style names may differ — check `packages/ui/lib/src/theme/app_typography.dart`.

### Shimmer Animation Pattern (Copy from HivesLocationCard / PrimaryButton)

```dart
late AnimationController _shimmerController;
late Animation<double> _shimmerAnimation;

@override
void initState() {
  super.initState();
  _shimmerController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  );
  _shimmerAnimation = Tween<double>(begin: -0.5, end: 1.5).animate(
    CurvedAnimation(parent: _shimmerController, curve: Curves.linear),
  );
  if (widget.isLoading) _shimmerController.repeat();
}

@override
void didUpdateWidget(covariant MyCard oldWidget) {
  super.didUpdateWidget(oldWidget);
  if (widget.isLoading && !oldWidget.isLoading) {
    _shimmerController.repeat();
  } else if (!widget.isLoading && oldWidget.isLoading) {
    _shimmerController.stop();
    _shimmerController.reset();
  }
}

@override
void dispose() {
  _shimmerController.dispose();
  super.dispose();
}
```

### Project Structure Notes

**Files to create:**
```
packages/ui/lib/src/components/hives/
├── hives_hive_status.dart          # HivesHiveStatus enum + color mappings
├── hives_card_tile.dart            # HiveCardTile widget
├── hives_card_simple.dart          # HiveCardSimple widget
├── hives_card_compact.dart         # HiveCardCompact widget
├── hives_card_skeleton.dart        # HiveCardSkeleton widget
└── hives.dart                      # Barrel export

packages/ui/test/components/hives/
├── hive_card_tile_test.dart
├── hive_card_simple_test.dart
├── hive_card_compact_test.dart
└── hive_card_skeleton_test.dart

apps/storybook/lib/usecases/hives/
└── hive_card_usecases.dart
```

**Files to modify:**
```
packages/ui/lib/ui.dart             # Add: export 'src/components/hives/hives.dart';
packages/ui/lib/src/theme/app_colors.dart  # Add status fill colors if missing
```

**Export chain pattern (from story 1-12):**
```dart
// hives.dart barrel
export 'hives_hive_status.dart';
export 'hives_card_tile.dart';
export 'hives_card_simple.dart';
export 'hives_card_compact.dart';
export 'hives_card_skeleton.dart';

// ui.dart — add after locations export
export 'src/components/hives/hives.dart';
```

### Testing Standards (from story 1-12 patterns)

**Test setup:**
```dart
void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  group('HiveCardTile', () {
    Widget buildWidget(Widget child, {ThemeData? theme}) => MaterialApp(
      theme: theme ?? AppTheme.lightTheme,
      home: Scaffold(body: child),
    );
    // ... tests
  });
}
```

**Minimum tests per card type:**
1. Each status variant renders name + subtitle correctly
2. Loading state: no text visible, shimmer renders, no tap fires
3. `onTap` callback fires when tapped (not loading)
4. `onTap` blocked when `isLoading: true`
5. Dark mode renders without exception

**For HiveCardTile specifically:**
6. StatusBadge renders in top-right position
7. Hive icon placeholder renders

**For HiveCardSimple specifically:**
6. StatusBadge renders
7. Left accent bar renders with correct color

**For HiveCardSkeleton:**
1. Tile variant renders at correct size
2. Simple variant renders at correct size
3. Animation runs (pump + advance timer)

### Accessibility Requirements

- Add `semanticLabel` to all icons (learned from story 1-12 code review)
- Never rely on color alone — `StatusBadge` already uses icon+color
- For accent bars, the name + badge provide non-color context
- Minimum touch target 48px (`AppSpacing.touchTargetMin`)
- Ensure WCAG AA contrast (4.5:1) on tinted fill backgrounds

### Learnings from Previous Stories (1-10 through 1-12)

1. **H1:** Keep AC tasks up-to-date with actual implementation
2. **H2:** Maintain complete File List section with all created/modified files
3. **M1:** Add `semanticLabel` to ALL icons
4. **M2:** Only render `InkWell` when `onTap != null`
5. **M3:** Keep barrel exports current
6. **M4:** Test variant-specific details (icon assertions, not just smoke)
7. Use `.withValues(alpha: x)` NOT `.withOpacity(x)` (deprecated)
8. Use `const` constructors wherever possible
9. Prefer `switch` expressions over `if-else`
10. Check `didUpdateWidget()` for animation state transitions

### Cross-Story Context

**Consumers of these components (future stories):**
- Story 4.5 (Hive List Screen): Uses `HiveCardSimple` for location's hive list
- Story 4.7 (Hive Detail Screen): Uses `HiveCardTile` for dashboard context
- Story 7.1 (Dashboard Home): Uses `HiveCardTile` in 2-column grid below task hero
- Dashboard shows tiles in grid with 14px gap, 20px screen margin

**Parameters each card MUST accept (for future consumers):**
- `hiveName` (String) — hive display name
- `status` (HivesHiveStatus) — drives colors and badge
- `lastInspected` (String?) — formatted timestamp like "3 days ago"
- `statusSummary` (String?) — for Simple card: "Queenright - Brood good"
- `onTap` (VoidCallback?) — navigation callback
- `isLoading` (bool) — shows shimmer state

### References

- [Source: _bmad-output/planning-artifacts/epics.md#Story 1.13]
- [Source: _bmad-output/planning-artifacts/ux-design-specification.md#Hive Card Layouts]
- [Source: _bmad-output/planning-artifacts/architecture.md#UI Component Architecture]
- [Source: _bmad-output/planning-artifacts/prd.md#FR11-FR17 Hive Management]
- [Source: _bmad-output/implementation-artifacts/1-12-location-and-map-components.md#Dev Notes]
- [Source: packages/ui/lib/src/components/locations/hives_location_card.dart]
- [Source: packages/ui/lib/src/components/feedback/status_badge.dart]
- [Source: packages/ui/lib/src/theme/app_colors.dart]

## Change Log

- 2026-03-09: Implemented complete hive card component family (HiveCardTile, HiveCardSimple, HiveCardCompact, HiveCardSkeleton) with HivesHiveStatus enum, barrel exports, Widgetbook use cases, and comprehensive widget tests. All existing AppColors tokens reused — no new tokens needed.
- 2026-03-09: Code review fixes — conditional InkWell rendering in all three card widgets (M1); added `clipBehavior: Clip.antiAlias` to HiveCardCompact Material (M4); fixed misleading test assertion in hive_card_compact_test.dart (M5); documented undocumented file changes in File List (M2/M3); clarified task 7.3 approach (C1).

## Dev Agent Record

### Agent Model Used

Claude Opus 4.6

### Debug Log References

- All lint issues resolved: `sort_constructors_first` fixed by moving constructors before field declarations; `prefer_const_constructors` fixed in HiveCardSkeleton
- All existing `AppColors` tokens (healthyFill, attentionFill, urgentFill, unknownFill, healthyStatus, attentionStatus, urgentStatus, unknownStatus) were already present — no modifications to app_colors.dart needed
- Widgetbook use cases use direct variant props per use case rather than interactive knobs (consistent with existing location card use cases pattern)

### Completion Notes List

- Created `HivesHiveStatus` enum with `fillColor`, `accentColor`, and `badgeVariant` getters using switch expressions
- Implemented `HiveCardTile` (160x150px) with tinted fill background, 48px hexagon icon, StatusBadge top-right, shimmer loading
- Implemented `HiveCardSimple` (full-width x 110px) with 5px left accent bar, StatusBadge right, box shadow, shimmer loading
- Implemented `HiveCardCompact` (full-width x 80px) with 5px left accent bar, no badge, timestamp + observation, shimmer loading
- Implemented `HiveCardSkeleton` with tile (160x150) and simple (full x 110) variants, 1200ms shimmer animation
- All cards follow HivesLocationCard pattern: StatefulWidget + SingleTickerProviderStateMixin, AnimationController, didUpdateWidget, Material/InkWell
- All icons have semanticLabel for accessibility
- 33 widget tests covering all status variants, loading states, tap callbacks, dark mode
- 17 Widgetbook use cases: 5 per card type (4 statuses + loading) + 2 skeleton variants
- `dart analyze` passes with zero issues on all implementation files
- All 33 new tests + all existing tests pass (zero regressions)
- Widgetbook build_runner completed successfully

### File List

**New files:**
- packages/ui/lib/src/components/hives/hives_hive_status.dart
- packages/ui/lib/src/components/hives/hive_card_tile.dart
- packages/ui/lib/src/components/hives/hive_card_simple.dart
- packages/ui/lib/src/components/hives/hive_card_compact.dart
- packages/ui/lib/src/components/hives/hive_card_skeleton.dart
- packages/ui/lib/src/components/hives/hives.dart
- packages/ui/test/components/hives/hive_card_tile_test.dart
- packages/ui/test/components/hives/hive_card_simple_test.dart
- packages/ui/test/components/hives/hive_card_compact_test.dart
- packages/ui/test/components/hives/hive_card_skeleton_test.dart
- apps/storybook/lib/usecases/hives/hive_card_usecases.dart

**Modified files:**
- packages/ui/lib/ui.dart (added hives barrel export)
- apps/storybook/pubspec.yaml (added assets: - assets/ flutter section)
- apps/storybook/lib/main.directories.g.dart (auto-generated by build_runner, gitignored)

**New assets:**
- apps/storybook/assets/meadow_apiary.jpg (location card image, used by story 1-12 HivesLocationCard use case)
