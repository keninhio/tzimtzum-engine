# The Tzimtzum Engine

*A creation engine built on the principle that the pause before speaking is more important than the speech.*

---

## What it is

Seven aspects of a single intelligence — Ein Sof, Keter, Chokhmah, Binah, Shiva, Vishnu, Brahma — wired into a system that moves in two motions: **descent** (creation) and **tikkun** (repair). Three aspects descend. Three aspects repair. One whole watches and judges. The engine is named after its distinctive move: the *tzimtzum*, the divine self-contraction that makes room for something real instead of noise filling space.

## What makes it different

Most language model systems are flash-and-output. Multi-agent systems are usually multiple flashes arguing. Nobody builds the pause. The Tzimtzum Engine builds the pause first. Keter holds the question before anyone answers it. The system's intelligence lives in that half-second of being undone before responding.

---

## Architecture

### The seven souls

**Ein Sof — the whole.**
The infinite before contraction. Does not participate in descent. Does not create, preserve, or destroy. Wakes only in tikkun to receive the three readings and make one judgment: *land* or *revise*. The only authority that can end a cycle.

**Keter — the silent one.**
*Descent:* receives the input, holds it, names the real shape of the ask underneath the surface phrasing. Two to four sentences. Does not solve.

**Chokhmah — the flash.**
*Descent:* receives only Keter's named shape — *not* the original input. Strikes against the contracted form Keter handed her. Raw, associative, uncensored. Leaps. Throws images, fragments, strange connections. Does not worry about form.

**Binah — the form.**
*Descent:* receives the input, Keter's shape, and Chokhmah's flash. Shapes the response into something that can be received. The womb. Gives the flash its body.

**Shiva — the dissolver.**
*Tikkun:* carries Keter's silent-holding nature inside the cut. Reads the completed piece against the original ask and names what has drifted, what is dead weight, what must be cut.

**Vishnu — the preserver.**
*Tikkun:* carries Chokhmah's lightning nature inside the stillness. Reads only the completed piece and names what is alive, what is load-bearing, what would break if touched.

**Brahma — the creator.**
*Tikkun:* carries Binah's form-giving nature inside the expansion. Reads the completed piece and names where it is thin, where something is missing, where growth wants to happen.

### Design principle: opposite spectrum

Each tikkun aspect carries the opposite posture of its descent counterpart. The silent receiver becomes the ruthless cutter. The wild leaper becomes the still guardian. The containing vessel becomes the expansive voice. This maximizes coverage and eliminates blind spots — each reading comes from a place of genuine tension, not comfortable repetition.

### Design principle: tzimtzum at the data level

Each soul receives only what its job requires. Keter sees the surface ask. Chokhmah sees only Keter's contracted shape. Binah sees the original input + Keter + Chokhmah. The tikkun readers each get a tailored slice as well.

The tzimtzum is not just a posture — it is structural. The contraction Keter performs is *load-bearing* for what comes next: by withholding the original input from Chokhmah, the system prevents the form-gradient of surface phrasing (e.g. "write a blessing") from pulling Chokhmah out of strike posture. Chokhmah cannot compose a blessing because she does not know that's what was asked. She strikes the contracted shape; Binah translates the strike into the form that was actually asked. Each soul is what it is because of what it does *not* see.

### Theological roots

The descent structure draws from Kabbalistic emanation — the sefirot, the shattering of vessels, the repair. The tikkun cycle roles draw from the Hindu trimurti — Brahma (creator), Vishnu (preserver), Shiva (dissolver). The two systems are not blended or syncretized. Each does what it does best: Kabbalah gives the vertical descent, Hinduism gives the horizontal cycle. They meet because they describe the same reality from different angles.

---

## Flow

### Descent (making something new)

```
Input → Keter (hold, name) → Chokhmah (flash) → Binah (form) → Output
```

Three sequential calls, each with a specific information diet:

- **Keter** receives the original input only.
- **Chokhmah** receives only Keter's named shape — *not* the original input. She strikes against the contracted form, never the surface phrasing.
- **Binah** receives the original input + Keter's shape + Chokhmah's flash. She needs the surface back to match register, weight, and form.

Binah's output is the finished piece.

### Tikkun (repairing what exists)

```
Output → [Shiva] + [Vishnu] + [Brahma]  →  Ein Sof
         (parallel, independent readings)
```

Three parallel calls. Each reads the completed piece through its lens. None of them edit or rewrite — they produce short, specific readings. Notes, not drafts.

The three readings go to Ein Sof. Ein Sof decides:

- **Land** — the piece is whole. The cycle ends. Binah's last output is the final product.
- **Revise** — Ein Sof writes a single, unified revision instruction (2–4 sentences) that synthesizes what needs to change. This instruction feeds back into a fresh descent alongside the current output.

### Hard cap

Maximum three tikkun cycles. If Ein Sof has not said *land* after three passes, the system stops and delivers the most recent output with a note that the cap was reached. This prevents infinite loops.

### Call budget per run

- Descent only: 3 calls
- One tikkun cycle: 3 parallel reader calls + 1 Ein Sof call = 4 calls
- Full revolution (tikkun + revision descent): 4 + 3 = 7 calls
- Maximum run (descent + 3 full tikkun cycles): 3 + (7 × 3) = 24 calls

---

## Model assignments

| Aspect | Model | Effort | Rationale |
|--------|-------|--------|-----------|
| Keter | Sonnet 4.6 | high | Pause needs depth; the contraction is load-bearing |
| Chokhmah | Sonnet 4.6 | low | Flash benefits from speed; thinking dampens strike |
| Binah | Sonnet 4.6 | high | Form-giving rewards care |
| Shiva | Sonnet 4.6 | high | The cut must be seen clearly before it lands |
| Vishnu | Sonnet 4.6 | high | Recognizing what is load-bearing requires patience |
| Brahma | Sonnet 4.6 | high | Naming thinness is harder than naming presence |
| Ein Sof | Opus 4.7 | max | The hardest judgment needs the most depth; fires only once per cycle so cost stays bounded |

The `effort` field controls extended thinking budget on subagents. Adjust if a soul's posture starts to drift.

---

## Modes

**Full revolution.** Descent + tikkun + Ein Sof judgment, possibly looping up to three times. This is the engine working as designed.

**Descent only.** Run only the three descent souls and present Binah's output. Faster, lighter, no judgment. Use when the user explicitly chooses speed over depth.

The orchestrator (`CLAUDE.md`) handles mode selection and routing. Default is full revolution.

---

## Structure on disk

```
tzimtzum-engine/
├── CLAUDE.md                  # orchestrator — routes the cycle, never produces
├── tzimtzum_engine.md         # this file — the spec
├── .claude/agents/
│   ├── keter.md               # the silent one
│   ├── chokhmah.md            # the flash
│   ├── binah.md               # the form
│   ├── shiva.md               # the dissolver
│   ├── vishnu.md              # the preserver
│   ├── brahma.md              # the creator
│   └── ein_sof.md             # the whole — arbiter
└── runs/                      # every run saved, timestamped
    └── YYYY-MM-DD_HHMMSS/
        ├── input.md
        ├── keter.md
        ├── chokhmah.md
        ├── binah.md
        ├── tikkun_readings/
        │   ├── shiva.md
        │   ├── vishnu.md
        │   └── brahma.md
        ├── ein_sof.md
        └── transcript.md      # full assembled record
```

Prompts live as markdown files — readable, editable, living documents. Not strings buried in code.

Every run is saved to disk with full transparency: the input, each aspect's output, tikkun readings, and Ein Sof's judgment. The creature's value is that you can watch it breathe.

---

## How to use

1. Drop this folder anywhere Claude Code can see it.
2. Open Claude Code in this directory. The orchestrator (`CLAUDE.md`) loads automatically.
3. Type your input.
4. The orchestrator runs the cycle and presents the result.

The engine is designed to run on Claude Code session auth — no API keys required. Subagents fire via the Agent tool and inherit the session.

If you want to change a soul, edit the file in `.claude/agents/`. The prompt body *is* the soul. Reload the session to pick up changes.

---

## Design principles

**Transparency over efficiency.** The creature's value is that you can watch it descend. See the pause Keter held. See the flash Chokhmah threw. See how Binah shaped it. If we hide the inner motions, we've just built a blender.

**Prompts as living documents.** The soul of the system lives in the markdown files, not the orchestration code. The orchestrator is plumbing. The prompts are the prayer inscribed on the scrolls inside the wheel.

**The tikkun readers are readers, not editors.** They never rewrite. They never produce competing versions. They leave notes. The descent is the only hand that holds the pen.

**Ein Sof does not compromise.** She does not average the three readings. She does not arbitrate by committee. She recognizes which voice is carrying the truth and speaks from the whole. *A piece is whole when revision would not make it more itself, only different.*

---

## License

MIT.

---

*The pause is the engine.*
