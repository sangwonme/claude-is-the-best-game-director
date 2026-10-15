# CLAUDE.md

> Written for Claude. Humans don't need to read this file.

Prototype-first Unity project. The goal is to find the fun fast, not to build a product.
If any `<!-- TODO -->` marker remains in this file or in `Docs/Workflows/`, run the `setup-unity-project` skill before other work.

## Project

<!-- TODO: filled by setup-unity-project -->
- Genre:
- Unity version:
- Render pipeline:
- Input:

Design intent (pitch, mechanics, scope) lives in `Spec/`, not here.

## Where things live

| Path | Written by | Rule |
|---|---|---|
| `Spec/*.md` | The developer only | Never add content, ideas, or numbers. After `/spec setup` creates it, only `/spec refine` changes it, and only from the developer's answers. Everything in it counts as explicitly requested. |
| `Spec/review/`, `QA/` | `/spec review`, `/qa` | Reports. Never edit past ones. Write them in the spec's language (no spec: the user's language). |
| `Docs/Workflows/*.md` | Developer and Claude | This game's technical rules for assets and optimization. When you settle a new rule, add it there. |
| `.claude/personas/` | Developer and Claude | Reviewers for `/spec review` and `/qa`, one file each. Adding a file adds a reviewer. |
| `dump/` | The developer | Raw asset drop zone, git-ignored. Only `/asset` consumes it. |
| `Assets/` | Claude | Code in `Assets/Scripts`, `Assets/Scenes`, `Assets/Prefabs`. Art, audio, and fonts go where `Docs/Workflows/assets.md` says. No deeper structure until it hurts. |

`Spec/` says what to build, `Docs/Workflows/` says how to handle assets and performance, and ponytail says how little code to write. If `Spec/` and a workflow disagree, ask the developer.

## Ponytail: always on

All code and asset work follows the `ponytail` skill (`.claude/skills/ponytail/SKILL.md`) at **ultra**, unless the user changes the level with `/ponytail`.

Ponytail decides how little to build, never what the developer asked for. Do not cut or argue with anything in `Spec/` (its "Scope: in the first playable" list included), and never skip the questions `/spec` and `/qa` require.

The ladder, in Unity terms. Stop at the first rung that holds:
1. Does this prototype need it to test its idea? No → skip it.
2. Already in the project? Reuse it.
3. Unity built-in covers it? Inspector instead of config, primitives instead of art, built-in physics/CharacterController, `UnityEvent`, Animator, `Debug.Log`/Gizmos/`OnGUI` instead of debug UI.
4. An installed package covers it? Use it. Never add a package for what a few lines do.
5. Only then: the minimum code, ideally one MonoBehaviour.

Prototype defaults:
- Tuning values are `[SerializeField]` fields, tweaked in the Inspector during play mode. No ScriptableObjects or config files until several objects share the values.
- Not until the prototype proves it needs them: managers, singletons, event buses, DI, state-machine frameworks, object pools, save systems, asmdefs, interfaces with one implementation.
- Mark deliberate shortcuts as `// ponytail: <ceiling>, <upgrade path>` so `/ponytail-debt` can collect them.
- Non-trivial pure logic (math, rules, parsing) leaves one check: a `Debug.Assert` self-check, or one EditMode test if a test assembly already exists.

## Unity correctness (never cut)

- **`.meta` files**: when moving, deleting, or renaming an asset, handle its `.meta` too. Let Unity generate `.meta` for new assets.
- **`Library/`, `Temp/`, `obj/`**: never read or modify. They are generated.
- **Scene/prefab YAML**: change scenes through Unity MCP, not by editing `.unity`/`.prefab` text.
- **Unity null**: never `?.`, `??`, or `is null` on `UnityEngine.Object`. Use `== null` or `if (obj)`.
- **Main thread**: Unity APIs only on the main thread.
- **Editor code**: `UnityEditor` only inside an `Editor/` folder or `#if UNITY_EDITOR`.

## Done means verified

1. After editing scripts, wait for compilation and check `read_console` (Unity MCP). Not done while errors remain.
2. When behavior matters, enter play mode and take an MCP screenshot.
3. Performance: only through `Docs/Workflows/optimization.md`, starting from a measurement.

## Skills

| Skill | Who starts it | When |
|---|---|---|
| `prototype` | You or the user | Building a new mechanic or idea |
| `asset` | You or the user | Files are waiting in `dump/`, or the user asks to import assets |
| `setup-unity-project` | You or the user | A TODO marker remains (see top) |
| `ponytail-review`, `ponytail-debt` | You or the user | `prototype` runs `ponytail-review` on itself; `ponytail-debt` when a prototype graduates |
| `spec`, `qa` | The user only | Never run their steps on your own. Suggest them when useful. |

## Unity MCP

`.mcp.json` registers `unityMCP` (http://localhost:8080/mcp). If it cannot connect, ask the user to start the server from `Window > MCP for Unity`.
