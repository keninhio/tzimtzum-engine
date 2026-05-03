-- Canonical SQLite schema for the calendar app.
-- Use this schema. Do not reinvent it.
-- All timestamps stored in UTC. Display conversion happens at render time
-- using the device's current timezone via IANA tz database.

-- ============================================================
-- CALENDARS
-- ============================================================

CREATE TABLE calendars (
    id                TEXT PRIMARY KEY,       -- provider-scoped stable ID
    provider          TEXT NOT NULL,          -- 'google' | 'outlook' | 'icloud' | 'caldav'
    display_name      TEXT NOT NULL,
    color             TEXT,                   -- hex string, user-assigned or provider default
    is_active         INTEGER NOT NULL DEFAULT 1,  -- 0 = hidden by user
    source_account_id TEXT NOT NULL,          -- FK to accounts table
    last_synced_at    INTEGER,                -- unix epoch ms; NULL = never synced
    created_at        INTEGER NOT NULL
);

CREATE INDEX idx_calendars_account ON calendars(source_account_id);

-- ============================================================
-- ACCOUNTS (one per provider auth session)
-- ============================================================

CREATE TABLE accounts (
    id           TEXT PRIMARY KEY,
    provider     TEXT NOT NULL,               -- 'google' | 'outlook' | 'icloud' | 'caldav'
    display_name TEXT NOT NULL,               -- e.g. "kenneth@gmail.com"
    created_at   INTEGER NOT NULL
    -- Auth tokens stored in platform keychain, not in this table.
);

-- ============================================================
-- EVENTS
-- ============================================================

CREATE TABLE events (
    id                   TEXT PRIMARY KEY,     -- provider-scoped stable ID
    calendar_id          TEXT NOT NULL REFERENCES calendars(id),

    -- Time
    start_time_utc       INTEGER NOT NULL,     -- unix epoch ms, UTC
    end_time_utc         INTEGER NOT NULL,     -- unix epoch ms, UTC
    is_all_day           INTEGER NOT NULL DEFAULT 0,

    -- Content
    title                TEXT NOT NULL DEFAULT '',
    location             TEXT,
    url                  TEXT,                 -- Zoom / Teams / Meet deep link if present

    -- Recurrence
    series_id            TEXT,                 -- NULL for non-recurring
    rrule                TEXT,                 -- RFC 5545 RRULE string; on series root only
    series_end           INTEGER,              -- unix epoch ms, UTC; NULL = no end
    original_start_utc   INTEGER,              -- for instances: the start before any exception
    effective_start_utc  INTEGER,              -- for instances: actual start (may differ if rescheduled)
    is_cancelled         INTEGER NOT NULL DEFAULT 0,

    -- Provenance
    source_calendar_id   TEXT,                 -- original calendar if event was moved/merged
    raw_ics              TEXT,                 -- original iCalendar data, stored verbatim

    -- Sync state
    local_modified_at    INTEGER,              -- set when modified locally, cleared on sync round-trip
    sync_status          TEXT NOT NULL DEFAULT 'synced',  -- 'synced' | 'pending_write' | 'conflict'

    created_at           INTEGER NOT NULL,
    updated_at           INTEGER NOT NULL
);

-- Primary query index: week view for N calendars
CREATE INDEX idx_events_calendar_time ON events(calendar_id, start_time_utc);

-- Recurring instance lookup
CREATE INDEX idx_events_series ON events(series_id, effective_start_utc)
    WHERE series_id IS NOT NULL;

-- ============================================================
-- RECURRING EVENT QUERY PATTERN
-- Use this exact WHERE clause. Do not simplify it.
-- The (series_end IS NULL OR series_end > ?) clause is what
-- makes ended series stop appearing. Do not remove it.
-- ============================================================

-- Week view query (parameterized):
--
-- SELECT e.*
-- FROM events e
-- WHERE e.calendar_id IN (/* active calendar IDs */)
--   AND (e.series_end IS NULL OR e.series_end > ?)   -- param: window_start
--   AND e.effective_start_utc BETWEEN ? AND ?         -- params: window_start, window_end
--   AND e.is_cancelled = 0
-- ORDER BY e.effective_start_utc;

-- ============================================================
-- PENDING WRITE QUEUE
-- Writes queue locally and replay on reconnect.
-- Conflict resolution: server state wins on round-trip.
-- ============================================================

CREATE TABLE write_queue (
    id            TEXT PRIMARY KEY,
    event_id      TEXT NOT NULL,
    operation     TEXT NOT NULL,              -- 'create' | 'update' | 'delete'
    payload       TEXT NOT NULL,              -- JSON serialization of the event delta
    created_at    INTEGER NOT NULL,
    attempt_count INTEGER NOT NULL DEFAULT 0,
    last_error    TEXT
);

CREATE INDEX idx_write_queue_event ON write_queue(event_id);

-- ============================================================
-- SYNC LOG (operational, not analytics)
-- Records sync runs for "updated X minutes ago" display only.
-- Do not use this for engagement metrics.
-- ============================================================

CREATE TABLE sync_log (
    id          TEXT PRIMARY KEY,
    account_id  TEXT NOT NULL,
    started_at  INTEGER NOT NULL,
    finished_at INTEGER,
    status      TEXT NOT NULL,               -- 'success' | 'AUTH_EXPIRED' | 'RATE_LIMITED' | 'PROVIDER_DOWN'
    error_detail TEXT
);

-- Only PROVIDER_DOWN status surfaces to the user, as a quiet
-- "updated X minutes ago" timestamp. No blocking error. No banner.
-- AUTH_EXPIRED and RATE_LIMITED are handled silently by the adapter.
