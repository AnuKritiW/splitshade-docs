# What are Textures?

In shaders, **textures** are images used as data sources. They allow you to add rich detail to your visuals—like colors, patterns, noise, masks, or even entire scenes—without manually computing every pixel value.

## Why Use Textures?

Textures let you:

- Apply image-based detail without complex math
- Reuse real-world images or hand-drawn art
- Store custom data like flow maps or normal maps
- Add stylization, distortion, or layering

## Types of Texture Data

Textures don't always just hold color. They can represent:

| Type           | Description                           |
| -------------- | ------------------------------------- |
| **Color Map**  | Regular image used for shading        |
| **Mask**       | A grayscale image for blending/mixing |
| **Normal Map** | Encodes surface bump direction        |
| **Height Map** | Stores elevation or depth data        |
| **Distortion** | Offsets UVs for warping effects       |

## How Are Textures Used?

In `WGSL` shaders, textures are sampled using two parts:

- A `texture_2d<f32>` – the image data
- A `sampler` – the method for reading/interpolating pixels

Where:
- `iChannel0` is a `texture_2d<f32>`
- `iChannel0Sampler` is a `sampler`
- `uv` is a `vec2<f32>` in the range `[0.0, 1.0]`

## UV Coordinates
UVs are how you look up pixels in a texture.

- `(0.0, 0.0)` = bottom-left
- `(1.0, 1.0)` = top-right

Values outside `[0.0, 1.0]` may repeat or clamp, depending on the sampler

---

To learn how to assign textures in the **Splitshade** UI, continue to [Texture Usage](usage.md).

To see how to use textures in your `WGSL` shader code, see [iChannel0–iChannel3](../uniforms/iChannel.md).
