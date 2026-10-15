# CLAUDE.md

> Written for Claude. Humans don't need to read this file.

This repo is a **Claude Code setup template for prototyping Unity games**. Users don't run anything themselves: they ask Claude in their Unity project to install it, and Claude follows the "For agents" section of `README.md`. The repo itself is not a Unity project.

## Rules for editing this repo

- All docs in this repo (including everything under `template/`) are written in English. Reports generated inside a game project follow that project's spec language.
- README audience: the part above "For agents" is for humans and stays very high level. Everything Claude needs goes below it.
- Apply ponytail to the template itself: add a file, agent, or rule only when a real session needed it or the user asked for it.
- `template/.claude/skills/ponytail*` are vendored copies of the MIT-licensed ponytail skills. Do not edit them; re-copy from upstream to update. Unity-specific ponytail guidance goes in `template/CLAUDE.md`.

## Invariants (check these after any change)

- **Spec authorship**: the developer writes `Spec/`. No skill or agent may author spec content. `/spec refine` only rewords from the developer's answers.
- **Skill invocation**: `spec` and `qa` have `disable-model-invocation: true` (user-only). Every other skill must stay model-invocable, because `template/CLAUDE.md` tells Claude to run them. Keep the "Skills" table in `template/CLAUDE.md` in sync with the frontmatter.
- **Ponytail scope**: ponytail limits how much gets built. It never overrides `Spec/` content or the questions `/spec` and `/qa` must ask.
- **Personas**: three layers, each written in one place only.
  - Who the reviewer is and what they look at: `template/.claude/personas/*.md`
  - Rules every reviewer shares: `template/.claude/agents/persona-reviewer.md`
  - Output format: each skill's template

  `/spec review` and `/qa` launch one `persona-reviewer` per persona file, in parallel, and reviewers never see each other's output. Never hardcode persona names in skills or templates, so adding a file adds a reviewer.
- **Paired files**:
  - `install.ps1` ↔ `install.sh` ↔ the README install procedure
  - The `<!-- TODO -->` sections in `template/CLAUDE.md` and `template/Docs/Workflows/*.md` ↔ the `setup-unity-project` skill
  - Files under `template/` ↔ the "What gets installed" table in the README
- `template/dump/README.md` exists so the folder ships through git. The install scripts add `/dump/*` + `!/dump/README.md` to `.gitignore`.
