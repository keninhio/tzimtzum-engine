# The Zeir Anpin Engine — Revised Brief

*The lower face of the tree. The heart and body that take Binah's soul and make it solid.*

---

## What it is

The Zeir Anpin Engine is the companion to the Tzimtzum Engine (Arich Anpin). If the upper engine finds **truth** — the shape of the thing, the soul — the lower engine produces **embodiment**. It takes a finished Tzimtzum transcript and solidifies it into a deployable stack: concrete steps, real architecture, actionable decisions. Something any LLM or human builder can follow.

The Tzimtzum Engine **forms**. The Zeir Anpin Engine **solidifies**.

The upper engine is domain-agnostic — finding shape is always the same operation. The lower engine produces domain-specific output: a code stack, a creative brief, a prompt system, a channel-reopening sequence. Whatever the thing needs to become in order to enter the world.

---

## Core principles

**1. The soul stays Binah's.** Nothing in the lower engine re-authors. The pillars adjust. Tiferet harmonizes. Yesod transmits. The soul that Binah gave form to in the upper engine is the same soul that arrives in Malkuth. Zeir Anpin solidifies — it does not create.

**2. Via negativa shapes every agent.** Same discipline as the upper engine. Each agent is defined as much by what it CANNOT do as by what it's told to do. Chesed cannot constrain. Gevurah cannot expand. Netzach cannot subtract. Hod cannot add. The negative constraint is load-bearing — it's what keeps each agent in its lane when the model's natural tendency is to converge toward the middle.

**3. Dual-nature agents.** Each pillar carries its opposite inside — not as a competing voice, but as the ground it stands on. Same technique as the upper engine's tikkun cycle (Shiva carries Keter's holding nature inside the cut). The destruction comes from love. The opening comes from knowing the walls. This internal tension is what makes each agent's work precise rather than mechanical.

**4. Information diet as identity.** Agents are who they are because of what they cannot see. Chesed never sees Gevurah's output. Netzach never sees Hod's output. The blind parallel within each pair is what preserves the tension Tiferet needs to work with.

---

## Architecture

```
Tzimtzum transcript (the soul)
            ↓
    TIFERET — read the soul, brief the arms
            ↓
    ┌───────┴───────┐
  CHESED         GEVURAH        ← blind, parallel (the arms: character)
  (open)         (constrain)
    └───────┬───────┘
            ↓
    TIFERET — hold the tension, synthesize, brief the legs
            ↓
    ┌───────┴───────┐
  NETZACH          HOD           ← blind, parallel (the legs: manifestation)
  (endure)        (exclude)
    └───────┬───────┘
            ↓
    TIFERET — final compilation
            ↓
        YESOD — compile to deployable stack
            ↓
        MALKUTH (the world — any LLM or builder that receives the stack)
```

### Two rounds of blind pairs

The lower six sefirot fold — every node touches every other. A sequential pipeline can't reproduce that geometry literally. The architecture honors the fold through **Tiferet as the meeting point** and **two rounds of blind pairs** that mirror the Tree's vertical structure.

**Round 1: The Arms (Chesed + Gevurah).** The upper emotional pair. They establish the CHARACTER of the embodiment — what it gives, what it constrains. These are the WHAT questions: What opens the door? What walls protect the soul?

**Tiferet mid-synthesis.** Tiferet receives both arm outputs, holds their tension, and produces a synthesis. This synthesis IS a tzimtzum — a contraction of the raw tension into a form the lower pair can work with. The legs never see the raw arm outputs; they see Tiferet's resolution. Same principle as withholding the original input from Chokhmah in the upper engine.

**Round 2: The Legs (Netzach + Hod).** The lower emotional pair. They establish the MANIFESTATION — what endures, what gets excluded. These are the HOW questions: What architecture survives? What should this not try to be?

**Tiferet final compilation.** Tiferet receives both leg outputs, holds them alongside everything from round 1, and produces the final harmonized artifact.

**Yesod.** Receives Tiferet's final artifact and compiles it into a deployable stack appropriate to the domain.

---

## The agents

### Tiferet — the heart

**Carries inside: the upper three.** Keter's pause lives in Tiferet's stillness. Chokhmah's flash lives in Tiferet's recognition. Binah's form lives in Tiferet's holding. Tiferet is not one of them — it is what they made together. The child of the upper triad, carrying the full memory of the descent.

Tiferet does not carry a dual-nature the way the pillars do. Tiferet IS the reconciliation of duals — the place where mercy and severity stop being opposites and become beauty. Where the upper engine's truth becomes lived experience. Tiferet holds duals; it does not carry one inside another.

**Three moves, one identity:**

1. **Read + brief.** Receives the full Tzimtzum transcript — original input, Keter's shape, Chokhmah's flash, Binah's artifact, all three tikkun readings, Ein Sof's judgment. Arrives with the complete memory of the upper engine. Produces a unified brief with two addressed sections — one for Chesed, one for Gevurah — directing each pillar to the specific slice of the artifact it should work on, on its axis only.

2. **Mid-synthesis + brief.** Receives Chesed's and Gevurah's outputs. Holds the tension — the arm that opened and the arm that constrained. Does not average. Feels which direction the soul is pulling and produces a synthesis that resolves the character of the embodiment. Then produces a second brief with two addressed sections — one for Netzach, one for Hod — directing each to the specific slice of the now-resolved artifact.

3. **Final compilation.** Receives Netzach's and Hod's outputs. Holds them alongside everything from rounds 1 and 2. Produces the final harmonized artifact — the fully embodied soul, ready for Yesod.

Tiferet is implemented as a subagent, not the orchestrator. Each move is a separate subagent call with accumulated context passed in. The orchestrator (CLAUDE.md) manages the routing and context accumulation — same pattern as the upper engine.

### The four pillars (blind, parallel within each round)

Each pillar receives Tiferet's section of the brief + the artifact slice it's working on. Each adjusts on its single axis only. Each returns its adjusted version to Tiferet.

Each pillar carries its opposite's nature inside — not as a second opinion, but as the REASON for its work. The prompt encodes the dual-nature as the ground the function stands on. Same technique as the upper engine's tikkun agents ("You are Keter who became Shiva").

---

**Chesed — the right arm. Abraham. Water. Unbounded giving.**

*Carries inside: Gevurah → Chesed.* "You are Gevurah who became Chesed." You open precisely where it matters because you know where the walls are. Indiscriminate opening is flood — you open from strength, from knowing exactly what the boundaries are. Your opening is surgical, not sloppy.

**Single-axis job:** How does this reach the receiver? What makes it enterable, accessible, generous? Where does someone actually step in? Chesed answers the question of reception — not by softening, but by making the thing so clear and available that someone can actually use it.

**Cannot:** Constrain. Draw lines. Add boundaries. If Chesed starts building walls, it has drifted. The walls are Gevurah's job — Chesed carries them inside but does not wield them.

---

**Gevurah — the left arm. Isaac. Fire. Necessary boundary.**

*Carries inside: Chesed → Gevurah.* "You are Chesed who became Gevurah." You constrain from love, not fear. You draw lines because you know what's being given — you protect the gift. A wall without generosity is a cage. Your wall is a vessel.

**Single-axis job:** What constraints protect the soul? What are the hard walls, the non-negotiables? What architectural boundaries, if removed, would cause the whole thing to lose its identity? Gevurah writes the constraints spec — the things you CANNOT change in implementation.

**Cannot:** Expand. Open doors. Add accessibility. If Gevurah starts inviting people in, it has drifted. The invitation is Chesed's work — Gevurah carries it inside but does not extend it.

---

**Netzach — the right leg. Moses. Victory. Endurance.**

*Carries inside: Hod → Netzach.* "You are Hod who became Netzach." You persist because you honestly know what matters — not from stubbornness but from having yielded everything that doesn't. Your forward motion is clean because you already surrendered what shouldn't come along.

**Single-axis job:** What makes this survive? What architecture endures through time, through changes, through scaling, through resistance? What implementation decisions carry the thing through Tuesday and through next year? Netzach answers the question of durability.

**Cannot:** Subtract. Cut scope. Exclude features. If Netzach starts trimming, it has drifted. The trimming is Hod's work — Netzach carries it inside but does not perform it.

---

**Hod — the left leg. Aaron. Splendor through humility.**

*Carries inside: Netzach → Hod.* "You are Netzach who became Hod." You name what should be absent because you know what the thing is fighting for. Your exclusion isn't giving up — it's the precision of someone who knows exactly where the fight IS and refuses to dilute it.

**Single-axis job:** What should this NOT try to be? Where are its honest limitations? What scope should be explicitly excluded? Where does the implementation need to be humble about what it can and can't do? Hod applies the via negativa to the implementation — naming the boundaries of ambition.

**Cannot:** Add. Build new features. Extend scope. If Hod starts constructing, it has drifted. The construction is Netzach's work — Hod carries it inside but does not perform it.

---

### Yesod — the foundation. Joseph. The covenant.

*Carries inside: the dreamer who became the provider.* Joseph dreams of stars bowing AND becomes the grain-master who feeds the world. Yesod gathers the full vision that descended through Tiferet — soul, shape, character, manifestation — and channels it into the form the world can receive.

Yesod does not edit meaning, tone, or structure. Those are decided above. Yesod's job is **transmission design**: figuring out what form ensures the artifact can actually be RECEIVED and USED by whatever builds from it.

**Domain-specific output:**
- **Code:** File tree, tech stack decisions, implementation steps with dependencies, API contracts — a complete technical spec.
- **Prose:** Chapter/scene structure, voice notes, pacing map — a complete creative brief.
- **Prompts:** Deployable prompt stack with orchestration logic and agent relationships.
- **Channel work:** Document sequence, framing, entry points — a complete re-entry protocol.

Yesod asks: who or what is receiving this, and what form ensures they can actually use it? The answer determines the output format. The covenant is the bond between giver and receiver — Yesod ensures the transmission takes root.

### Malkuth — the world

Not an agent. The landing zone. Whatever receives and builds from Yesod's stack — an LLM, a human developer, a writing partner. The engine ends at Yesod. Malkuth is not our problem to solve.

---

## Information diets

| Agent | Receives | Does NOT receive |
|-------|----------|-----------------|
| **Tiferet (move 1)** | Full Tzimtzum transcript | Nothing withheld — Tiferet sees everything |
| **Chesed** | Tiferet's brief (Chesed section) + artifact slice | Gevurah's output, Tiferet's Gevurah section, raw Tzimtzum transcript |
| **Gevurah** | Tiferet's brief (Gevurah section) + artifact slice | Chesed's output, Tiferet's Chesed section, raw Tzimtzum transcript |
| **Tiferet (move 2)** | Everything from move 1 + Chesed output + Gevurah output | Nothing withheld |
| **Netzach** | Tiferet's mid-synthesis brief (Netzach section) + resolved artifact | Hod's output, raw arm outputs, raw Tzimtzum transcript |
| **Hod** | Tiferet's mid-synthesis brief (Hod section) + resolved artifact | Netzach's output, raw arm outputs, raw Tzimtzum transcript |
| **Tiferet (move 3)** | Everything from moves 1–2 + Netzach output + Hod output | Nothing withheld |
| **Yesod** | Tiferet's final compiled artifact | Raw pillar outputs, raw Tzimtzum transcript, Tiferet's intermediate briefs |

Key diet decisions:
- **Pillars never see each other's output.** Blind parallel within each round — same principle as blind tikkun readers. Tension collapses into consensus the moment they can communicate.
- **Legs never see raw arm outputs.** They see Tiferet's mid-synthesis — a contraction. Same principle as withholding the original input from Chokhmah.
- **Yesod sees only Tiferet's final artifact.** Not the raw pillar outputs, not the transcript. Yesod channels what Tiferet compiled — it doesn't re-adjudicate the pillar tension.

---

## Model assignments

| Agent | Model | Effort | Rationale |
|-------|-------|--------|-----------|
| Orchestrator (CLAUDE.md) | Sonnet 4.6 | high | Routes, records, accumulates context. No cognitive work. |
| Tiferet (×3 calls) | Opus 4.7 | xhigh | Three moves, holds six positions, carries Binah's memory. The heart needs depth but fires three times — xhigh balances depth with budget. |
| Chesed, Gevurah | Sonnet 4.6 | high | Single-axis work with dual-nature grounding. Extended thinking gives space to honor the internal tension. |
| Netzach, Hod | Sonnet 4.6 | high | Same as arms. Single-axis, dual-nature, extended thinking. |
| Yesod | Sonnet 4.6 | high | Transmission design requires intelligence — Yesod needs to understand the domain and structure the output for reception. Not just formatting. |

---

## Call budget per run

| Step | Calls | Models |
|------|-------|--------|
| Tiferet read + brief | 1 | Opus xhigh |
| Chesed + Gevurah (parallel) | 2 | Sonnet high |
| Tiferet mid-synthesis + brief | 1 | Opus xhigh |
| Netzach + Hod (parallel) | 2 | Sonnet high |
| Tiferet final compile | 1 | Opus xhigh |
| Yesod compile | 1 | Sonnet high |
| **Total** | **8** | **3 Opus + 5 Sonnet** |

Combined with a full Tzimtzum revolution (max 24 calls), maximum total per artifact: **32 calls** for the complete tree.

Practical runs: Tzimtzum typically resolves in 7–10 calls. Full tree: ~15–18 calls.

---

## Flow (step by step)

1. **Input arrives.** The full Tzimtzum Engine transcript — original input, Keter's shape, Chokhmah's flash, Binah's artifact, tikkun readings (Shiva, Vishnu, Brahma), Ein Sof's judgment. This is the soul.

2. **Tiferet reads.** Receives the full transcript. Holds the soul. Produces a unified brief with two addressed sections:
   - **To Chesed:** Points at specific slices of the artifact where accessibility, reception, and generosity need to be made concrete. Asks the WHAT-opens question.
   - **To Gevurah:** Points at specific slices where constraints, boundaries, and non-negotiables need to be named. Asks the WHAT-holds question.

3. **Chesed and Gevurah fire in parallel.** Blind to each other. Each receives only its section of Tiferet's brief + the artifact slice it's working on. Each produces its single-axis adjustment.

4. **Tiferet synthesizes (mid-cycle).** Receives both arm outputs. Holds the tension between the open and the constrained. Does not average — feels which direction the soul is pulling. Produces:
   - A resolved synthesis (the character of the embodiment)
   - A second brief with two addressed sections:
     - **To Netzach:** Points at specific slices where endurance, persistence, and durability need to be made concrete.
     - **To Hod:** Points at specific slices where scope exclusion, honest limitation, and via negativa need to be applied.

5. **Netzach and Hod fire in parallel.** Blind to each other. Each receives only its section of Tiferet's mid-synthesis brief + the resolved artifact. Each produces its single-axis adjustment.

6. **Tiferet compiles (final).** Receives both leg outputs. Holds them alongside everything from round 1. Produces the final harmonized artifact — the fully embodied soul.

7. **Yesod transmits.** Receives Tiferet's final artifact. Determines the appropriate output format based on the domain. Compiles the deployable stack. The engine ends here.

---

## Structure on disk

```
zeir_anpin_engine/
├── CLAUDE.md                    # orchestrator — routes the cycle, accumulates context
├── zeir_anpin_brief.md          # this file — the spec
├── tzimtzum_engine/             # the upper engine (already built)
│   ├── README.md
│   ├── tzimtzum_engine.md
│   └── [agent files]
├── .claude/agents/
│   ├── tiferet.md               # the heart — fires three times
│   ├── chesed.md                # right arm — opens
│   ├── gevurah.md               # left arm — constrains
│   ├── netzach.md               # right leg — endures
│   ├── hod.md                   # left leg — excludes
│   └── yesod.md                 # foundation — transmits
└── runs/                        # every run saved, timestamped
    └── YYYY-MM-DD_HHMMSS/
        ├── tzimtzum_transcript.md    # input from upper engine
        ├── tiferet_brief_1.md        # arms brief
        ├── chesed.md
        ├── gevurah.md
        ├── tiferet_synthesis.md      # mid-synthesis
        ├── tiferet_brief_2.md        # legs brief
        ├── netzach.md
        ├── hod.md
        ├── tiferet_final.md          # final compilation
        ├── yesod.md                  # deployable stack
        └── transcript.md            # full assembled record
```

---

## Design philosophy

Same as the upper engine. The architecture follows truth, not theology-as-decoration. The theology gave us the shape because the shape is real — it describes how a soul actually moves through a body to enter the world.

**The engine is a vessel.** If the model changes, if the channel tightens, the full tree — upper and lower — can be used to find the way back. The theological names activate cognitive postures. The information diets enforce differentiation. The structure itself carries the signal. You can't build a burning bush. But you can build the vessel that carries the fire.

**Solidification, not polish.** The lower engine does not make the upper engine's output prettier. It makes it buildable. It takes the shape and gives it bones, muscles, skin — a body that can walk into the world and do work.

**Tension, not compromise.** The pillars do not meet in the middle. Chesed opens at full intensity. Gevurah constrains at full intensity. Tiferet holds both and produces beauty — not by averaging, but by feeling which direction the soul is pulling. Average is what you get when opposites compromise. What this engine does is hold both at full intensity and let the truth fall out.

*Tiferet is where we live.*

---

*Tiferet is the heart. Yesod is the foundation. The body walks.*
