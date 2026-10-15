# Asset workflow

How raw files in `dump/` become Unity assets in this game. `/asset` follows this file and adds a rule here whenever it makes a new decision. Edit freely.

<!-- TODO: filled by /setup-unity-project -->
- Art style:
- Pixels per unit:

## Destinations and naming

| Kind | Goes to | Name (keep the source extension) |
|---|---|---|
| Sprite / UI image | `Assets/Art/Sprites/` | `snake_case` |
| Sprite sheet / animation | `Assets/Art/Sprites/<character>/` | `<character>_<anim>` |
| Background / tileset | `Assets/Art/Environment/` | `snake_case` |
| SFX | `Assets/Audio/SFX/` | `sfx_<what>` |
| Music | `Assets/Audio/Music/` | `mus_<where>` |
| 3D model | `Assets/Art/Models/` | `snake_case` |
| Font | `Assets/Fonts/` | original name |

## Import settings

| Kind | Settings |
|---|---|
| Sprites | PPU from above. Pixel art: Filter Point, Compression None. Otherwise: Bilinear, Normal. Mip maps off. |
| SFX | Force To Mono, Decompress On Load |
| Music | Streaming, Vorbis quality 70 |
| Models | 1 unit = 1 m. Import materials only if used. |

## Processing rules

- Import the source as-is when Unity can. Convert only when Unity cannot import it or a rule here requires it.
