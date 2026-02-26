---
stepsCompleted: [1, 2, 3, 4, 5, 6, 7, 8, 9]
inputDocuments:
  - prd.md
---

# UX Design Specification - hives

**Author:** Andreas
**Date:** 2026-02-15

---

## Executive Summary

### Project Vision

**hives** is a mobile app for hobbyist beekeepers (2-30 hives) to manage their apiaries efficiently. The core value proposition is: *know what to do, do it fast, never lose data*.

The app must work in field conditions - outdoors, often with gloves, in variable lighting, and frequently without network connectivity. Speed and reliability are paramount.

### Target Users

**Marcus - The Weekend Warrior**
- 6 hives in backyard, busy professional
- Inspects on Saturdays, needs to remember what's due
- Wants: Quick logging, clear task priorities

**Elena - The Growing Enthusiast**
- 18 hives across 3 locations
- Needs multi-location overview and route planning
- Wants: At-a-glance status, equipment tracking

**Tom - The New Beekeeper**
- 2 hives, just completed beekeeping course
- Learning what to track and when
- Wants: Easy onboarding, forgiving UX, build good habits

### Key Design Challenges

1. **Field Conditions UX** - Gloves, sunlight, one-handed operation require large tap targets, high contrast, and minimal precision
2. **Speed vs. Completeness** - 30-second inspection goal with multiple data points requires smart UI patterns
3. **Offline-First Trust** - Clear sync status without creating data loss anxiety
4. **Scalable Complexity** - Works for Tom's 2 hives and Elena's 18 across 3 locations
5. **Flexible Data Entry** - Different beekeepers track different things without overwhelming options

### Design Opportunities

1. **Glanceable Dashboard** - Single screen answering "What needs attention?" as key differentiator
2. **Smart Defaults & Quick Actions** - "All good" quick inspection pattern for speed
3. **Visual Status Language** - Color-coded status (green/yellow/red) for instant awareness
4. **Progressive Disclosure** - Simple defaults that reveal depth as users grow

## Core User Experience

### Defining Experience

The core experience of **hives** is the **30-Second Inspection**. This is the atomic unit of value - everything else in the app exists to support, inform, or result from inspection logging.

The inspection flow must be: Tap hive → Log observations → Done. No loading screens, no required fields, no friction.

### Platform Strategy

- **Framework:** Flutter (iOS + Android cross-platform)
- **Input Mode:** Touch-first, one-handed operation, glove-friendly
- **Connectivity:** Offline-first architecture - full functionality without network
- **Device Features:** Camera (photo attachment), Location (map pins), Push (reminders)

### Effortless Interactions

| Interaction | Design Goal |
|-------------|-------------|
| Start inspection | Tap hive → immediately logging (zero load time) |
| Quick capture | Tap-based inputs, no typing for common observations |
| "All good" path | Single gesture when nothing notable |
| Sync | Invisible, automatic, no user action required |
| Photo attach | Snap and continue, upload queues silently |

### Critical Success Moments

1. **First Inspection Complete** - New user finishes first log in under 30 seconds, feels "I can do this"
2. **Memory Payoff** - Returning user sees last week's notes, realizes value of logging
3. **Multi-Location Clarity** - User with multiple apiaries sees full picture in one glance

### Experience Principles

1. **Speed is Sacred** - Every tap must earn its place
2. **Offline is the Default** - Design for no connectivity
3. **Glanceable, Not Readable** - Status via color/icons, not text
4. **Flexible Depth** - Simple surface, depth when needed
5. **Trust Through Transparency** - Always show sync status

## Desired Emotional Response

### Primary Emotional Goals

| Emotion | User Experience |
|---------|-----------------|
| **In Control** | Users feel they have complete visibility over their operation - nothing is forgotten, nothing is missed |
| **Confident** | Trust that data is safe regardless of connectivity - no anxiety about loss |
| **Efficient** | Logging feels instant - users finish before they realize they started |
| **Calm** | The mental burden of remembering shifts to the app - users can relax |

### Emotional Journey Mapping

| Stage | Desired Emotion |
|-------|-----------------|
| First Launch | Welcomed, not overwhelmed - "This is simple, I can do this" |
| During Inspection | Focused, fast - "Just tap and go" |
| After Logging | Accomplished - "Done. That was easy." |
| Returning Next Week | Confident - "It remembered everything for me" |
| Offline Operation | Trusting - "It's working, I don't need to worry" |
| Sync Complete | Reassured - "Everything is backed up" |

### Emotions to Avoid

- **Anxiety** - "Did it save?" → Always show save confirmation
- **Overwhelm** - "Too many options" → Progressive disclosure, smart defaults
- **Frustration** - "This is slow" → Instant response, no loading screens
- **Doubt** - "Am I doing this right?" → Forgiving inputs, no wrong answers

### Emotional Design Principles

1. **Instant Feedback** - Every action immediately acknowledged (haptic, visual)
2. **Visible State** - Sync status always clear, never hidden
3. **Forgiveness** - No required fields, easy to edit, undo available
4. **Celebration** - Subtle positive reinforcement when tasks complete
5. **Quiet Confidence** - App works reliably without demanding attention

## UX Pattern Analysis & Inspiration

### Inspiring Products Analysis

**Yazioo**
- Intuitive, self-explanatory interface
- No learning curve - actions are discoverable
- *Lesson:* UI should teach itself; if users need a tutorial, we've failed

**ING Banking App**
- Modern design language with professional aesthetics
- Dashboard-first: full picture at a glance
- User feels in control of their data
- *Lesson:* Glanceable overview builds confidence; modern design signals trust

**Padelcity**
- Smooth animations and transitions
- Contemporary visual polish
- Premium feel without complexity
- *Lesson:* Motion and polish signal quality; invest in visual details

### Transferable UX Patterns

**Kanban-Style Task Flow**
- Inspired by developer workflows
- Visual columns: "Needs Attention" → "Scheduled" → "Done"
- Hives/tasks move through stages visually
- Status visible at a glance across entire operation
- *Application:* Dashboard could show hive cards flowing through attention states

**Dashboard-First Navigation**
- ING pattern: land on overview, drill into details
- Answer "What needs attention?" before anything else
- *Application:* Home screen = prioritized action list, not hive list

**Progressive Disclosure**
- Yazioo pattern: simple surface, depth when needed
- Start minimal, reveal options contextually
- *Application:* Quick inspection = 3 taps; detailed inspection = expand sections

### Anti-Patterns to Avoid

| Anti-Pattern | Seen In | Our Alternative |
|--------------|---------|-----------------|
| Dated visual design | Beekeeper, Stockkarte | Modern Material 3 / iOS native feel |
| Complicated inspections | Competitors | Quick-tap defaults, optional depth |
| Option overload | Competitors | Smart defaults, progressive disclosure |
| Required fields | Many apps | Everything optional, save partial data |
| Tutorials/onboarding walls | Many apps | Self-explanatory UI, learn by doing |

### Design Inspiration Strategy

**Adopt:**
- Modern visual language (ING, Padelcity aesthetic)
- Dashboard-first navigation (ING)
- Self-explanatory interactions (Yazioo)

**Adapt:**
- Kanban visualization → Hive status flow (simpler than full kanban)
- Banking "control" feeling → Applied to hive data ownership

**Avoid:**
- Competitor complexity and dated aesthetics
- Feature-richness that sacrifices speed
- Any pattern that adds taps to the inspection flow

## Design System Foundation

### Design System Choice

**Material Design 3 with Custom Theming**

Flutter's native Material 3 implementation with extensive customization for a modern, friendly brand identity. The design system emphasizes generous corner radii, subtle shadows, and the Poppins typeface throughout.

### Rationale for Selection

| Factor | Decision Driver |
|--------|-----------------|
| Development Speed | M3 built into Flutter - no additional dependencies |
| Modern Aesthetic | Custom M3 styling matches inspiration apps (ING, Padelcity) |
| Cross-Platform | Consistent look on iOS and Android |
| Accessibility | WCAG compliance built-in (large touch targets, contrast ratios) |
| Field Conditions | Supports high contrast, large tap targets for glove use |
| Customization | Full theming support for unique brand identity |

### Implementation Approach

- Use Flutter's `ThemeData` with Material 3 (`useMaterial3: true`)
- Define custom `ColorScheme` with warm amber primary
- Configure custom `TextTheme` using **Poppins** font family
- Override component themes for extra-rounded corners (14-20px vs M3 default 12px)
- Implement subtle shadow system with colored glows on primary actions
- Support future dark mode with semantic color tokens

### Component Shape Language

| Component | Corner Radius | Notes |
|-----------|---------------|-------|
| Buttons | 14px | Pill-like, friendly feel |
| Cards | 18-20px | Extra rounded, modern aesthetic |
| Inputs | 12px | Slightly less rounded for form context |
| Badges | 10px | Compact pill shape |
| Bottom Nav | 0px (top) | Clean edge against screen bottom |

### Shadow System

Modern, subtle shadows that provide depth without heaviness:

| Component | Shadow | Purpose |
|-----------|--------|---------|
| Cards | `0 3px 12px rgba(0,0,0,0.05)` | Gentle lift |
| Elevated Cards | Dual: `0 4px 16px 6%` + `0 1px 4px 4%` | Layered depth |
| Primary Button | `0 4px 12px rgba(primary,0.25)` | Colored glow, draws attention |
| Bottom Nav | `0 -2px 12px rgba(0,0,0,0.08)` | Upward shadow, anchors UI |

### Motion & Feedback

- **Transitions:** Quick, purposeful (200-300ms)
- **Haptics:** Light impact on button press, success on save
- **Micro-animations:** Subtle scale on tap (0.98), smooth color transitions
- **Loading:** Skeleton screens, never spinners (speed perception)

## Defining Experience

### The Core Interaction

**"Log an inspection in 30 seconds, even offline"**

This is what users will tell other beekeepers. This is the interaction that, if nailed, makes everything else follow. The entire app exists to enable, support, and benefit from this core loop.

### User Mental Model

**How users think about inspections:**
- A checklist, not a form - tap to confirm, not fill fields
- Each observation is independent - no need to complete everything
- Paper notebook mental model - jot what matters, skip what doesn't
- Data saves as you go - no "submit" anxiety

**Current solutions (paper, competitors):**
- Paper: Flexible but forgettable, hard to review history
- Competitors: Too many fields, feels like data entry, not beekeeping

**Our advantage:** Feel like a smart checklist, not a database form

### Success Criteria

| Criteria | Target |
|----------|--------|
| Time to complete basic inspection | < 30 seconds |
| Taps required for "all good" inspection | ≤ 5 taps |
| Required fields | Zero - everything optional |
| Loading/waiting time | 0ms - instant response |
| Offline functionality | 100% - no feature degradation |
| Data persistence | Auto-save on every tap |

### Experience Mechanics

**Phase 1: Initiation**
- User sees hive card on dashboard flagged "needs attention"
- Taps hive → instantly lands on hive detail
- "Log Inspection" button prominent and inviting

**Phase 2: Quick Capture**
- Inspection screen opens instantly (no loading)
- Date pre-filled to today
- Status buttons arranged for quick tapping:
  - Queenright: ✓ / ? / ✗
  - Brood: Good / Fair / Poor
  - Bees: Strong / Normal / Weak
  - Reserves: Full / OK / Low
- Each tap immediately saves with subtle confirmation

**Phase 3: Optional Depth**
- Expandable sections (collapsed by default):
  - Varroa observations
  - Illness notes
  - Behavior notes
  - Free text notes
  - Photo attachment
- User can skip entirely or dive deep

**Phase 4: Completion**
- "Done" button or simply navigate away
- Success feedback (haptic + visual)
- If reserves marked "Low" → Task auto-generates: "Feed hive"
- Return to dashboard with updated status

### Novel UX Patterns

**Pattern: Tap-to-Log (not Fill-to-Submit)**
- Established pattern: Form with fields → Submit button
- Our pattern: Each tap = saved observation
- Familiar metaphor: Tapping checkboxes on a checklist
- No submit step, no save button, no "are you sure?" dialogs

**Pattern: Progressive Disclosure for Speed**
- Established pattern: Show all fields upfront
- Our pattern: Essential options visible, details expandable
- Keeps screen clean for quick path, depth available when needed

## Visual Design Foundation

### Color System

**Brand Palette:**
- Primary: Golden Amber `#F59E0A` - Primary actions, brand identity
- Primary Dark: Deep Amber `#D97706` - Headers, pressed states
- Surface: Pure White `#FFFFFF` - Cards, elevated surfaces
- Background: Warm White `#FAFAFA` - Main background
- On Surface: Warm Black `#1F1A17` - Primary text
- On Surface Variant: Warm Gray `#B3ADA8` - Placeholder text, hints
- Outline: Light Cream `#EDE8E3` - Borders, dividers

**Status Colors:**
- Healthy: Vibrant Green `#21C45E` - Thriving hives, success states
- Attention: Warm Yellow `#FFB821` - Needs checking, warnings
- Urgent: Alert Red `#F04545` - Immediate action needed
- Unknown: Cool Gray `#8C94A1` - Unconfirmed status

**Status Color Application:**
- **Hive Cards:** 4px vertical status bar on left edge
- **Badges:** Solid fill with white text
- **Icons:** Filled status color with white icon

### Typography System

**Font Family:** Poppins (Google Fonts)
- Modern geometric sans-serif
- Excellent readability in outdoor conditions
- Friendly, approachable character

**Type Scale:**

| Role | Size | Weight | Use Case |
|------|------|--------|----------|
| Display | 28px | SemiBold | Dashboard hero numbers |
| Title Large | 20px | SemiBold | Screen titles |
| Title Medium | 17px | SemiBold | Card titles, section headers |
| Body Large | 16px | Regular | Primary content |
| Body Medium | 15px | Regular | Buttons, inputs |
| Label | 13px | Medium | Badges, captions |
| Caption | 12px | Regular | Timestamps, hints |

**Letter Spacing:**
- Buttons: +0.3px (slightly expanded for readability)
- Body: 0px (default)
- Captions: +0.2px

### Spacing & Layout Foundation

**Base Unit:** 4px (allows finer control than 8px)

**Component Spacing:**

| Context | Value | Use |
|---------|-------|-----|
| Card Padding | 18-20px | Internal card content |
| Button Padding | 0 × 28px | Horizontal button padding |
| Item Spacing | 10-14px | Between list items |
| Section Gap | 24px | Between content sections |
| Screen Margin | 16px | Edge padding |

**Touch Targets:**
- Minimum: 48px (exceeds 44px accessibility standard)
- Buttons: 52px height (comfortable for gloved hands)
- Cards: Full width tap targets

### Button Variants

| Type | Fill | Border | Shadow | Use |
|------|------|--------|--------|-----|
| Primary | `#F59E0A` | None | Colored glow | Main actions |
| Secondary | White | 1.5px `#EDE8E3` | None | Secondary actions |
| Ghost | Transparent | None | None | Tertiary, cancel |

### Card Components

The card system provides three layout variants for both Hive and Task cards, allowing flexible use across different contexts.

#### Card Layout Overview

| Layout | Height | Use Case |
|--------|--------|----------|
| **Image** | 200-220px | Dashboard hero cards, detail views |
| **Simple** | 110-120px | Lists without photos, medium density |
| **Compact** | 80-90px | High-density lists, task lists |

---

#### Hive Card Image

Inspired by modern booking card patterns. Large photo area with minimal text below.

```
┌─────────────────────────────┐
│ ┌─────────────────────────┐ │
│ │                         │ │  ← 130px image area
│ │      [HIVE PHOTO]       │ │    Rounded top corners
│ │                         │ │
│ └─────────────────────────┘ │
│ ● Hive Name            ✓   │  ← Status dot + badge
│   Queenright • Brood good  │  ← Status summary
│   3 days ago               │  ← Timestamp
└─────────────────────────────┘
```

**Specifications:**

| Property | Value |
|----------|-------|
| Size | 329 × 220px |
| Corner Radius | 18px |
| Image Area | 130px height |
| Shadow | `0 3px 12px rgba(0,0,0,0.05)` |
| Variants | 8 (4 statuses × Photo true/false) |

**Photo=false Fallback:**
- Warm gradient background (`#FEF3C7` → `#FDE68A`)
- "📷 Tap to add photo" hint centered

---

#### Hive Card Simple

No photo area. Colored accent bar at top indicates status. Same content layout as Image variant.

```
┌─────────────────────────────┐
│▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀│  ← 4px colored accent bar
│ ● Hive Name            ✓   │  ← Status dot + badge
│   Queenright • Brood good  │  ← Status summary
│   Last inspected 3 days ago│  ← Timestamp
└─────────────────────────────┘
```

**Specifications:**

| Property | Value |
|----------|-------|
| Size | 329 × 120px |
| Corner Radius | 18px |
| Accent Bar | 4px height, status color |
| Variants | 4 (Healthy, Attention, Urgent, Unknown) |

---

#### Hive Card Compact

Horizontal layout for dense lists. Status bar on left edge.

```
┌─────────────────────────────────────┐
│▌● Hive Name                    ✓   │  ← 4px status bar (left)
│▌  Queenright • Brood good          │
│▌  3 days ago                       │
└─────────────────────────────────────┘
```

**Specifications:**

| Property | Value |
|----------|-------|
| Size | 320 × 88px |
| Corner Radius | 14px |
| Status Bar | 4px width, left edge |
| Variants | 4 (Healthy, Attention, Urgent, Unknown) |

---

#### Hive Card Skeleton

Loading state with shimmer animation placeholders.

```
┌─────────────────────────────┐
│ ░░░░░░░░░░░░░░░░░░░░░░░░░░ │  ← Gray shimmer (#EDEDED)
│ ░░░░░░░░░░░░░░░░░░░░░░░░░░ │    1.5s animation loop
│ ░░░░░░░░░░░░░░░░░░░░░░░░░░ │
│ ░░░░░░░░░░░░░░             │
│ ░░░░░░░░░░░░░░░░░░         │
│ ░░░░░░░░░░                 │
└─────────────────────────────┘
```

---

#### Task Card Image

Photo at top showing associated hive. Priority indicator with due date.

```
┌─────────────────────────────┐
│ ┌─────────────────────────┐ │
│ │     [HIVE PHOTO]        │ │  ← 110px image area
│ └─────────────────────────┘ │
│ ● Feed Hive                │  ← Priority dot + task title
│   Hive: Sunny              │  ← Associated hive
│   Due today                │  ← Due date (priority color)
└─────────────────────────────┘
```

**Specifications:**

| Property | Value |
|----------|-------|
| Size | 329 × 200px |
| Corner Radius | 18px |
| Image Area | 110px height |
| Variants | 6 (3 priorities × Photo true/false) |

---

#### Task Card Simple

No photo area. Colored accent bar at top. Checkbox for completion.

```
┌─────────────────────────────┐
│▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀│  ← 4px colored accent bar
│ ● Feed Hive            ☐   │  ← Priority dot + checkbox
│   Hive: Sunny              │  ← Associated hive
│   Due today                │  ← Due date (priority color)
└─────────────────────────────┘
```

**Specifications:**

| Property | Value |
|----------|-------|
| Size | 329 × 110px |
| Corner Radius | 18px |
| Accent Bar | 4px height, priority color |
| Checkbox | 22 × 22px, 6px radius |
| Variants | 3 (High, Normal, Low) |

---

#### Task Card Compact

Horizontal layout for task lists. Priority bar on left, checkbox on right.

```
┌─────────────────────────────────────┐
│▌● Feed Hive                    ☐   │  ← Priority bar (left)
│▌  Hive: Sunny                      │    Checkbox (right)
│▌  Due today                        │
└─────────────────────────────────────┘
```

**Specifications:**

| Property | Value |
|----------|-------|
| Size | 320 × 80px |
| Corner Radius | 14px |
| Priority Bar | 4px width, left edge |
| Checkbox | 22 × 22px |
| Variants | 3 (High, Normal, Low) |

---

#### Status & Priority Colors

**Hive Status:**
| Status | Color | Hex | Badge |
|--------|-------|-----|-------|
| Healthy | Green | `#21C45E` | ✓ |
| Attention | Amber | `#FFB821` | ! |
| Urgent | Red | `#F04545` | !! |
| Unknown | Gray | `#8C94A1` | ? |

**Task Priority:**
| Priority | Color | Hex | Due Label |
|----------|-------|-----|-----------|
| High | Red | `#F04545` | Due today |
| Normal | Amber | `#FFB821` | Due in X days |
| Low | Gray | `#8C94A1` | No due date |

---

#### Card Selection Guidelines

| Context | Recommended Card |
|---------|------------------|
| Dashboard (few items) | Image or Simple |
| Dashboard (many items) | Simple or Compact |
| Detail/Edit screens | Image |
| Task lists | Simple or Compact |
| Location hive lists | Compact |
| Search results | Compact |

### Accessibility Considerations

- All text: WCAG AA contrast (4.5:1+) - verified with warm black on white
- Status: Icons accompany colors (not color-only)
- Touch: 48-52px targets exceed accessibility minimum
- Outdoor: Poppins SemiBold + high contrast for bright conditions
- Color blindness: Status uses position (left bar) + icon, not just color

## Design Direction Decision

### Design Directions Explored

Six distinct visual approaches were generated and evaluated:

1. **Card Dashboard** - Classic card-based with summary stats and hive cards
2. **Kanban Flow** - Horizontal status columns (Urgent → Check → Good)
3. **Map Focus** - Map-first for multi-location users
4. **List Compact** - Dense, filterable list view
5. **Task First** - Task-oriented "what to do today" approach
6. **Minimal** - Ultra-clean with core numbers only

Interactive mockups: `ux-design-directions.html`

### Chosen Direction

**Hybrid: Task-Led Card Dashboard**

Combines the action-oriented entry of Direction 5 (Task First) with the visual richness of Direction 1 (Card Dashboard).

### Design Rationale

| Decision | Rationale |
|----------|-----------|
| Task hero section at top | Answers "what do I do today?" immediately - Marcus's core need |
| Hive cards below | Provides visual overview for status checking - Elena's need |
| Both views on one screen | No mode switching, progressive scroll reveals depth |
| Bottom navigation | Standard mobile pattern, quick access to Locations, Tasks, Settings |

### Implementation Approach

**Home Screen Structure:**
```
┌─────────────────────────┐
│     Status Bar          │
├─────────────────────────┤
│  Today: 3 tasks         │  ← Task hero (Direction 5)
│  2 hives need attention │
├─────────────────────────┤
│  [Task Card] Hive 5     │  ← Priority tasks
│  [Task Card] Hive 8     │
├─────────────────────────┤
│  Your Hives             │  ← Section header
│  [Hive Card] Status     │  ← Hive cards (Direction 1)
│  [Hive Card] Status     │
│  [Hive Card] Status     │
├─────────────────────────┤
│  🏠  📍  ✓  ⚙️          │  ← Bottom nav
└─────────────────────────┘
```

**Navigation Pattern:**
- Home (task-led dashboard)
- Locations (map view for multi-location)
- Tasks (full task list)
- Settings
