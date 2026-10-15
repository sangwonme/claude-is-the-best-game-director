---
name: setup-unity-project
description: Scan this Unity project and fill in the TODO sections of CLAUDE.md and Docs/Workflows/*.md with real values. Use right after the template is installed, or whenever a TODO marker remains in those files.
---

# Unity project setup

Fill every `<!-- TODO -->` section in `CLAUDE.md`, `Docs/Workflows/assets.md`, and `Docs/Workflows/optimization.md` with real values. Do not guess. Do not touch `Spec/`; design intent is the developer's to write there.

1. Read in parallel:
   - `ProjectSettings/ProjectVersion.txt`: Unity version
   - `Packages/manifest.json`: URP (`com.unity.render-pipelines.universal`), HDRP (`.high-definition`), or neither (Built-in); Input System (`com.unity.inputsystem`); 2D PSD Importer (`com.unity.2d.psdimporter`); MCP for Unity (`com.coplaydev.unity-mcp`)
   - `Assets/` top level, to see whether code and art already exist
2. Ask the user in one AskUserQuestion call: genre, art style (pixel art / hand-drawn 2D / 3D low-poly / 3D realistic), and target platforms. If pixel art, also ask pixels per unit (default 16).
3. Fill in:
   - `CLAUDE.md` **Project**.
   - `assets.md`: art style and PPU. If the style is not pixel art, delete the pixel-art-only parts of the import settings so the table states only what applies.
   - `optimization.md`: target platforms, and target frame rate (mobile 30 or 60 by genre, PC/console 60).
   - Remove each filled `<!-- TODO -->` comment.
   - If the project already has its own code conventions or folder layout, write one line about it in the `Assets/` row of **Where things live** in `CLAUDE.md`, and update the destinations in `assets.md` to match. Existing structure wins.
4. If MCP for Unity is missing, ask the user, then add `"com.coplaydev.unity-mcp": "https://github.com/CoplayDev/unity-mcp.git?path=/MCPForUnity"` to `dependencies` in `Packages/manifest.json`. Unity installs it the next time the Editor gains focus.
5. Report in two lines: what was filled in, and what the user still has to do. Suggest `/spec setup` as the next step.
