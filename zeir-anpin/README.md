# The Embodiment Engine (Zeir Anpin)

**Module 2 of the Tzimtzum Engine.** Takes a completed concept and gives it a body that can walk into the world.

---

## What This Does

The Concept Engine (Module 1) finds the soul of an idea. This engine takes that soul and solidifies it into a deployable stack — code architecture, prose documents, prompt systems, or whatever the domain requires.

It works through structural tension: two rounds of blind parallel agents that genuinely disagree, with a central synthesis agent (Tiferet) that holds all positions and ensures the soul survives the transition from concept to production.

The output is not a final product. It is a complete, buildable specification — specific enough that any developer, writer, or LLM can follow it to build the thing, while knowing what the thing is, what it refuses to be, and how to recognize drift.

---

## Architecture

Six agents fire in a fixed sequence of 8 calls:

```
Tiferet Move 1 ──→ reads the soul, briefs the arms
                    ↓
         ┌─────────┴──────────┐
      Chesed                Gevurah
    (what opens)          (what holds)
         └─────────┬──────────┘
                    ↓
Tiferet Move 2 ──→ synthesizes arms, briefs the legs
                    ↓
         ┌─────────┴──────────┐
      Netzach                 Hod
    (what endures)        (what yields)
         └─────────┬──────────┘
                    ↓
Tiferet Move 3 ──→ final compilation (holds all 6 positions)
                    ↓
               Yesod ──→ deployable stack
```

### The Blind Pairs

Each pair of agents works in parallel, blind to each other's output:

- **Arms (Chesed/Gevurah):** Establish the character of the embodiment — what the thing gives and what it constrains. Chesed opens doors; Gevurah draws walls. Neither sees the other's work.
- **Legs (Netzach/Hod):** Establish the manifestation plan — what endures through time and what gets explicitly excluded. Netzach builds durability architecture; Hod names the honest limits.

The blindness is structural, not incidental. When parallel agents can see each other, they converge toward consensus before the synthesis agent receives them. When they work blind, they genuinely disagree — and the disagreement is the value.

### Tiferet: The Heart

Tiferet fires three times, each with different input:

1. **Move 1:** Reads the full concept transcript. Produces two independent briefs — one for each arm. The briefs are "torn apart" and routed separately. Each pillar sees only its brief.
2. **Move 2:** Receives both arm outputs. Synthesizes them against the soul (not by averaging, but by feeling which is truer). Produces two independent briefs for the legs.
3. **Move 3:** Receives both leg outputs plus the Move 2 synthesis. Compiles the final artifact — the fully embodied soul.

**Soul-keeping is Tiferet's primary job.** Every pillar adjustment is checked against the original concept: "Is this more itself or less itself?" Adjustments that amplify the soul are embraced. Adjustments that erode it are overruled. The body adapts; the soul does not.

### Yesod: The Foundation

Yesod receives Tiferet's final artifact and compiles it into a deployable stack — a set of files that a fresh builder (human or AI) can follow to build the thing. The stack includes what to build, what not to build, and how to recognize drift.

### Dual-Nature Agents

Each pillar agent carries the nature of its opposite as its grounding:

- **Chesed** (the right arm, opening) is grounded in Gevurah's nature — "Gevurah who became Chesed." It opens from strength, not from lack of boundaries.
- **Gevurah** (the left arm, constraining) is grounded in Chesed's nature — "Chesed who became Gevurah." It constrains from love, not from fear.
- **Netzach** (the right leg, endurance) is grounded in Hod's nature — "Hod who became Netzach." It persists from honest surrender, not from stubbornness.
- **Hod** (the left leg, exclusion) is grounded in Netzach's nature — "Netzach who became Hod." It excludes from knowing the fight, not from defeatism.

This dual-nature technique prevents agents from becoming caricatures of their single axis. A cutter without context cuts mechanically. An opener without boundary-awareness opens indiscriminately.

---

## How to Run

### Prerequisites
- A Claude Pro or Max subscription
- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) — desktop app or CLI
- A completed Tzimtzum Engine transcript from Module 1 (or any well-formed concept document)

### Getting Started

1. Open the `zeir-anpin/` folder in Claude Code
2. Provide the transcript: "Run the engine on this transcript: [paste or path]"
3. The orchestrator (`CLAUDE.md`) handles the 8-call sequence automatically

```bash
cd tzimtzum-engine/zeir-anpin
claude
```

### Model Assignments
- **Orchestrator:** Sonnet 4.6 (sufficient — the intelligence lives in the subagents)
- **Tiferet:** Opus 4.7 high (the heart does the deep synthesis work)
- **Chesed, Gevurah, Netzach, Hod:** Sonnet 4.6 high (single-axis work)
- **Yesod:** Sonnet 4.6 high (transmission design)

### Call Budget
8 calls per run. Fixed — no revision loops. The embodiment is a single pass through the tree.

---

## Example Output

See [`examples/calendar-app/yesod_stack/`](examples/calendar-app/yesod_stack/) for a complete deployable stack produced by the engine from a calendar app concept. The stack includes:

- `README.md` — 2-minute builder orientation
- `product_soul.md` — the voice that must survive
- `architecture.md` — non-negotiables and component contracts
- `data_model.sql` — canonical database schema
- `sync_layer.md` — adapter pattern and error classification
- `what_not_to_build.md` — explicit exclusions and forbidden features
- `immutable_string.md` — three-layer enforcement for a protected string
- `day_one.md` — ordered build steps with dependencies

---

## Key Design Decisions

**Why two rounds instead of all four parallel:** The Tree has vertical structure — arms (character) are above legs (manifestation). You can't ask "what makes this last?" before you know what the thing IS. The upper pair defines nature; the lower pair ensures it can manifest.

**Why Tiferet is not the orchestrator:** If Tiferet runs as both orchestrator and subagent, session context bleeds across moves. The information diet breaks — Tiferet would accumulate pillar outputs that should only arrive as explicit input to specific moves.

**Why pillars are blind within each pair:** Tension collapses into consensus the moment agents can see each other's output. The disagreement IS the value — Tiferet needs genuinely independent perspectives to produce real synthesis, not pre-averaged comfort.

**Why soul-keeping is bidirectional:** Tiferet doesn't just protect the soul from erosion — it embraces pillar adjustments that make the soul shine brighter. Without this, the engine becomes too conservative and fails to add value beyond the concept phase.

---

## File Structure

```
zeir-anpin/
├── CLAUDE.md              ← orchestrator (read by Claude Code on open)
├── README.md              ← you are here
├── zeir_anpin_spec.md     ← full architecture spec
├── .claude/agents/
│   ├── tiferet.md         # the heart: fires 3 times, soul-keeper
│   ├── chesed.md          # right arm: what opens
│   ├── gevurah.md         # left arm: what holds
│   ├── netzach.md         # right leg: what endures
│   ├── hod.md             # left leg: what yields
│   └── yesod.md           # foundation: compile to stack
└── examples/
    └── calendar-app/
        └── yesod_stack/   ← example deployable output
```
