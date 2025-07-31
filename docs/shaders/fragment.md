# Fragment Shaders

Fragment shaders are the most common type of shader in **Splitshade**. They run once per pixel and determine the final color output to the screen.

## How Fragment Shaders Work

If your WGSL code contains only a @fragment entry point (and no @vertex function), **Splitshade** automatically generates a fullscreen triangle. This triangle is drawn using a minimal built-in vertex shader that fills the canvas.

This means:
- You do *not* need to write a `@vertex` function for full-screen effects
- The `@builtin(position)` in your fragment shader corresponds to the screen-space pixel position
    > To normalize pixel coordinates to UV space, see [iResolution](../uniforms/iResolution.md).

## When to Use

Fragment shaders are ideal for:

- Procedural textures
- Post-processing effects
- Interactive 2D visuals (especially with [`iMouse`](../uniforms/iMouse.md), [`iTime`](../uniforms/iTime.md), etc.)
- Texture or UV-based experiments

## Getting Started

To get started, your fragment shader must include:

- The `@fragment` annotation to mark it as a fragment shader entry point.
- A `@builtin(position)` input to receive screen-space coordinates.
- A `vec4<f32>` return type to output the pixel color.

```wgsl
// mark entry point
@fragment // [!code focus]
// receive screen-space coordinates
fn main(@builtin(position) pos: vec4<f32>) -> @location(0) vec4<f32> {  // [!code focus]
  ...
}
```

## Behind the Scenes

**Splitshade** generates and injects a minimal vertex shader behind the scenes:

```wgsl
@vertex
fn main(@builtin(vertex_index) vertexIndex : u32) -> @builtin(position) vec4<f32> {
  var pos = array<vec2<f32>, 3>(
    vec2<f32>(-1.0, -3.0),
    vec2<f32>(3.0, 1.0),
    vec2<f32>(-1.0, 1.0)
  );
  return vec4<f32>(pos[vertexIndex], 0.0, 1.0);
}
```

You don’t need to manage geometry or setup — just write a fragment function with the proper annotations and **Splitshade** handles the rest.

**Splitshade** also handles pipeline creation and binding — you don’t need to manually set up the render loop.
