---
name: prototype
description: Build the smallest playable version of a game idea or mechanic, then verify it in play mode and cut it down with a ponytail-review self-check. Use when the user asks for a new mechanic or idea to try, or types "/prototype <idea>".
argument-hint: <idea or mechanic>
---

# Prototype

Idea: $ARGUMENTS

0. **Load ponytail**: read `.claude/skills/ponytail/SKILL.md` and apply it at the current level (ultra unless the user changed it) for every step below.
1. **Hypothesis**: in at most 3 lines in chat, state what feel or fun this tests, the core loop, and what is cut. Do not wait for approval. Ask one question only if the idea is too vague to pick a hypothesis.
   - If a spec in `Spec/` covers this idea, take the hypothesis, rules, and numbers from it. Anything in its first-playable scope is required and cannot be cut.
   - Numbers the spec lacks: pick a default, list it under `tune` in the report, and never write it into the spec.
2. **Build**: as few scripts as possible (ideally one MonoBehaviour), primitives, and the current scene or one new `Assets/Scenes/Proto_<Name>.unity`. Tuning values go in serialized fields. Set up the scene through Unity MCP; without MCP, list the Editor steps.
3. **Verify**: compile, confirm `read_console` is clean, enter play mode, take a screenshot.
4. **Self-review**: read `.claude/skills/ponytail-review/SKILL.md` and review every file you created or changed against it. Apply every cut that keeps the behavior, then repeat step 3. If nothing can be cut, move on.
5. **Report**: `built: X. tune: <Inspector fields worth tweaking>. cut in review: <what, or "nothing">. skipped: Y, add when Z.`
