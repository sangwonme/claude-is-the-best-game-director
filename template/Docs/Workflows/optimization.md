# Optimization workflow

How this game gets optimized. Default while prototyping: nothing, until a measurement shows a problem.

<!-- TODO: filled by /setup-unity-project -->
- Target platforms:
- Target frame rate:

## Procedure

1. Reproduce the slowdown and measure it with the Unity Profiler (Unity MCP `manage_profiler` reads frame timing and counters), in a development build on the target device when possible (Editor play mode is misleading). If you cannot capture it yourself, ask the user for a capture.
2. Name the bottleneck: CPU scripts, CPU rendering (batches/SetPass), GPU (overdraw/shaders/resolution), memory/GC, or loading.
3. Fix only the top item with the smallest change. Re-measure. Stop once on target.
4. Add what worked to **Rules** so it becomes the default for this game.

## Budgets

Fill in once measured on the target device.

| Metric | Budget |
|---|---|
| Frame time | |
| Batches / SetPass calls | |
| Texture memory | |
| GC alloc per frame | |

## Rules

None yet. A rule is added only after a measurement earns it.
