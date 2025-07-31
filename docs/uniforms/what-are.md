# What Are Uniforms?

Uniforms are special inputs that allow data to be passed from **Splitshade** into your shaders. Uniforms are constant across a single draw call — they don’t change per vertex or fragment.

They enable your shader to respond to external parameters such as time, mouse position or screen resolution, making it possible to create dynamic, interactive visuals.

## Why Uniforms Matter

Uniforms are the bridge between your shader and the world outside it. For instance:

- Want to adapt visuals to screen size? Use [`iResolution`](./iResolution.md).
- Want to react to user input? Use [`iMouse`](./iMouse.md).
- Want to animate something over time? Use [`iTime`](./iTime.md).

These values are essential for building interactive and visually responsive effects.

## Uniforms in Splitshade

**Splitshade** provides a set of built-in uniforms automatically available in every shader:

- [`iResolution`](./iResolution.md): Canvas resolution in pixels
- [`iMouse`](./iMouse.md): Current mouse coordinates and button state
- [`iTime`](./iTime.md): Elapsed time in seconds
