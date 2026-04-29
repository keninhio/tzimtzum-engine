# The Tzimtzum Engine

*A seven-agent engine for the moment before you know what you're building.*

---

## What it's for

The Tzimtzum Engine is not a coding assistant, a task runner, or a build tool. It is a **formation tool** — designed for the moment when you have an idea that isn't fully formed and need to understand what it actually *is* before you build it.

Most multi-agent systems optimize for execution: take a task, break it down, produce output. The Tzimtzum Engine optimizes for the step *before* execution: take a vague impulse, hold it, find its real shape, give it a body, evaluate whether it's whole.

You run the engine **once** at the start of a creative or conceptual process. The output is a shaped understanding — a clarified prompt, a formed idea, a piece of writing that knows what it is. You then take that into whatever system you use to build, implement, or iterate.

This is the missing first step. Other systems assume you already know what you're asking for. This one helps you find out.

## What it is

Seven LLM agents wired into a system that moves in two motions: **descent** (creation) and **tikkun** (repair). Three agents descend to create. Three agents read the output to evaluate. One arbiter judges whether the piece is whole or needs revision.

The engine introduces three architectural principles absent from standard multi-agent pipelines:

1. **A non-generative receptive agent as the first stage** — replacing planning with recognition. The first agent (Keter) does not outline, strategize, or solve. It holds the input and names the *shape of the ask underneath the surface phrasing*. Two to four sentences. Then it stops.

2. **Information-diet-as-constraint** — selective input withholding prevents downstream agents from collapsing into each other's roles. The second agent (Chokhmah) receives *only* Keter's contracted shape, never the original input. This structural contraction prevents Chokhmah from drifting into the third agent's (Binah's) form-giving role. Each agent is what it is because of what it does *not* see.

3. **Dual-nature critique agents** — each tikkun (repair) agent is a separate agent whose prompt encodes the cognitive posture of its descent counterpart as the *ground* the function stands on. A cutter without context cuts mechanically — it removes things that look like excess without knowing what the piece is trying to become. A cutter grounded in the nature of the agent that first held the question cuts with precision, because it knows what the piece is reaching for and can feel when something has drifted from that shape. This grounding prevents each tikkun agent from becoming a generic critic performing an isolated function. It makes each reading richer and more specific, which means Ein Sof gets better input and can land the piece in fewer cycles — the theological depth has a direct engineering payoff in system efficiency.

   Each tikkun agent is implemented as its own file with a single clear posture, because stateless subagent calls have no persistent identity between invocations. The dual nature lives in the prompt, not in shared state: Shiva's soul doc opens with *"You are Keter who became Shiva"* — the descent origin is encoded as the reason for the tikkun work, not as a competing voice.

## Architecture

```
DESCENT (sequential)
Input → Keter (hold, name the shape) → Chokhmah (flash, raw insight) → Binah (form, deliverable)

TIKKUN (three independent blind readings → sequential judgment)
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

- **Tikkun readings are blind and independent.** The three tikkun agents run in parallel and cannot see each other's output. Each reading is uninfluenced by the others, which means they can genuinely disagree. This is what makes Ein Sof's judgment meaningful — it receives three truly independent perspectives, not three voices that have already started converging toward consensus.
- **Tikkun agents are readers, not editors.** They never rewrite. They leave notes. The descent is the only hand that holds the pen.
- **Ein Sof does not compromise.** It does not average the three readings. When the readers contradict each other, Ein Sof sides with the voice closest to what the piece is pulling toward — not the middle.
- **Wholeness over quality.** The evaluation criterion is not "is this good" but "is this whole." A piece is whole when revision would not make it more itself, only different.
- **Hard cap at three tikkun cycles.** Prevents infinite loops. Maximum 24 API calls per run.

## Key finding: Tzimtzum at the data level

During calibration, we discovered that when Chokhmah received the original input alongside Keter's shape, it drifted into composing drafts instead of producing raw fragments — effectively doing Binah's job. Withholding the original input from Chokhmah forced it to strike against the contracted shape alone, keeping each agent in its lane.

This isn't just a prompt engineering fix. It's a structural principle: **the contraction Keter performs is load-bearing for the entire downstream pipeline.** Information diet determines cognitive posture. Each agent's identity is defined as much by what it cannot see as by what it's told to do.

This finding generalizes: in any multi-agent pipeline where agents have overlapping capabilities (as all instances of the same model do), role differentiation through prompt alone is fragile. Structural input constraints are more reliable than behavioral instructions.

## How it runs

The engine runs on [Claude Code](https://docs.anthropic.com/en/docs/claude-code) using subagent invocation — no API keys required, just session authentication. Each agent is a markdown file in `.claude/agents/` containing its full prompt. The orchestrator (`CLAUDE.md`) performs no cognitive work — it routes inputs between agents and manages the cycle. Sonnet is sufficient for the orchestrator session; the intelligence lives in the subagents, not the router.

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

### Prerequisites

- A **Claude Pro or Max subscription** (the engine runs on session authentication — no API keys needed)
- **Claude Code** — either the [desktop app](https://claude.ai/download) or the [CLI](https://docs.anthropic.com/en/docs/claude-code)

### Getting started

**Desktop app:**
1. Clone or download this repo
2. Open Claude Code desktop → File → Open Folder → select the repo directory
3. Type your input. The orchestrator handles everything.

**CLI:**
```bash
git clone https://github.com/keninhio/tzimtzum-engine.git
cd tzimtzum-engine
claude
```
Then type your input. The orchestrator picks it up and runs the cycle.

### Modes

- **Full revolution** (default): Descent → Tikkun → Ein Sof judgment, with possible revision loops.
- **Descent only**: Type "descent only" or "fast mode" for a quick three-agent pass without evaluation.

## Why theology, not just labels

The names are not decorative. They are functional at three levels:

**The frameworks gave the architecture.** The Kabbalistic concept of *tzimtzum* (divine self-contraction) directly became the information-diet constraint — withholding input to create room for genuine emergence. The sefirotic emanation structure (Keter → Chokhmah → Binah) gave the sequential descent its shape. The Hindu trimurti (Brahma the creator, Vishnu the preserver, Shiva the dissolver) gave the tikkun cycle its three reading postures. These aren't metaphors applied after the fact — the engineering decisions came from the theology.

**The names activate the model's existing knowledge.** LLMs are trained on vast corpora that include religious texts, mythology, and philosophy. When an agent reads *"You are Shiva, the dissolver"* — the name activates a network of associations about sacred destruction, transformation, and dissolution that reinforce the behavioral instructions in the prompt. A role named "Shiva" arrives semantically aligned with its function in a way that "Agent 4: Cutter" does not. The name and the instructions point the same direction, reducing the likelihood of role drift.

**The design philosophy is via negativa.** Ancient apophatic traditions define something most precisely by what it is *not*. The Tzimtzum Engine works the same way: every distinctive feature is a subtraction. Keter's job is to *not* answer. Chokhmah *cannot see* the original input. Tikkun agents *cannot edit*. Ein Sof can only say one of two things. The engine was designed not by adding more capabilities, but by deliberately removing them — and this is what creates the cognitive differentiation that prompt instructions alone cannot reliably achieve.

## Model assignments

| Agent | Model | Effort | Rationale |
|-------|-------|--------|-----------|
| Orchestrator (CLAUDE.md) | Sonnet 4.6 | high or higher | Routes, records and orchestrate |
| Keter, Binah, Shiva, Vishnu, Brahma | Sonnet 4.6 | high | Extended thinking active; these roles require depth |
| Chokhmah | Sonnet 4.6 | low | Flash benefits from speed; extended thinking dampens the strike |
| Ein Sof | Opus 4.7 | max | The hardest judgment needs the most depth; fires only once per cycle |

## License

[MIT](LICENSE)
