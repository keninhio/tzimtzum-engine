# What Not to Build

This file is load-bearing. Read it before scoping any feature. Read it when someone says "what if we just...". Read it when growth pressure arrives, because it will.

The exclusions here are not aspirational or provisional. They are the product's shape. Removing an exclusion is not a product decision — it is a decision to build a different product.

---

## The feature test

Before any new feature:

> Does this feature require noticing the empty hour in order to function?

If yes: out. Not scoped down. Out.

---

## Integrations forbidden by name

Do not integrate with, accept data from, or provide data to:

- Notion
- Linear
- Asana
- Todoist
- ChatGPT (or any OpenAI product)
- Cal.ai
- Reclaim
- Motion
- Slack

No plugin ecosystem. No developer API for adding UI into the calendar. No plugin marketplace. Third parties write to CalDAV/iCal like everyone else; they get no special surface.

---

## User populations this product is not for

The product is for one person managing their own time. These populations are explicitly excluded:

**Teams.** No "invite your team" prompt. No shared workspace. No organization object in the data model. The answer to "why not pivot to teams?" is: that is a different product. Not "not yet." Not "in a future version." A different product.

**Enterprise.** No SSO. No admin dashboard. No seats pricing. No SOC 2 marketed as a feature.

**Project management.** No task lists converting to events. No Gantt view. No milestones.

**Habit tracking.** No streaks, ever, in any visual form. The product does not know if you showed up.

**Journaling.** No post-event prompt. The event ends. The app does not follow you out.

**Wellness.** Not a mindfulness calendar. No opinions on breaks. The product does not know what a good week looks like for you.

**People who want to be optimized.** No "great job protecting your morning." No congratulations for any calendar behavior.

**"High performers," "intentional people," "people who want to do less."** That framing is the forbidden identity. If you feel the product rebranding toward this, it has gone wrong. The product retires before it rebrands into what it refused to be.

---

## Metrics the company is not allowed to optimize

- DAU
- MAU
- Time in app
- Engagement metrics of any kind driving feature decisions
- A/B testing on emotional copy — the settings line is not A/B tested; onboarding is not tested for conversion
- Cohort analysis feeding back into stickiness
- NPS campaigns

**Permitted:** crash rates, sync success/failure rates, performance against the 800ms budget.

---

## The data commitment

The company is not allowed to know what events its users put in their calendars. Not in aggregate. Not anonymized. The content of the calendar is not data.

This is an architectural commitment, not just a privacy policy. The backend does not parse event titles. It does not categorize event types. It does not derive patterns. Calendar content flows through the system opaque to the company.

---

## Copy that is not allowed anywhere in the product

These are not guidelines. They are the phrases that mean the soul has gone.

- "protect your time"
- "intentional"
- "focus time"
- "deep work"
- "mindful"
- "your best week"
- "you have a free hour"
- "unscheduled time"
- "enjoy your freedom"
- "we leave room here intentionally"
- "we believe..."
- "Taking a moment." / "Breathing." (loading screen)
- "nothing here — keep it that way?"
- "Oops, we know."

Functional alternatives that are allowed:
- "No events today" (empty state)
- "Error syncing calendar. Try again." (error state)
- "Updated X minutes ago" (sync status)
- "page not found" (404)

---

## Paid tier rules

If a paid tier exists, it expands capacity only:
- More calendars
- More accounts
- More storage
- Color themes

It does not introduce functionality that frames open time as a problem. Not under any name. Not rebranded as "smart" or "AI-powered." Not as a "Pro" feature. Not ever.

---

## Year-two refusals (rehearse these now)

When these conversations happen — and they will — the answers are already decided:

**Investor: "every other calendar is adding AI."**
Response: "yes." Full stop. Not "we're thinking about it." Not "our approach is different." Just: yes.

**Investor: "why not pivot to teams?"**
Response: "that is a different product and we are not building it." Not "not yet." Not "maybe eventually."

**Board pressure to add streaks "that feel different."**
Response: refused. Streaks are streaks. The visual form does not change what they are.

**Pressure to rebrand around "intentional people" or "focus."**
Response: refused. Same move as "high performers." The product retires before it rebrands into what it refused to be.

---

## The designed-ajar trap

There is a temptation to make the incompleteness intentional — to say "we leave room here on purpose" or put a roadmap line reading "intentional negative space." This kills the thing.

The honest answer to "why isn't this finished?" is: "we just haven't gotten there."

- No internal ticket reading "keep incomplete by design"
- No roadmap line reading "intentional negative space"
- No tooltip "we leave room here intentionally"
- No FAQ "we believe..."

Designed-ajar turns the absence into a statement. The absence must stay absent. Build it anyway and let it be a calendar.
