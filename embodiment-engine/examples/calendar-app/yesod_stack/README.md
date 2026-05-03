# Calendar App — Deployable Stack

**Start here. Read this file first.**

This is a handoff package for a fresh builder — human or Claude — with no prior context on this product. Everything you need to know to start is here. Everything you need to resist is also here.

---

## What you are building

A digital calendar app. Not metaphorically a calendar. An actual calendar.

It syncs with Google Calendar, Outlook, iCloud, and any CalDAV server. It accepts meeting invites from anywhere. Tap a Zoom or Teams link, it opens. Share a calendar URL. Drag to reschedule. Decline without ceremony. Phone and laptop work the same.

**The only thing this app does that other calendars do not:** it refuses to treat your open time as a problem.

Open time is visually indistinguishable from any other hour, except it has no event block. Event blocks interrupt the page. Open time is not interrupted. That is the entire product insight, and it is expressed in a single architectural constraint (documented in `architecture.md`), not in copy, not in marketing, not in philosophy.

The settings screen carries one honest-admission line — found when looking, not when pushed:

> *This app cannot protect your time. Only you can do that. We tried to at least not make it worse.*

That line is the only place the product speaks about itself. Everything else is functional truth or silence.

---

## File map

```
yesod_stack/
  README.md              ← you are here; start here; read fully before touching anything else
  product_soul.md        ← the full product vision in prose; the voice that must survive
  architecture.md        ← non-negotiables, data models, component contracts, CI assertions
  data_model.sql         ← canonical SQLite schema; use this, do not reinvent
  sync_layer.md          ← CalendarProvider interface, adapter pattern, error classification
  what_not_to_build.md   ← explicit exclusions; read before adding any feature
  immutable_string.md    ← the settings line; three-layer enforcement spec
  day_one.md             ← where to start; ordered build steps with dependencies
```

---

## Two-minute orientation

**Build:** A calendar that syncs everywhere, opens in under 800ms on a 5-year-old midrange Android, and renders open time as nothing.

**Do not build:** Anything that requires noticing the empty hour. The architectural test is in `architecture.md`. When in doubt, apply it.

**Non-negotiables:**
1. `TimeGrid` accepts `events: Event[]` only. No slot-appearance props, ever.
2. Single design token `color.grid.background`. No `color.grid.emptySlot` token.
3. The immutable settings line lives at `settings_about_immutable_statement`, rendered by `ImmutableStatement` component, CI-asserted. Details in `immutable_string.md`.
4. Local-first. No loading state for initial view.
5. CalDAV first. It forces the interface honest.

**Drift recognition:** If you are writing code, copy, tokens, or configs that reference open hours, empty slots, free time, unscheduled time, availability, or gaps — stop. Run the feature test in `architecture.md`. If the feature requires noticing the empty hour in order to function, it is out.

**The soul is in `product_soul.md`.** If something feels off but you cannot name it, read `product_soul.md`. The voice there is not style — it is spec.

---

## Entry point for day one

Open `day_one.md`. It is ordered. Follow it.
