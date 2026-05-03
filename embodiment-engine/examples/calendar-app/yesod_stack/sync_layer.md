# Sync Layer

## CalendarProvider interface

All sync logic talks to this interface. The engine never talks directly to a provider SDK.

```typescript
interface CalendarProvider {
  // Fetch events in a UTC time range.
  // Returns canonical Event[] from local-normalized data.
  fetchEvents(range: { start: Date; end: Date }): Promise<Event[]>;

  // Push a single event to the provider.
  // Returns the provider-assigned stable ID on creation.
  pushEvent(event: EventWrite): Promise<{ providerId: string }>;

  // Long-lived subscription. Calls callback with changed/deleted events.
  // Returns unsubscribe function.
  watchChanges(callback: (changes: EventChange[]) => void): () => void;
}
```

Implemented per provider:
- `GoogleCalendarAdapter implements CalendarProvider`
- `OutlookCalendarAdapter implements CalendarProvider`
- `ICloudCalendarAdapter implements CalendarProvider`
- `CalDAVAdapter implements CalendarProvider`

**Build CalDAV first.** It forces the interface to be correct before any proprietary SDK shapes it. CalDAV is also the long-term hedge against any single provider's API politics.

---

## Auth refresh

Auth refresh lives inside the adapter, not in the calling engine. The engine never sees token state.

Error classification the adapter exposes to the engine:

| Error class       | Meaning                                    | Engine behavior                                      |
|-------------------|--------------------------------------------|------------------------------------------------------|
| `AUTH_EXPIRED`    | Token refresh failed; needs re-auth        | Silent. Adapter queues until user re-authenticates.  |
| `RATE_LIMITED`    | Provider is throttling                     | Silent. Adapter retries with backoff.                |
| `PROVIDER_DOWN`   | Provider unreachable after retries         | Surface to user: quiet "updated X minutes ago" only. |

**No blocking error UI.** No "you are offline" banner. `PROVIDER_DOWN` surfaces as a timestamp, not as an interstitial.

---

## Write queue and conflict resolution

Writes queue locally (see `write_queue` table in `data_model.sql`). The app is always writable, regardless of connectivity.

Queue replays on reconnect. If the round-trip produces a conflict (server state differs from local state), **server state wins**. The local event snaps back to server state. The UI shows the snap-back without drama — no error, no explanation.

---

## Integration primitives

### DeepLinkHandler

Intercepts and opens:
- `zoommtg://` — current and previous Zoom URI formats
- `msteams://` — Teams deep links
- `webcal://` — calendar subscription URLs

Tests must run against current and previous URI formats for each provider. When Zoom or Teams changes their URI scheme, the test corpus catches it before users do.

### InviteParser

Parses:
- `.ics` attachments
- Gmail invite email bodies

Test corpus: raw email bodies from 2020 to present. The corpus grows as new format variations surface in the wild. Do not maintain a minimal corpus — the variations matter.

### DragReschedule

Gesture calculation only. No scheduling logic, no suggestions.

- Pure gesture calculation → optimistic UI write + background sync
- Platform-native gesture recognizers. Not custom touch handling.
- Snap-back to server state if sync fails. No retry prompt.

---

## Monthly integration health check

A monthly automated CRUD run against test accounts on Google, Outlook, and iCloud.

The run creates, reads, updates, and deletes events via each adapter. It compares results against expected canonical output. Failures alert the team before users encounter API drift.

This is how you know when Google deprecates an API version: the monthly run fails, not a user report.

---

## Adapter isolation principle

When Google deprecates an API version, the change is contained to `GoogleCalendarAdapter`. The engine, the UI, and the other adapters are untouched. The interface contract is the firewall.

If an adapter change requires a change to `CalendarProvider` interface, that is a major breaking change requiring explicit review. The interface should be stable for years.
