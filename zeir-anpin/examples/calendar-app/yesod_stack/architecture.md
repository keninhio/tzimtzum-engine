# Architecture — Non-Negotiables

These are constraints that live at the level of types, tokens, and CI — not policy documents. Policy can be overridden under pressure. These cannot.

---

## The feature test (apply before writing any new code)

> Does this feature require noticing the empty hour in order to function?

If yes: the feature is out. Not deferred. Not scoped down. Out.

This test forecloses by architecture:
- AI scheduling assistants
- Smart suggestions / intelligent scheduling
- Pattern-based recommendations ("you have a free hour, here's what you could do")
- Third-party task-list integrations populating open slots
- Productivity insights (notification, digest, or dashboard form)
- Time-blocking nudges (including for "rest" or "personal time")
- Focus mode prompts
- Recovery / buffer / protected-time categorization
- Smart defaults pre-populating anything
- Suggestions surfaced from past behavior

Apply the test at PR time. Apply it at design time. Apply it when a stakeholder asks "what if we just...".

---

## TimeGrid component contract

```typescript
interface TimeGridProps {
  events: Event[];
  // NO emptySlotStyle
  // NO openHoursAppearance
  // NO gapTreatment
  // NO freeTimeFill
  // NO availabilityHint
}
```

`TimeGrid` accepts `events: Event[]` only. Adding any prop that references open time, empty slots, gaps, or availability requires a PR with explicit review against this document. The reviewer's job is to run the feature test.

The component renders event blocks. It does not render the absence of event blocks as anything.

---

## Design tokens

**Exists:**
```
color.grid.background
```

**Does not exist and must not be created:**
```
color.grid.emptySlot       // forbidden
color.grid.openHour        // forbidden
color.grid.freeTime        // forbidden
color.grid.available       // forbidden
color.grid.gap             // forbidden
```

If a PR introduces any of these tokens, CI fails. If it introduces a token with similar semantic intent under a different name, the PR reviewer must catch it and reject it.

---

## Visual regression CI

Screenshots are compared to baseline across:
- Every theme
- Dark and light mode
- Font scale min and max extremes

A "subtle hint" added via CSS — any fill, gradient, stripe, opacity treatment, animation, texture, or border applied to open time — produces a visual diff that fails CI.

The baseline screenshots are the authority. When updating baselines, the diff must be reviewed explicitly for any treatment of open hours.

---

## Performance budget

Week view interactive within **800ms** on:
- Device: 5-year-old midrange Android
- SoC: Snapdragon 6xx
- RAM: 3GB
- Connection: average (not WiFi)

**Virtualized time grid:** only visible hours are rendered in the DOM / view hierarchy. Off-screen hours are not mounted.

**Query for 12 calendars / 2000 events:**
```sql
SELECT * FROM events
WHERE calendar_id IN (...)
  AND start_time BETWEEN ? AND ?
ORDER BY start_time
```
Run against a local index. This query must complete in under 50ms on the target device.

---

## Local-first requirement

App open serves from local DB instantly. **No loading state for initial view.**

Sync runs behind the initial render. Updates arrive beneath what the user sees; the view updates without blocking.

Last 30 days forward + 7 days back, written on every successful sync. Cache is always warm.

---

## Recurring events query

Series must stop appearing when they end. Enforced at query time:

```sql
WHERE (series_end IS NULL OR series_end > ?)
  AND effective_start_utc BETWEEN ? AND ?
```

`series_end` is the authority. When a series ends, the instances do not haunt next Tuesday. History stays in DB; query filters it out.

---

## Immutable settings line — CI assertion

See `immutable_string.md` for full spec. Summary for architecture reference:

- String resource key: `settings_about_immutable_statement`
- Component: `ImmutableStatement` — renders only the canonical string, no text prop
- CI test: `assert settings_about_text == CANONICAL_STRING`
- Constants file marked: `DO NOT MODIFY WITHOUT PRODUCT LEAD SIGN-OFF`
- Per-locale assertions run in CI. Every locale has its own canonical string. None can drift.

---

## Metrics the codebase must not instrument

The following events must not be tracked, logged, or reported to any analytics system:

- Time in app
- DAU / MAU
- Open rate
- Engagement with any specific view
- A/B test variants on any copy — especially not onboarding or the settings line

What may be tracked: crash rates, sync success/failure rates, performance metrics against the 800ms budget.

The content of calendar events — titles, descriptions, attendees — is not transmitted to any backend. Not in aggregate. Not anonymized. Architectural commitment. The backend does not parse event content.
