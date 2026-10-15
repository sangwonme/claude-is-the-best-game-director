---
name: qa
description: Play-test a defined part of the game, collect screenshots and console logs, have every persona in .claude/personas/ evaluate it independently, and write QA/{date}-{title}.md. Always agrees on scope and purpose with the user first.
disable-model-invocation: true
argument-hint: "[what to test]"
---

# QA

Request: $ARGUMENTS

Dates are `YYYY-MM-DD` (today). `{title}` is a short kebab-case name for the scope. If the report already exists, append `-2`, `-3`, ... Write the evidence and report in the spec's language (no spec: the user's language).

## 1. Agree on scope and purpose (required)

Do not start testing until all of these have clear answers. Ask in one AskUserQuestion call, offering options built from the build scenes, `Spec/` (§9 screens, §13 success criteria), and the request:
- **Start**: where the test begins (a scene, screen, or game state)
- **End**: where it stops
- **Purpose**: what this run is for (find bugs, check feel against the spec, check UI flow, verify a recent change, ...)
- **Pass if**: what result counts as a pass

If an answer is vague ("everything", "just check it"), ask again about that answer only. Then restate it in one line, `Testing <start> → <end> to <purpose>. Pass if <criterion>.`, and proceed.

## 2. Plan

List numbered steps from start to end: the action, what you expect, and what to capture. Use the spec's controls (§8) and flow (§9) if a spec exists.

## 3. Play and collect

Everything goes in `QA/{date}-{title}/`. Clear the console first. If the purpose involves performance, also record frame timing with Unity MCP `manage_profiler`.

Drive each step with the first method that works:
1. **Unity MCP only**: enter play mode, read state (`find_gameobjects`, component values), and change state (`manage_gameobject`, `manage_components`) where the step allows.
2. **QA driver**, when a step needs real input: write a throwaway `Assets/QA/QADriver.cs` that spawns itself with `[RuntimeInitializeOnLoadMethod]` (so no scene is modified) and runs the steps in a coroutine. With the Input System, queue input on a virtual device. With legacy input or UI, call the same methods the input would (for example `Button.onClick.Invoke()`). Log `[QA] step N: ...` and call `ScreenCapture.CaptureScreenshot("QA/{date}-{title}/NN-<step>.png")` at each step. Wait for compilation before entering play mode.
3. **Human play**, for feel or timing a script cannot reproduce: ask the user to play that part and tell you at each step; you capture.

After every step: save a screenshot as `NN-<step>.png` (MCP screenshots land in `Assets/Screenshots/`, so move them here and delete their `.meta`), and read the console.

Then write `QA/{date}-{title}/evidence.md`, facts only: scope, purpose, pass criterion, method per step, then for each step the action, expected result, observed result, screenshot file, and console lines. After that, all errors and warnings, and performance numbers if collected.

When done: exit play mode, then delete `Assets/QA/` and its `.meta` files if you made a driver. Do not save any scene changes made during the run.

## 4. Evaluate independently

Launch one `persona-reviewer` agent per file in `.claude/personas/`, **in parallel, in one message**. The prompts are identical except for the persona file: the persona file path, "Mode: QA", the report language, the path to `evidence.md`, the screenshot folder (tell them to view every screenshot), the spec path if one exists, and the per-reviewer section of `template.md` (from `## {{Reviewer}}` to the end) as the format to return. Do not add your own opinions, and never pass one reviewer's output to another.

## 5. Write the report

Write `QA/{date}-{title}.md` from `template.md` (next to this file):
- Reviewer sections go in **exactly as returned**.
- **Result** checks "Pass if" against the evidence, citing the step that shows it.
- **Bugs** lists only reproducible defects found in the evidence or by reviewers.
- **Walkthrough**: every step embeds its screenshot with alt text describing what it shows, plus one or two sentences.
- "Raised by more than one reviewer" and "Where reviewers disagree" come only from the reviewer sections.

In chat: the result line, the reviewer table, the bugs, and the report path.
