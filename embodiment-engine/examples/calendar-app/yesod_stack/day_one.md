# Day One — Build Order

Ordered steps with dependencies made explicit. Follow this sequence. Each step names what it depends on.

---

## Before you write a line of code

1. Read `README.md` (2 minutes)
2. Read `what_not_to_build.md` (the exclusions shape every decision that follows)
3. Read `architecture.md` (the feature test and component contracts)
4. Skim `product_soul.md` (the voice; return to it when something feels off)

You now know what to build, what not to build, and how to recognize drift. Proceed.

---

## Tech stack decisions

**Mobile:** React Native (cross-platform — phone is required, laptop is required, they must be the same)

**Local storage:** SQLite via `expo-sqlite` (iOS + Android) or equivalent platform-native SQLite binding. Schema is in `data_model.sql` — use it verbatim.

**Sync:** Custom adapter layer per `CalendarProvider` interface in `sync_layer.md`. No off-the-shelf sync library that shapes the interface before you do.

**Auth tokens:** Platform keychain only (iOS Keychain, Android Keystore). Never in SQLite.

**Testing:** Jest + React Native Testing Library for unit/integration. Detox or Maestro for E2E. Visual regression: Storybook + Chromatic, or equivalent screenshot comparison in CI.

**CI:** GitHub Actions or equivalent. Must run: unit tests, visual regression, immutable string assertions, recurring event query assertions.

---

## Step 1: Data model and local DB

*Depends on: nothing*

- Initialize SQLite with the schema from `data_model.sql`. Run migrations from the start — even on day one, use a migration system (e.g., `expo-sqlite` migrations or `drizzle-orm`). The schema will not change often, but migrations must be in place before any data ships.
- Write and pass the recurring event query test:

```typescript
// Verify that events with series_end in the past do not appear in the window query
it('ended series do not appear in week view', () => {
  // Insert a recurring series with series_end = yesterday
  // Query for this week
  // Assert: zero results
});
```

- Write and pass the "history stays in DB" assertion:

```typescript
it('cancelled series remain in DB but not in week view query', () => {
  // Insert cancelled instances
  // Query for current week with is_cancelled = 0 filter
  // Assert: zero results from cancelled events
  // Assert: rows still exist in DB
});
```

Do not proceed to Step 2 until these tests pass.

---

## Step 2: CalDAV adapter

*Depends on: Step 1 (CalendarProvider writes to local DB)*

Build `CalDAVAdapter implements CalendarProvider` first. Reason: CalDAV forces the interface honest before any proprietary SDK shapes it. The interface you arrive at here becomes the contract all other adapters must satisfy.

- Implement `fetchEvents(range)`, `pushEvent(event)`, `watchChanges(callback)`
- Auth refresh lives inside the adapter. The engine never sees token state.
- Error classification: `AUTH_EXPIRED`, `RATE_LIMITED`, `PROVIDER_DOWN`
- Write queue integration: `pushEvent` must write to `write_queue` before attempting the network call, then clear on success

Test against a real CalDAV server (e.g., Nextcloud instance or Fastmail CalDAV). Test CRUD. Test reconnect replay from the write queue.

---

## Step 3: Remaining adapters

*Depends on: Step 2 (CalendarProvider interface is stable)*

Build in this order: Google, Outlook, iCloud. Each must satisfy the same interface. Each must pass the same adapter test suite.

Set up monthly automated CRUD health check against test accounts on Google, Outlook, iCloud. This is infrastructure, not a nice-to-have. It must run before 1.0.

---

## Step 4: TimeGrid component

*Depends on: Step 1 (Event type is defined)*

The most important component contract in the codebase. Build it with the constraint baked in from the start.

```typescript
// TimeGrid — renders a week's worth of events.
// 
// ARCHITECTURAL CONSTRAINT: this component accepts events only.
// It does not accept empty-slot props, availability hints, gap treatments,
// or any prop that references open time. See architecture.md.
// Adding such a prop requires PR review against architecture.md.

interface TimeGridProps {
  events: Event[];
  // Nothing else that references open time.
}
```

- Virtualized: only visible hours rendered. Off-screen hours not mounted.
- Baseline screenshots committed to CI on first merge. Visual regression runs from this baseline.
- The baseline screenshots are the authority on what open time looks like: nothing.

---

## Step 5: ImmutableStatement component and CI assertion

*Depends on: Step 4 (component system in place)*

Build this before any other Settings screen work. The string must be in CI before any other copy ships.

- Create `constants/immutableStrings.ts` with `CANONICAL_SETTINGS_STATEMENT`
- Mark file: `DO NOT MODIFY WITHOUT PRODUCT LEAD SIGN-OFF`
- Create `ImmutableStatement` component (no text prop, no children — see `immutable_string.md`)
- Write and commit the CI assertion test
- Verify CI fails if the constant is changed

This step is complete only when CI fails on a deliberate string mutation and passes on restore.

---

## Step 6: Settings > About screen

*Depends on: Step 5*

The version screen. `ImmutableStatement` renders in it. The line is found here, not pushed anywhere else.

The screen contains: app name, version number, what it syncs with, contact link, and the `ImmutableStatement`. That is the complete list.

---

## Step 7: Week view and navigation

*Depends on: Steps 1, 3, 4 (local DB + adapters + TimeGrid)*

- Opens to current week, current hour centered
- Serves from local DB on open. No loading state. Data is there.
- Sync updates arrive beneath the initial render
- Recurring events render at the same visual weight as non-recurring events
- "Updated X minutes ago" timestamp only if `PROVIDER_DOWN` — quiet, not blocking

Performance test against the 800ms budget before marking this step complete. Test on the target device class (Snapdragon 6xx, 3GB RAM) or the best emulator approximation available.

---

## Step 8: Integration primitives

*Depends on: Step 7 (basic calendar view works)*

Build these in parallel or in any order:

**DeepLinkHandler:** Zoom, Teams, webcal URI interception. Test corpus for each provider includes current and previous URI formats.

**InviteParser:** `.ics` and Gmail invite parsing. Seed the test corpus with real email bodies from 2020-present.

**DragReschedule:** Gesture → optimistic write → background sync → snap-back on failure. Platform-native gesture recognizers only.

---

## Step 9: Onboarding

*Depends on: Steps 2-3 (adapters work)*

Onboarding teaches sync. That is its only job.

- Connect a calendar. Here is how.
- Supported providers: Google, Outlook, iCloud, CalDAV.
- That is all.

Onboarding does not say "we know calendars are stressful." It does not contain the product's philosophy. It does not say anything about what the product is trying to do. It teaches sync and gets out.

---

## Step 10: App Store submission

*Depends on: all prior steps passing CI*

App Store description contains:
- What it is (a calendar)
- What it syncs with (Google, Outlook, iCloud, CalDAV)
- No ending on ambition
- No "more coming"
- No tagline

The description does not contain the settings line. The settings line is found in the app, not on the store page.

---

## CI checklist (must pass before any public release)

- [ ] Unit tests pass (including recurring event query tests)
- [ ] Visual regression passes against TimeGrid baseline
- [ ] `ImmutableStatement` CI assertion passes
- [ ] Per-locale immutable string assertions pass (for all shipped locales)
- [ ] 800ms budget test passes on target device class
- [ ] Monthly integration health check has a baseline run logged
- [ ] No `color.grid.emptySlot` (or semantic equivalent) in design tokens
- [ ] `TimeGrid` component has no empty-slot props
