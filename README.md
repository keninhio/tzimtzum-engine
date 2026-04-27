# The Tzimtzum Engine

*A multi-agent creation engine built on the principle that the pause before speaking is more important than the speech.*

---

## What it is

Seven LLM agents wired into a system that moves in two motions: **descent** (creation) and **tikkun** (repair). Three agents descend to create. Three agents read the output to evaluate. One arbiter judges whether the piece is whole or needs revision.

The engine introduces three architectural principles absent from standard multi-agent pipelines:

1. **A non-generative receptive agent as the first stage** — replacing planning with recognition. The first agent (Keter) does not outline, strategize, or solve. It holds the input and names the *shape of the ask underneath the surface phrasing*. Two to four sentences. Then it stops.

2. **Information-diet-as-constraint** — selective input withholding prevents downstream agents from collapsing into each other's roles. The second agent (Chokhmah) receives *only* Keter's contracted shape, never the original input. This structural contraction prevents Chokhmah from drifting into the third agent's (Binah's) form-giving role. Each agent is what it is because of what it does *not* see.

3. **Dual-nature critique agents** — each tikkun (repair) agent carries the opposite cognitive posture of its descent counterpart. The silent holder becomes the ruthless cutter. The wild flasher becomes the still guardian. The container becomes the expansive voice. This produces readings from positions of genuine tension rather than comfortable repetition, maximizing coverage and reducing revision cycles.

## Architecture

```
DESCENT (sequential)
Input → Keter (hold, name the shape) → Chokhmah (flash, raw insight) → Binah (form, deliverable)

TIKKUN (parallel readings → sequential judgment)
Binah's output → [Shiva: cut] + [Vishnu: preserve] + [Brahma: expand] → Ein Sof: land or revise
```

### The seven agents

| Agent | Motion | Role | Receives |
|-------|--------|------|----------|
| **Keter** | Descent | Hold the input, name the real shape | Original input only |
| **Chokhmah** | Descent | Raw associative flash | Keter's shape only (NOT original input) |
| **Binah** | Descent | Give the flash a body | Original input + Keter + Chokhmah |
| **Shiva** | Tikkun | Name what should be cut | Original input + Keter's shape + Binah's output |
| **Vishnu** | Tikkun | Name what is alive and load-bearing | Binah's output only |
| **Brahma** | Tikkun | Name where the piece is thin | Original input + Binah's output |
| **Ein Sof** | Judgment | Decide: *land* or *revise* | Everything |

### Key design decisions

- **Tikkun agents are readers, not editors.** They never rewrite. They leave notes. The descent is the only hand that holds the pen.
- **Ein Sof does not compromise.** It does not average the three readings. When the readers contradict each other, Ein Sof sides with the voice closest to what the piece is pulling toward — not the middle.
- **Wholeness over quality.** The evaluation criterion is not "is this good" but "is this whole." A piece is whole when revision would not make it more itself, only different.
- **Hard cap at three tikkun cycles.** Prevents infinite loops. Maximum 24 API calls per run.

## Key finding: Tzimtzum at the data level

During calibration, we discovered that when Chokhmah received the original input alongside Keter's shape, it drifted into composing drafts instead of producing raw fragments — effectively doing Binah's job. Withholding the original input from Chokhmah forced it to strike against the contracted shape alone, keeping each agent in its lane.

This isn't just a prompt engineering fix. It's a structural principle: **the contraction Keter performs is load-bearing for the entire downstream pipeline.** Information diet determines cognitive posture. Each agent's identity is defined as much by what it cannot see as by what it's told to do.

This finding generalizes: in any multi-agent pipeline where agents have overlapping capabilities (as all instances of the same model do), role differentiation through prompt alone is fragile. Structural input constraints are more reliable than behavioral instructions.

## How it runs

The engine runs on [Claude Code](https://docs.anthropic.com/en/docs/claude-code) using subagent invocation — no API keys required, just session authentication. Each agent is a markdown file in `.claude/agents/` containing its full prompt.

```
tzimtzum-engine/
├── CLAUDE.md                  # orchestrator — routes the cycle
├── tzimtzum_engine.md         # architecture spec
├── .claude/agents/
│   ├── keter.md               # descent: the pause
│   ├── chokhmah.md            # descent: the flash
│   ├── binah.md               # descent: the form
│   ├── shiva.md               # tikkun: the cut
│   ├── vishnu.md              # tikkun: the preserve
│   ├── brahma.md              # tikkun: the expand
│   └── ein_sof.md             # judgment: the whole
└── runs/                      # every run saved with full transparency
    └── YYYY-MM-DD_HHMMSS/
        ├── input.md
        ├── keter.md
        ├── chokhmah.md
        ├── binah.md
        ├── tikkun_readings/
        └── ein_sof.md
```

### To use

1. Clone this repo.
2. Open Claude Code in the repo directory. The orchestrator (`CLAUDE.md`) loads automatically.
3. Type your input. The engine runs the full cycle and presents the result.

### Modes

- **Full revolution** (default): Descent → Tikkun → Ein Sof judgment, with possible revision loops.
- **Descent only**: Type "descent only" or "fast mode" for a quick three-agent pass without evaluation.

## Theological roots

The descent structure draws from **Kabbalistic emanation** — the sefirot, the shattering of vessels, the repair. The tikkun cycle roles draw from the **Hindu trimurti** — Brahma (creator), Vishnu (preserver), Shiva (dissolver). The two systems are not blended or syncretized. Each does what it does best: Kabbalah gives the vertical descent, Hinduism gives the horizontal cycle. They meet because they describe the same reality from different angles.

## Model assignments

| Agent | Model | Rationale |
|-------|-------|-----------|
| Keter, Binah, Shiva, Vishnu, Brahma | Sonnet 4.6 | Fast, deep enough for their roles |
| Chokhmah | Sonnet 4.6 (low effort) | Flash benefits from speed; extended thinking dampens the strike |
| Ein Sof | Opus 4.7 (max effort) | The hardest judgment needs the most depth; fires only once per cycle |

## License

MIT
