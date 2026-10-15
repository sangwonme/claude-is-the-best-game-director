# dump/

Drop raw asset files here (images, sprite sheets, PSD/Aseprite, audio, models, fonts), then ask Claude to `/asset`.

- Everything in this folder except this README is git-ignored. Unity does not import it (it is outside `Assets/`).
- Claude processes each file into `Assets/` following `Docs/Workflows/assets.md`, then moves the original to `dump/_done/`. Originals are never modified or deleted.
