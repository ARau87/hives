---
stepsCompleted: ['step-01-init', 'step-02-discovery', 'step-03-success', 'step-04-journeys', 'step-05-domain', 'step-06-innovation', 'step-07-project-type', 'step-08-scoping', 'step-09-functional', 'step-10-nonfunctional', 'step-11-polish', 'step-12-complete']
inputDocuments: []
workflowType: 'prd'
documentCounts:
  briefs: 0
  research: 0
  projectDocs: 0
classification:
  projectType: mobile_app
  platform: Flutterc
  domain: agriculture_apiary
  complexity: medium
  projectContext: greenfield
  scope: frontend_only
---

# Product Requirements Document - hives

**Author:** Andreas
**Date:** 2026-02-14

## Executive Summary

**hives** is a mobile app for hobbyist beekeepers (2-30 hives) to manage their apiaries efficiently. The core value proposition: *know what to do, do it fast, never lose data*.

**Target Users:** Hobbyist beekeepers who need to track inspections, plan tasks, and manage multiple locations - all while working in areas with poor connectivity.

**Key Differentiator:** 30-second inspection logging with offline-first architecture that syncs reliably when connectivity returns.

**Platform:** Flutter (iOS + Android) with AWS backend.

## Success Criteria

### User Success

- Beekeepers can document inspections in **under 30 seconds** while at the hive
- The app balances **flexibility with simplicity** - enough options without overwhelming complexity
- Users can effectively plan their work: knowing **where to go next, what to bring, and when**
- Multi-location beekeepers feel in control of their entire operation from one view

### Business Success

- **500 active users** within 6 months of launch
- Positive user feedback and organic word-of-mouth growth in beekeeping communities
- Foundation built for future premium subscription model

### Technical Success

- Sync that "just works" when connectivity returns - no manual intervention needed
- App feels instant and responsive even with 50+ hives of data
- Solid offline-first architecture that beekeepers can trust in the field

### Measurable Outcomes

- Time to log inspection: < 30 seconds
- App launch to usable state: < 2 seconds
- Sync conflict rate: < 1%
- User retention at 30 days: > 60%

## Product Scope

### MVP - Minimum Viable Product

- Multi-hive, multi-location management
- Fast inspection and task documentation
- Task planning with prioritized next actions
- Offline-first with reliable sync
- Mandatory login (AWS authentication)

### Growth Features (Post-MVP)

- Premium subscription model
- News section for beekeepers
- Enhanced reporting and analytics

### Vision (Future)

- AI-powered analysis and task suggestions
- Sensor data integration (hive monitoring)
- Professional beekeeper features (commercial scale)

## User Journeys

### Journey 1: Marcus - The Weekend Warrior

**Persona:** Marcus, 38, software developer. 6 hives in his backyard. Saturdays are "bee time."

**The Pain:** It's Saturday morning in late August. Marcus knows he should be doing something with feeding soon - summer's ending. But which hives already have enough reserves? He treated Hive 3 for varroa two weeks ago... or was it Hive 4? He flips through a worn notebook with smudged entries.

**Discovery:** Marcus opens the app while drinking coffee. The dashboard shows: "3 hives need attention today" with clear priorities. Hive 2 is flagged: "Last inspection 3 weeks ago - reserves were low." Hive 4 shows "Varroa treatment due - 14 days since application." He knows exactly what to check.

**The Flow:** At Hive 2, he opens the inspection screen - 20 seconds to tap: queenright ✓, brood good, reserves low → feeding needed. He adds a quick note: "aggressive today, might requeen in spring." No signal out here, but the app works offline.

**Resolution:** Back inside, the app syncs. His task list updates: "Buy 10L sirup" appears. Next Saturday's plan already shows which hives need follow-up. Record-keeping takes seconds, not minutes.

### Journey 2: Elena - The Growing Enthusiast

**Persona:** Elena, 45, teacher. 18 hives across 3 locations: garden (4), parents' farm 20km away (8), friend's orchard (6).

**The Pain:** Elena's Sunday is booked for inspections, but she's overwhelmed. Which location needs her most urgently? The farm hives were queenless last month - did that resolve? Notes scattered across locations, no full picture.

**Discovery:** Elena opens the app and sees her map view: three pins showing her apiaries. The farm location pulses with a warning - "2 hives flagged: queenless status unconfirmed." Garden shows green - all stable. Orchard has a task due: "Varroa treatment follow-up." She plans her route: Farm first, then orchard. Adds equipment to tasks: "Bring: queen cage, marked queen."

**The Flow:** At the farm with no cell signal, Elena works through 8 hives. Confirms Hive F2 now has a laying queen - taps "queenright" and the warning clears. Hive F5 still queenless - marks "needs queen" and the app adds it to her task list.

**Resolution:** Driving home, Elena feels in control despite 18 hives across 30km. Phone syncs at a traffic light. At a glance: 16 healthy hives, 1 needs a queen, 1 needs feeding.

### Journey 3: Tom - The New Beekeeper

**Persona:** Tom, 32, just completed beekeeping course. 2 nucleus colonies, eager to "do things right."

**The Setup:** Tom downloads the app the night before his first inspection. He has 2 hives - "Sunny" and "Shadow." Wants proper setup without spending an hour configuring.

**First Setup:** Creates "Home Garden" location with optional map pin. Adds 2 hives with names. Minimal questions: "When did you get these hives?" "Queen age?" Answers what he knows, skips what he doesn't.

**First Inspection:** Opens "Sunny," starts first inspection log. Simple options: queenright status, brood assessment, reserves. Doesn't force completion of every field. Captures what he observed: "Eggs seen, brood looks good, bees calm." Done in 25 seconds.

**Resolution:** After two weekends, Tom has history forming. "Sunny" thriving, "Shadow" seems slower. Adds first task: "Check Shadow for queen issues." Already building habits that will serve him at 10 hives.

### Journey Requirements Summary

| Capability Area | Revealed By |
|-----------------|-------------|
| Dashboard with priorities and status overview | Marcus, Elena |
| Quick inspection logging (<30 seconds) | Marcus, Tom |
| Offline mode with background sync | Marcus, Elena |
| Task generation from observations | Marcus |
| Map view with location pins | Elena |
| Cross-location overview and filtering | Elena |
| Equipment tracking on tasks | Elena |
| Visual status indicators per hive/location | Elena |
| Simple onboarding with minimal required fields | Tom |
| Optional/flexible data entry | Tom |
| Inspection history over time | Tom |

### Key Domain Insights

- **Seasonal workflows**: Different tasks at different times (varroa treatment in summer, feeding in late summer/fall, brood space in spring)
- **Flexible inspections**: Some check for queen, others check eggs/larva - inspection types vary by beekeeper and season
- **Critical data points**: Queenrightness, brood/bee amount, reserves (pollen/honey), varroa count, illnesses, bee behavior
- **Future sharing**: Some entities should be designed as potentially shareable for future club/community features

## Mobile App Specific Requirements

### Platform Requirements

- **Framework:** Flutter (cross-platform)
- **Target Platforms:** iOS and Android
- **Minimum OS Versions:** TBD during architecture (recommend iOS 14+, Android 8+)

### Device Permissions

| Permission | Purpose | Required |
|------------|---------|----------|
| Location | Map view for apiary locations | Yes |
| Camera | Photo upload for hive documentation | Yes |
| Photo Library | Access saved photos for upload | Yes |
| Push Notifications | Task reminders and alerts | Yes |
| Network | Sync when connectivity available | Yes |

### Offline Mode

- **Core Requirement:** App must be fully functional without network connectivity
- **Data Strategy:** Local-first with background sync when connectivity returns
- **Conflict Resolution:** Last-write-wins with < 1% conflict rate target
- **Storage:** Local database for all hive data, inspections, tasks, and queued photos
- **Photo Handling:** Queue photos locally, upload when connected

### Push Notification Strategy

- **Scheduled Reminders:** Notifications for planned inspection dates/tasks
- **Sync Alerts:** Optional notification when sync completes (if errors occurred)
- **User Control:** Users can enable/disable notification categories

### Store Compliance

- **Standard Compliance:** Follow Apple App Store and Google Play guidelines
- **Privacy:** Standard data privacy declarations (user account data, location, photos)
- **No Special Restrictions:** No age-gating or regulated content concerns

## Project Scoping & Phased Development

### MVP Strategy & Philosophy

**MVP Approach:** Problem-Solving MVP - Deliver core value of "know what to do, do it fast, never lose data"

**Target Launch:** Functional app that supports all three user journeys (Marcus, Elena, Tom) at basic level

### MVP Feature Set (Phase 1)

**Core User Journeys Supported:**
- ✓ Marcus (Weekend Warrior) - Full journey
- ✓ Elena (Multi-location) - Full journey
- ✓ Tom (New Beekeeper) - Full journey

**Must-Have Capabilities:**

| Feature | Rationale |
|---------|-----------|
| Location management with map | Elena's journey, multi-location overview |
| Hive CRUD with flexible fields | All journeys, 30-second goal |
| Quick inspection logging | Core value proposition |
| Task planning + auto-generation | Marcus, Elena planning needs |
| Dashboard with priorities | "What needs attention" view |
| Offline-first + background sync | Forest locations, trust |
| Photo upload (queued offline) | Documentation, visual records |
| Push notifications | Task reminders |
| AWS authentication | Required, mandatory login |

### Post-MVP Features

**Phase 2 (Growth):**
- Premium subscription model
- News/content section for beekeepers
- Enhanced reporting and analytics
- Data export functionality
- Sharing capabilities (prepare for clubs)

**Phase 3 (Vision):**
- AI-powered analysis and task suggestions
- Seasonal guidance based on region
- Sensor data integration (hive monitoring)
- Club/community features
- Professional beekeeper features (commercial scale)

### Risk Mitigation Strategy

**Technical Risks:**
- *Offline sync complexity* → Use proven local-first patterns (e.g., CRDT or last-write-wins with timestamps)
- *Photo queuing* → Compress before queue, clear upload status indicators

**Market Risks:**
- *Adoption in niche market* → Focus on beekeeping communities, forums, associations for organic growth
- *Competition from notebooks* → Emphasize speed (30 sec) and multi-location value

**Resource Risks:**
- *Solo/small team* → Flutter cross-platform reduces effort; AWS backend simplifies infrastructure

## Functional Requirements

### User Account & Authentication

- **FR1:** Users can create an account using AWS authentication
- **FR2:** Users can sign in to access their data
- **FR3:** Users can sign out from the app
- **FR4:** Users can recover access if they forget credentials

### Location Management

- **FR5:** Users can create locations (apiaries) with a name
- **FR6:** Users can set a map pin for each location
- **FR7:** Users can view all locations on a map
- **FR8:** Users can edit location details
- **FR9:** Users can delete a location (with confirmation)
- **FR10:** Users can view a list of all their locations

### Hive Management

- **FR11:** Users can add hives to a location
- **FR12:** Users can name hives (custom naming)
- **FR13:** Users can record optional hive metadata (acquisition date, queen age)
- **FR14:** Users can edit hive details
- **FR15:** Users can delete a hive (with confirmation)
- **FR16:** Users can view all hives at a location
- **FR17:** Users can view hive history (past inspections)

### Inspection Logging

- **FR18:** Users can start a new inspection for a hive
- **FR19:** Users can record queenright status
- **FR20:** Users can record brood assessment
- **FR21:** Users can record bee population assessment
- **FR22:** Users can record reserve levels (honey/pollen)
- **FR23:** Users can record varroa observations
- **FR24:** Users can record illness observations
- **FR25:** Users can record bee behavior notes
- **FR26:** Users can add free-text notes to an inspection
- **FR27:** Users can attach photos to an inspection
- **FR28:** Users can complete an inspection without filling all fields
- **FR29:** Users can view past inspections for a hive

### Task Management

- **FR30:** Users can create tasks manually
- **FR31:** Users can assign tasks to specific hives
- **FR32:** Users can set due dates for tasks
- **FR33:** Users can add equipment/supplies to tasks
- **FR34:** Tasks can be auto-generated from inspection observations
- **FR35:** Users can mark tasks as complete
- **FR36:** Users can edit task details
- **FR37:** Users can delete tasks
- **FR38:** Users can view tasks filtered by location

### Dashboard & Overview

- **FR39:** Users can see a dashboard showing hives needing attention
- **FR40:** Users can see prioritized tasks across all locations
- **FR41:** Users can see visual status indicators per hive
- **FR42:** Users can see visual status indicators per location (on map)
- **FR43:** Users can filter view by location

### Offline & Sync

- **FR44:** Users can perform all core functions without network connectivity
- **FR45:** App automatically syncs data when connectivity is restored
- **FR46:** Photos queue locally and upload when connected
- **FR47:** Users can see sync status

### Notifications

- **FR48:** Users can receive push notifications for scheduled tasks
- **FR49:** Users can enable/disable notification categories
- **FR50:** Users can receive sync error notifications (optional)

## Non-Functional Requirements

### Performance

- **NFR1:** Inspection logging screen loads within 500ms
- **NFR2:** Inspection can be completed (all taps to save) within 30 seconds
- **NFR3:** App launches to usable state within 2 seconds
- **NFR4:** Dashboard renders with 50+ hives in under 1 second
- **NFR5:** Map view loads and displays all locations within 2 seconds
- **NFR6:** All user actions provide visual feedback within 100ms

### Security & Privacy

- **NFR7:** User authentication via AWS Cognito (or equivalent)
- **NFR8:** All data encrypted in transit (HTTPS/TLS)
- **NFR9:** Local data encrypted at rest on device
- **NFR10:** Users can only access their own data
- **NFR11:** Session tokens expire and require re-authentication appropriately

### Reliability & Data Integrity

- **NFR12:** App functions fully without network connectivity
- **NFR13:** No user data lost during offline operation
- **NFR14:** Sync conflict rate below 1% under normal usage
- **NFR15:** Photo uploads resume automatically after interruption
- **NFR16:** App gracefully handles sync failures with clear user feedback
- **NFR17:** Data persists across app updates and device restarts
