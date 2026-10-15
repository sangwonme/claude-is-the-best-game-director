# claude-is-the-best-game-director

A Claude Code setup for prototyping Unity games, built on [ponytail](template/.claude/skills/ponytail/SKILL.md): the laziest solution that works, YAGNI by default.

## Install

Open Claude Code in your Unity project folder and type:

```
Install the Unity setup from https://github.com/sangwonme/claude-is-the-best-game-director
```

Claude installs everything, asks a few questions about your game, and tells you when it's done.

## Use

| You do | Claude does |
|---|---|
| `/spec setup [title]` | Creates a spec template in `Spec/`. **You write the spec yourself.** |
| `/spec refine` | Asks you about unclear or redundant wording, then edits using only your answers |
| `/spec review` | A senior director, a senior UX designer, and an otaku player review it independently → `Spec/review/{date}-{title}.md` |
| `/prototype <idea>` | Builds the smallest playable version and checks it in play mode |
| `/qa` | Asks what to test and why, plays it, captures screenshots and logs, and the same personas evaluate → `QA/{date}-{title}.md` |
| Drop raw files into `dump/`, then `/asset` | Turns them into Unity assets using your game's rules |
| `/ponytail-debt` | Lists the shortcuts it took, for when a prototype graduates |

Your game's rules live in `Docs/Workflows/` (assets, optimization). Read or edit them any time; Claude adds to them as it works.

Reviewers live in `.claude/personas/`, one file each. Edit one to change a reviewer, or add a file to add one.

Everything else (`CLAUDE.md`, `.claude/`, and the rest of this README) is written for Claude. You don't need to read it.

---

## For agents

> Humans can stop here. Everything below is instructions for Claude.

### Install procedure

Run this when the user asks to install this setup.

1. Confirm the target is a Unity project (`Assets/` and `ProjectSettings/` exist). Default to the current directory; if it isn't one, ask for the path.
2. Shallow-clone this repo into a temp directory outside the project.
3. Run the installer with the Unity project as the target:
   - Windows: `powershell -NoProfile -ExecutionPolicy Bypass -File <clone>/install.ps1 -Target <project>`
   - macOS / Linux: `bash <clone>/install.sh <project>`
4. The installer skips files that already exist. Resolve each skipped file:
   - `CLAUDE.md`: merge the template's sections into it.
   - `.claude/settings.json`, `.mcp.json`: merge the template's keys and list entries into it.
   - Anything else: ask the user before overwriting.
5. Delete the temp clone.
6. Run the project's `setup-unity-project` skill now. If it is not loaded yet, read `<project>/.claude/skills/setup-unity-project/SKILL.md` and follow it.
7. Tell the user to restart Claude Code in the project folder so `CLAUDE.md` and the Unity MCP connection load, and to start the server in Unity from `Window > MCP for Unity`.

### What gets installed

| Path | Contents |
|---|---|
| `CLAUDE.md` | Where things live and who writes them, ponytail always on (ultra) and its limits, Unity correctness rules, definition of done, which skills Claude may start |
| `.mcp.json` | [MCP for Unity](https://github.com/CoplayDev/unity-mcp) connection (`http://localhost:8080/mcp`) |
| `.claude/settings.json` | Blocks `Library/`, `Temp/`, `obj/`. Asks before editing scene/prefab YAML or `.meta` |
| `dump/README.md` | Drop zone for raw assets. Everything but the README is git-ignored, and Unity never imports it |
| `Docs/Workflows/assets.md` | This game's asset rules: destinations, naming, import settings, processing. Grows as `/asset` makes decisions |
| `Docs/Workflows/optimization.md` | This game's optimization procedure, budgets, and measured rules |
| `.claude/agents/persona-reviewer.md` | The one reviewer agent. Takes a persona file and holds the shared rules (independent, cite sources, read-only) |
| `.claude/personas/senior-director.md` | Vision, core loop, rules, scope, feasibility, bugs |
| `.claude/personas/senior-ux-designer.md` | Flow, feedback, readability, onboarding, accessibility |
| `.claude/personas/otaku-player.md` | Hardcore genre fan: hook, freshness, depth, frustration, exploits |
| `.claude/skills/spec` | `/spec setup\|refine\|review`. `templates/spec.md` (14 sections, filled in by the developer) and `templates/review.md` |
| `.claude/skills/qa` | `/qa`: scope interview → play (MCP → throwaway driver → human) → evidence → 3 persona evaluations. `template.md` for the report |
| `.claude/skills/prototype` | `/prototype <idea>`: load ponytail → hypothesis → smallest playable build → verify → ponytail-review self-check |
| `.claude/skills/asset` | `/asset`: turns files in `dump/` into Unity assets per `assets.md`, then moves originals to `dump/_done/` |
| `.claude/skills/setup-unity-project` | Fills in the TODO sections after install |
| `.claude/skills/ponytail` | The YAGNI ladder. `/ponytail lite\|full\|ultra` changes the level |
| `.claude/skills/ponytail-review` | `/ponytail-review`: what to delete from a diff |
| `.claude/skills/ponytail-debt` | `/ponytail-debt`: ledger of `// ponytail:` shortcuts |

The installer also adds `/dump/*`, `!/dump/README.md`, `.claude/settings.local.json`, and `CLAUDE.local.md` to `.gitignore`, creating the file if needed.

Not included: production mode (asmdefs, test suites, architecture, code review agents). Add it when a prototype graduates.
