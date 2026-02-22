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

Flutter's native Material 3 implementation with heavy customization to create a unique, modern brand identity.

### Rationale for Selection

| Factor | Decision Driver |
|--------|-----------------|
| Development Speed | M3 built into Flutter - no additional dependencies |
| Modern Aesthetic | Latest Material iteration matches inspiration apps (ING, Padelcity) |
| Cross-Platform | Consistent look on iOS and Android |
| Accessibility | WCAG compliance built-in (large touch targets, contrast ratios) |
| Field Conditions | Supports high contrast, large tap targets for glove use |
| Customization | Full theming support for unique brand identity |

### Implementation Approach

- Use Flutter's `ThemeData` with Material 3 (`useMaterial3: true`)
- Define custom `ColorScheme` for brand colors
- Configure custom `TextTheme` for optimal field readability
- Set component themes (buttons, cards, inputs) for rounded, friendly aesthetic
- Implement dynamic theming for potential dark mode

### Customization Strategy

**Colors:**
- Primary: Warm, natural palette (honey/amber tones for beekeeping context)
- Status colors: Green (healthy), Yellow (attention), Red (urgent)
- High contrast for outdoor visibility

**Typography:**
- Clean sans-serif for readability in sunlight
- Larger base sizes for field use
- Bold weights for status indicators

**Components:**
- Rounded corners (friendly, modern)
- Generous padding (glove-friendly taps)
- Card-based layouts (kanban-inspired)
- Custom icons for beekeeping domain (hive, queen, brood, etc.)

**Motion:**
- Subtle, purposeful animations (Padelcity-inspired)
- Quick transitions (speed principle)
- Haptic feedback on key actions

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
- Primary: Warm Amber `#F59E0B` - Actions, brand identity
- Primary Dark: Deep Honey `#D97706` - Headers, emphasis
- Secondary: Soft Brown `#78716C` - Secondary elements
- Background: Warm White `#FFFBEB` - Main background
- Surface: Cream `#FEF3C7` - Cards, elevated surfaces
- On Surface: Dark Brown `#292524` - Primary text

**Status Colors:**
- Healthy: Forest Green `#16A34A`
- Attention: Amber `#F59E0B`
- Urgent: Warm Red `#DC2626`
- Unknown: Slate `#64748B`

### Typography System

- **Fonts:** Platform defaults (SF Pro / Roboto) for optimal performance
- **Base Size:** 16px (larger for field readability)
- **Scale:** H1 32px → H2 24px → H3 20px → Body 16px → Caption 14px
- **Weights:** Bold for titles, SemiBold for actions, Regular for body

### Spacing & Layout Foundation

- **Grid:** 8px base unit
- **Touch Targets:** 48px minimum (glove-friendly)
- **Padding:** 16px card padding, 16px screen margins
- **Gaps:** 12px between items, 24px between sections
- **Feel:** Spacious but efficient

### Accessibility Considerations

- All text: WCAG AA contrast (4.5:1+)
- Status: Icons accompany colors (not color-only)
- Touch: 48px targets exceed 44px accessibility minimum
- Outdoor: Larger fonts, high contrast for bright conditions

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
