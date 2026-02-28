---
stepsCompleted: [1, 2, 3, 4, 5, 6, 7, 8, 9]
inputDocuments:
  - prd.md
---

# UX Design Specification - hives

**Author:** Andreas
**Date:** 2026-02-15
**Revision:** Design refresh — modern vibrant direction

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
3. **Visual Status Language** - Bold color-coded cards with illustrated icons for instant awareness
4. **Progressive Disclosure** - Simple defaults that reveal depth as users grow
5. **Personality Through Visual Polish** - Vibrant, illustrated UI that feels premium and joyful, not clinical

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
| **Delighted** | The app feels premium and alive — not a dull utility, but a tool they enjoy opening |

### Emotional Journey Mapping

| Stage | Desired Emotion |
|-------|-----------------|
| First Launch | Welcomed, not overwhelmed - "This is beautiful and simple" |
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
- **Boredom** - "This feels like a spreadsheet" → Vibrant colors, illustrated icons, personality

### Emotional Design Principles

1. **Instant Feedback** - Every action immediately acknowledged (haptic, visual)
2. **Visible State** - Sync status always clear, never hidden
3. **Forgiveness** - No required fields, easy to edit, undo available
4. **Celebration** - Positive reinforcement with animated micro-interactions when tasks complete
5. **Quiet Confidence** - App works reliably without demanding attention
6. **Visual Joy** - Bold colors, friendly illustrations, and polished motion make every screen feel crafted

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

**Eduly (Design Inspiration)**
- Bold, multi-color palette with vibrant accent backgrounds on cards
- Large rounded corners (24px+) creating a soft, modern, friendly feel
- Illustrated icon language — not flat line icons, but colorful mini-illustrations
- Prominent floating bottom navigation with elevated center action button
- Circular progress indicators for at-a-glance status
- Grid-based category layouts with icon + label cards
- Generous white space paired with bold section headers
- Playful personality without sacrificing clarity
- *Lesson:* A vibrant, illustrated visual language can make a utility app feel premium and delightful. Bold color blocks on cards create visual hierarchy without complexity.

### Transferable UX Patterns

**Bold Card Backgrounds (Eduly Pattern)**
- Cards use vibrant fill colors instead of plain white
- Each category/status gets its own color identity
- Creates instant visual differentiation without reading labels
- *Application:* Hive status cards use bold background fills — green card = healthy, amber card = attention needed, etc.

**Circular Progress / Status Rings (Eduly Pattern)**
- Progress shown as radial rings or arcs
- Compact, glanceable, and visually engaging
- *Application:* Dashboard hero area shows circular inspection progress — "4 of 6 hives inspected this week"

**Grid Category Cards with Illustrated Icons (Eduly Pattern)**
- Subjects/categories displayed as a grid of icon + label cards
- Rounded, colorful, tap-friendly tiles
- *Application:* Hive selection grid on dashboard — each hive as a colorful tile with an illustrated bee/hive icon and status indicator

**Elevated Center Navigation Action (Eduly Pattern)**
- Bottom nav bar with a visually elevated center button (FAB-style)
- Center button is the most important action
- *Application:* Center bottom nav button = "Quick Inspect" — instant access to start an inspection from anywhere

**Dashboard-First Navigation**
- ING pattern: land on overview, drill into details
- Answer "What needs attention?" before anything else
- *Application:* Home screen = prioritized action list with vibrant status cards

**Progressive Disclosure**
- Yazioo pattern: simple surface, depth when needed
- Start minimal, reveal options contextually
- *Application:* Quick inspection = 3 taps; detailed inspection = expand sections

### Anti-Patterns to Avoid

| Anti-Pattern | Seen In | Our Alternative |
|--------------|---------|-----------------|
| Dated visual design | Beekeeper, Stockkarte | Bold modern aesthetic with vibrant colors and illustrations |
| Monochrome / clinical | Many utility apps | Multi-color palette with personality |
| Flat, lifeless cards | Competitors | Colorful card backgrounds with illustrated icons |
| Small, dense UI | Competitors | Generous spacing, large tap targets, bold type |
| Complicated inspections | Competitors | Quick-tap defaults, optional depth |
| Option overload | Competitors | Smart defaults, progressive disclosure |
| Required fields | Many apps | Everything optional, save partial data |
| Tutorials/onboarding walls | Many apps | Self-explanatory UI, learn by doing |

### Design Inspiration Strategy

**Adopt:**
- Bold vibrant color palette with colored card fills (Eduly)
- Illustrated icon language over line icons (Eduly)
- Elevated center action in bottom navigation (Eduly)
- Circular progress indicators for dashboard hero (Eduly)
- Large rounded corners 24px+ (Eduly, Padelcity)
- Dashboard-first navigation (ING)
- Self-explanatory interactions (Yazioo)

**Adapt:**
- Grid category layout → Hive selection tiles with status colors
- Circular progress chart → Weekly inspection completion ring
- Bold colored cards → Status-coded hive cards (green/amber/red fills)
- Leaderboard pattern → Hive ranking by urgency (most urgent first)

**Avoid:**
- Competitor complexity and dated aesthetics
- Feature-richness that sacrifices speed
- Clinical, monochrome, lifeless UI
- Any pattern that adds taps to the inspection flow

## Design System Foundation

### Design System Choice

**Material Design 3 with Bold Custom Theming**

Flutter's native Material 3 implementation with extensive customization for a vibrant, friendly, illustrated brand identity. The design system emphasizes extra-generous corner radii, bold color fills, illustrated icons, and the Poppins typeface throughout.

### Rationale for Selection

| Factor | Decision Driver |
|--------|-----------------|
| Development Speed | M3 built into Flutter - no additional dependencies |
| Modern Aesthetic | Heavily customized M3 to match bold illustrated style (Eduly, Padelcity) |
| Cross-Platform | Consistent look on iOS and Android |
| Accessibility | WCAG compliance built-in (large touch targets, contrast ratios) |
| Field Conditions | Supports high contrast, large tap targets, bold colors visible in sunlight |
| Customization | Full theming support for vibrant brand identity |

### Implementation Approach

- Use Flutter's `ThemeData` with Material 3 (`useMaterial3: true`)
- Define custom `ColorScheme` with warm amber primary and vibrant multi-color accent palette
- Configure custom `TextTheme` using **Poppins** font family with bold weights
- Override component themes for extra-rounded corners (20-28px vs M3 default 12px)
- Implement vibrant card background fills with subtle gradients
- Use illustrated icon set (custom SVGs) over standard Material Icons
- Implement elevated center FAB in bottom navigation
- Support future dark mode with semantic color tokens

### Component Shape Language

| Component | Corner Radius | Notes |
|-----------|---------------|-------|
| Buttons | 16px | Rounded pill-like, friendly feel |
| Cards | 22-28px | Extra rounded, bold modern aesthetic |
| Status Cards | 24px | Generous radius with colored fills |
| Inputs | 14px | Slightly less rounded for form context |
| Badges / Chips | 12px | Compact pill shape |
| Bottom Nav | 0px (top), 28px (center FAB) | Clean edge with elevated center button |
| Modal Sheets | 28px (top corners) | Soft sheet appearance |
| Image Containers | 20px | Rounded image areas within cards |

### Shadow System

Modern, expressive shadows with colored glows for key interactive elements:

| Component | Shadow | Purpose |
|-----------|--------|---------|
| Cards | `0 4px 16px rgba(0,0,0,0.06)` | Gentle lift |
| Elevated Cards | Dual: `0 6px 20px 6%` + `0 2px 6px 4%` | Layered depth |
| Primary Button | `0 6px 16px rgba(primary,0.30)` | Bold colored glow, draws attention |
| Center FAB | `0 8px 24px rgba(primary,0.35)` | Strong elevation, hero action |
| Bottom Nav | `0 -4px 16px rgba(0,0,0,0.08)` | Upward shadow, anchors UI |
| Status Badge | `0 2px 8px rgba(statusColor,0.25)` | Subtle colored glow matching status |

### Illustrated Icon Language

Instead of standard Material line icons, hives uses a custom **illustrated icon set** with the following characteristics:

- **Style:** Filled, colorful mini-illustrations (2-3 colors per icon)
- **Size:** 28-36px for navigation, 48-56px for category tiles
- **Palette:** Each icon uses its contextual color (e.g., green for healthy, amber for warning)
- **Examples:**
  - 🐝 Hive icon: Illustrated beehive with subtle honey drip
  - 📋 Inspection icon: Clipboard with checkmark
  - 📍 Location icon: Map pin with bee silhouette
  - ⚠️ Alert icon: Illustrated warning sign
  - ✅ Success icon: Filled green circle with animated checkmark
- **Production:** Custom SVG set, exported from Figma, rendered via `flutter_svg`

### Motion & Feedback

- **Transitions:** Quick, expressive (200-350ms), with spring-based easing for a lively feel
- **Haptics:** Light impact on button press, medium success on save, notification on alerts
- **Micro-animations:**
  - Subtle scale on tap (0.96 → 1.0 with spring)
  - Color transitions on status changes (smooth 300ms crossfade)
  - Circular progress ring fills on dashboard load
  - Card entrance: staggered fade-up (50ms delay per card)
  - Success state: animated checkmark draw + confetti particles (subtle)
- **Loading:** Skeleton screens with shimmer animation, never spinners
- **Navigation:** Shared element transitions between hive card → hive detail

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
- Competitors: Too many fields, feels like data entry, not beekeeping — visually outdated and clinical

**Our advantage:** Feel like a smart checklist, not a database form — wrapped in a UI that's a pleasure to use

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
- User sees hive tile on dashboard with colored status fill ("needs attention" = amber card)
- Taps hive → instantly lands on hive detail with shared element transition
- "Log Inspection" button prominent — bold primary color with colored glow shadow

**Phase 2: Quick Capture**
- Inspection screen opens instantly (no loading) with staggered section entrance
- Date pre-filled to today
- Status buttons arranged as bold colored chips for quick tapping:
  - Queenright: ✓ / ? / ✗ (green / gray / red chip)
  - Brood: Good / Fair / Poor (green / amber / red chip)
  - Bees: Strong / Normal / Weak (green / amber / red chip)
  - Reserves: Full / OK / Low (green / amber / red chip)
- Each tap immediately saves with subtle haptic + animated checkmark

**Phase 3: Optional Depth**
- Expandable sections (collapsed by default) with smooth reveal animation:
  - Varroa observations
  - Illness notes
  - Behavior notes
  - Free text notes
  - Photo attachment
- User can skip entirely or dive deep

**Phase 4: Completion**
- "Done" button or simply navigate away
- Success feedback: haptic + animated success illustration (small bee animation)
- If reserves marked "Low" → Task auto-generates with amber card: "Feed hive"
- Return to dashboard with updated status color (card animates to new color)

### Novel UX Patterns

**Pattern: Tap-to-Log (not Fill-to-Submit)**
- Established pattern: Form with fields → Submit button
- Our pattern: Each tap = saved observation, visualized as colored chip selections
- Familiar metaphor: Tapping checkboxes on a checklist
- No submit step, no save button, no "are you sure?" dialogs

**Pattern: Progressive Disclosure for Speed**
- Established pattern: Show all fields upfront
- Our pattern: Essential options visible as bold colored chips, details in expandable drawers
- Keeps screen clean for quick path, depth available when needed

**Pattern: Color-Coded Card Identity**
- Established pattern: White cards with small status indicators
- Our pattern: Entire card background takes on status color (tinted fill)
- Status is immediately obvious from color alone, even in bright sunlight

## Visual Design Foundation

### Color System

**Brand Palette:**
- Primary: Golden Amber `#F59E0A` - Primary actions, brand identity, center FAB
- Primary Dark: Deep Amber `#D97706` - Headers, pressed states
- Primary Light: Warm Cream `#FEF3C7` - Primary tinted backgrounds
- Secondary: Rich Purple `#8B5CF6` - Accent actions, secondary highlights
- Secondary Light: Soft Lavender `#EDE9FE` - Secondary tinted backgrounds
- Surface: Pure White `#FFFFFF` - Base cards, elevated surfaces
- Background: Warm White `#FAFAF8` - Main background
- On Surface: Warm Black `#1C1917` - Primary text (bolder than before)
- On Surface Variant: Warm Gray `#A8A29E` - Placeholder text, hints
- Outline: Light Warm `#E7E5E4` - Borders, dividers

**Status Colors (Bold Palette):**
- Healthy: Vibrant Green `#22C55E` - Thriving hives, success states
- Healthy Fill: `#DCFCE7` - Tinted green card background
- Attention: Rich Amber `#F59E0B` - Needs checking, warnings
- Attention Fill: `#FEF3C7` - Tinted amber card background
- Urgent: Bold Red `#EF4444` - Immediate action needed
- Urgent Fill: `#FEE2E2` - Tinted red card background
- Unknown: Cool Slate `#94A3B8` - Unconfirmed status
- Unknown Fill: `#F1F5F9` - Tinted gray card background

**Accent Palette (for variety and visual interest):**
- Teal: `#14B8A6` / Light: `#CCFBF1` - Location/map features
- Blue: `#3B82F6` / Light: `#DBEAFE` - Information, sync indicators
- Purple: `#8B5CF6` / Light: `#EDE9FE` - Insights, statistics
- Orange: `#F97316` / Light: `#FED7AA` - Seasonal reminders

**Status Color Application:**
- **Hive Cards:** Full card background uses tinted status fill color with bold status icon
- **Status Badge:** Solid fill circle with white icon (e.g., green circle + white ✓)
- **Dashboard Tiles:** Colored tile backgrounds matching hive status
- **Chips:** Bold filled chips for inspection options (green/amber/red)

### Typography System

**Font Family:** Poppins (Google Fonts)
- Modern geometric sans-serif
- Excellent readability in outdoor conditions
- Friendly, approachable character

**Type Scale (Updated for Bold Modern Feel):**

| Role | Size | Weight | Use Case |
|------|------|--------|----------|
| Display | 32px | Bold | Dashboard hero numbers, greeting |
| Title Large | 22px | SemiBold | Screen titles |
| Title Medium | 18px | SemiBold | Card titles, section headers |
| Body Large | 16px | Medium | Primary content (medium weight for legibility) |
| Body Medium | 15px | Regular | Buttons, inputs |
| Label | 13px | SemiBold | Badges, captions, chip labels |
| Caption | 12px | Medium | Timestamps, hints |

**Letter Spacing:**
- Display: -0.5px (tighter for large text)
- Buttons: +0.3px (slightly expanded for readability)
- Body: 0px (default)
- Captions: +0.2px

### Spacing & Layout Foundation

**Base Unit:** 4px (allows finer control than 8px)

**Component Spacing:**

| Context | Value | Use |
|---------|-------|-----|
| Card Padding | 20-24px | Internal card content (generous) |
| Button Padding | 0 × 32px | Horizontal button padding |
| Item Spacing | 12-16px | Between list items |
| Section Gap | 28px | Between content sections (more breathing room) |
| Screen Margin | 20px | Edge padding (wider than standard 16px) |
| Card Grid Gap | 14px | Between grid tiles |

**Touch Targets:**
- Minimum: 48px (exceeds 44px accessibility standard)
- Buttons: 54px height (comfortable for gloved hands)
- Cards: Full width tap targets
- Chips: 44px height, minimum 80px width
- Center FAB: 64px diameter

### Button Variants

| Type | Fill | Border | Shadow | Corner Radius | Use |
|------|------|--------|--------|---------------|-----|
| Primary | `#F59E0A` | None | `0 6px 16px rgba(#F59E0A, 0.30)` | 16px | Main actions |
| Secondary | `#8B5CF6` | None | `0 4px 12px rgba(#8B5CF6, 0.20)` | 16px | Accent actions |
| Outlined | White | 1.5px `#E7E5E4` | None | 16px | Secondary actions |
| Ghost | Transparent | None | None | 16px | Tertiary, cancel |
| Chip (selected) | Status color fill | None | None | 12px | Inspection options |
| Chip (unselected) | `#F5F5F4` | None | None | 12px | Inspection options |
| Center FAB | `#F59E0A` | None | `0 8px 24px rgba(#F59E0A, 0.35)` | 50% (circle) | Quick Inspect action |

### Card Components

The card system uses **bold colored backgrounds** as the primary visual differentiator. Cards are vibrant, not plain white, with status communicated through background fill color.

#### Card Design Philosophy (Updated)

Inspired by the Eduly aesthetic: cards are not neutral containers but **colorful, expressive surfaces** that communicate meaning through their fill color, illustrated icons, and bold typography.

#### Card Layout Overview

| Layout | Height | Use Case |
|--------|--------|----------|
| **Tile** | 140-160px | Dashboard grid, hive overview (NEW — primary layout) |
| **Image** | 200-220px | Detail views, hero cards |
| **Simple** | 110-120px | Lists without photos, medium density |
| **Compact** | 80-90px | High-density lists, task lists |

---

#### Hive Card Tile (NEW — Primary Dashboard Layout)

Inspired by Eduly's grid category cards. Bold colored square/rectangle tiles with illustrated icon, hive name, and status badge. Arranged in a 2-column grid.

```
┌──────────────┐  ┌──────────────┐
│ ┌──┐    [✓]  │  │ ┌──┐    [!]  │
│ │🐝│         │  │ │🐝│         │
│ └──┘         │  │ └──┘         │
│              │  │              │
│ Sunny        │  │ Meadow       │
│ 3 days ago   │  │ Inspect due  │
└──────────────┘  └──────────────┘
  (green fill)      (amber fill)
```

**Specifications:**

| Property | Value |
|----------|-------|
| Size | 2-column grid, ~160 × 150px each |
| Corner Radius | 24px |
| Background | Tinted status fill (e.g., `#DCFCE7` for healthy) |
| Icon | 48px illustrated hive icon |
| Status Badge | 28px solid circle, top-right, white icon |
| Shadow | `0 4px 16px rgba(0,0,0,0.06)` |
| Variants | 4 statuses × photo true/false |

---

#### Hive Card Image

Large photo area with bold status badge overlay. Colored bottom section.

```
┌─────────────────────────────┐
│ ┌─────────────────────────┐ │
│ │                    [✓]  │ │  ← 130px image area
│ │      [HIVE PHOTO]       │ │    Status badge overlay
│ │                         │ │    Rounded 20px corners
│ └─────────────────────────┘ │
│ Sunny                       │  ← Bold title
│ Queenright • Brood good     │  ← Status chips row
│ 3 days ago                  │  ← Timestamp
└─────────────────────────────┘
```

**Specifications:**

| Property | Value |
|----------|-------|
| Size | Full width × 220px |
| Corner Radius | 24px |
| Image Area | 130px height, 20px internal radius |
| Status Badge | 32px solid circle overlaid on image, top-right |
| Shadow | `0 4px 16px rgba(0,0,0,0.06)` |
| Variants | 8 (4 statuses × Photo true/false) |

**Photo=false Fallback:**
- Full tinted status color fill (e.g., `#DCFCE7`)
- Illustrated hive icon centered (56px)
- "Tap to add photo" hint below icon

---

#### Hive Card Simple

Colored left accent bar + bold text. Clean horizontal layout.

```
┌─────────────────────────────┐
│▌ ● Sunny               [✓] │  ← Status dot + bold name + badge
│▌   Queenright • Brood good  │  ← Status summary chips
│▌   Last inspected 3 days ago│  ← Timestamp
└─────────────────────────────┘
```

**Specifications:**

| Property | Value |
|----------|-------|
| Size | Full width × 110px |
| Corner Radius | 20px |
| Accent Bar | 5px width, left edge, status color, rounded |
| Status Badge | 28px solid circle |
| Variants | 4 (Healthy, Attention, Urgent, Unknown) |

---

#### Hive Card Compact

Minimal horizontal layout for dense lists.

```
┌─────────────────────────────────────┐
│▌● Sunny                       [✓]  │
│▌  Queenright • 3 days ago          │
└─────────────────────────────────────┘
```

**Specifications:**

| Property | Value |
|----------|-------|
| Size | Full width × 80px |
| Corner Radius | 16px |
| Status Bar | 5px width, left edge, rounded |
| Variants | 4 (Healthy, Attention, Urgent, Unknown) |

---

#### Hive Card Skeleton

Loading state with shimmer animation placeholders on tinted background.

```
┌─────────────────────────────┐
│  ░░░░░░░░░░░░░░░░░░░░░░░░  │  ← Warm shimmer (#F5F5F4)
│  ░░░░░░░░░░░░░░░░░░░░░░░░  │    1.2s animation loop
│  ░░░░░░░░░░░░░░░░░░░░░░░░  │    Rounded placeholder shapes
│  ░░░░░░░░░░                │
│  ░░░░░░░░░░░░░░░░░░        │
└─────────────────────────────┘
```

---

#### Task Card Simple

Bold colored top accent with illustrated priority icon. Checkbox for completion.

```
┌─────────────────────────────┐
│▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀│  ← 5px colored accent bar
│ 🍯 Feed Hive           ☐   │  ← Illustrated icon + checkbox
│   Hive: Sunny               │  ← Associated hive
│   Due today                  │  ← Due date (priority color, bold)
└─────────────────────────────┘
```

**Specifications:**

| Property | Value |
|----------|-------|
| Size | Full width × 110px |
| Corner Radius | 20px |
| Accent Bar | 5px height, priority color |
| Icon | 28px illustrated task icon |
| Checkbox | 24 × 24px, 8px radius, bold border |
| Variants | 3 (High, Normal, Low) |

---

#### Task Card Compact

Horizontal layout for task lists. Priority bar on left, checkbox on right.

```
┌─────────────────────────────────────┐
│▌🍯 Feed Hive                  ☐   │
│▌  Hive: Sunny · Due today          │
└─────────────────────────────────────┘
```

**Specifications:**

| Property | Value |
|----------|-------|
| Size | Full width × 76px |
| Corner Radius | 16px |
| Priority Bar | 5px width, left edge, rounded |
| Checkbox | 24 × 24px |
| Variants | 3 (High, Normal, Low) |

---

#### Status & Priority Colors

**Hive Status:**
| Status | Color | Fill BG | Hex | Badge |
|--------|-------|---------|-----|-------|
| Healthy | Green | `#DCFCE7` | `#22C55E` | ✓ (white on green) |
| Attention | Amber | `#FEF3C7` | `#F59E0B` | ! (white on amber) |
| Urgent | Red | `#FEE2E2` | `#EF4444` | !! (white on red) |
| Unknown | Slate | `#F1F5F9` | `#94A3B8` | ? (white on gray) |

**Task Priority:**
| Priority | Color | Fill BG | Hex | Due Label |
|----------|-------|---------|-----|-----------|
| High | Red | `#FEE2E2` | `#EF4444` | Due today |
| Normal | Amber | `#FEF3C7` | `#F59E0B` | Due in X days |
| Low | Slate | `#F1F5F9` | `#94A3B8` | No due date |

---

#### Card Selection Guidelines

| Context | Recommended Card |
|---------|------------------|
| Dashboard (primary) | **Tile** (2-column grid) |
| Dashboard (many hives) | Tile grid or Simple list |
| Detail/Edit screens | Image |
| Task lists | Simple or Compact |
| Location hive lists | Compact |
| Search results | Compact |

### Dashboard Layout (Updated)

The dashboard uses a bold, vibrant layout inspired by Eduly's home screen:

```
┌──────────────────────────────┐
│         Status Bar           │
├──────────────────────────────┤
│  Hi, Marcus 👋               │  ← Bold greeting (32px Poppins Bold)
│                              │
│  ┌────────────────────────┐  │
│  │   🐝    4/6            │  │  ← Circular progress ring
│  │  [RING]  inspected     │  │    Amber ring on cream card
│  │         this week      │  │    Illustrated bee icon center
│  │                        │  │
│  │  ● 2 need attention    │  │  ← Quick stats below ring
│  │  ● 1 task due today    │  │
│  └────────────────────────┘  │
│                              │
│  Today's Tasks    See all →  │  ← Section header (18px SemiBold)
│  ┌────────────────────────┐  │
│  │▌🍯 Feed Sunny     ☐   │  │  ← Task card compact
│  └────────────────────────┘  │
│  ┌────────────────────────┐  │
│  │▌📋 Inspect Meadow  ☐   │  │
│  └────────────────────────┘  │
│                              │
│  Your Hives       See all → │  ← Section header
│  ┌──────────┐ ┌──────────┐  │
│  │  🐝  [✓] │ │  🐝  [!] │  │  ← Hive tile grid (2-col)
│  │  Sunny   │ │  Meadow  │  │    Colored fill backgrounds
│  │  3d ago  │ │  Due now  │  │
│  └──────────┘ └──────────┘  │
│  ┌──────────┐ ┌──────────┐  │
│  │  🐝  [✓] │ │  🐝  [?] │  │
│  │  Garden  │ │  Creek   │  │
│  │  1d ago  │ │  New     │  │
│  └──────────┘ └──────────┘  │
│                              │
├──────────────────────────────┤
│  🏠    📍    [🐝]    ✓    ⚙️ │  ← Bottom nav with center FAB
└──────────────────────────────┘     [🐝] = elevated Quick Inspect
```

### Bottom Navigation (Updated)

Inspired by Eduly's elevated center button pattern:

| Item | Icon | Label |
|------|------|-------|
| Home | Illustrated house | Home |
| Locations | Illustrated map pin | Locations |
| **Quick Inspect** | **Illustrated bee (center FAB, 64px, elevated)** | **Inspect** |
| Tasks | Illustrated checklist | Tasks |
| Settings | Illustrated gear | Settings |

**Center FAB Specifications:**
- Size: 64 × 64px, fully circular
- Fill: Primary amber `#F59E0A`
- Shadow: `0 8px 24px rgba(#F59E0A, 0.35)`
- Icon: White illustrated bee, 32px
- Elevation: Extends 16px above nav bar
- Animation: Subtle pulse on first launch to draw attention

### Accessibility Considerations

- All text: WCAG AA contrast (4.5:1+) - verified for colored card backgrounds
- Status: Icons accompany colors (not color-only) — badge icons always present
- Touch: 48-54px targets exceed accessibility minimum
- Outdoor: Poppins SemiBold/Bold + high contrast for bright conditions
- Color blindness: Status uses badge icon (✓/!/!!/?) + position, not just color
- Tinted card backgrounds: All text on tinted fills verified for 4.5:1 contrast ratio
- Reduced motion: Respect `prefers-reduced-motion`, provide static alternatives

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

**Hybrid: Task-Led Vibrant Tile Dashboard**

Combines the action-oriented entry of Direction 5 (Task First) with the visual richness of Direction 1 (Card Dashboard), elevated with the bold colorful aesthetic of the Eduly inspiration.

### Design Rationale

| Decision | Rationale |
|----------|-----------|
| Circular progress hero | Glanceable "how am I doing" — inspired by Eduly's progress charts, more engaging than plain numbers |
| Bold greeting with personality | "Hi, Marcus 👋" creates warmth — inspired by Eduly's conversational headers |
| Task cards below hero | Answers "what do I do today?" immediately — Marcus's core need |
| Hive tile grid (2-column) | Colorful, visual overview for status checking — Elena's need. More engaging than list |
| Colored card fills | Status visible from 3 feet away in bright sunlight — field condition requirement |
| Center FAB (Quick Inspect) | Most important action always 1 tap away from any screen |
| Illustrated icons | Creates personality and visual differentiation — stands out from dated competitors |
| Bottom navigation | Standard mobile pattern, enhanced with elevated center action |

### Implementation Approach

**Home Screen Structure:**
```
┌─────────────────────────┐
│     Status Bar          │
├─────────────────────────┤
│  Hi, Marcus 👋          │  ← Bold greeting (Poppins Bold 32px)
├─────────────────────────┤
│  [Circular Progress]    │  ← Inspection ring + quick stats
│  4/6 inspected          │     on cream/amber gradient card
├─────────────────────────┤
│  Today's Tasks          │  ← Section header
│  [Task Card Compact]    │  ← Priority tasks
│  [Task Card Compact]    │
├─────────────────────────┤
│  Your Hives             │  ← Section header
│  [Tile] [Tile]          │  ← 2-column grid, colored fills
│  [Tile] [Tile]          │
│  [Tile] [Tile]          │
├─────────────────────────┤
│  🏠  📍  [🐝]  ✓  ⚙️   │  ← Bottom nav with center FAB
└─────────────────────────┘
```

**Navigation Pattern:**
- Home (task-led vibrant dashboard)
- Locations (map view for multi-location)
- **Quick Inspect (center FAB - elevated)**
- Tasks (full task list)
- Settings