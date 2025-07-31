# Vertex Shaders

Vertex shaders process each vertex of a mesh and determine how it’s positioned on screen. In **Splitshade**, vertex shaders are **optional** — you only need one if you're working with custom geometry (like a mesh).

## How Vertex Shaders Work

If your WGSL code includes a `@vertex` function, **Splitshade** will use that function to process each vertex. You’re expected to:

- Define input attributes (e.g., position, color)
- Output a position in clip space (`vec4<f32>`)
- Optionally pass custom data to the [fragment shader](./fragment.md)

Vertex shaders run **once per vertex**, not per pixel. They're commonly used for transforming geometry, animating meshes, or passing interpolated data to the fragment stage.

## When to Use

Use a vertex shader when you need:

- Custom geometry (e.g. meshes, lines, shapes)
- Per-vertex animation or transformations
- Attributes like color or normals passed to [fragment shaders](./fragment.md)

For full-screen effects, **Splitshade** provides a built-in fullscreen triangle — no vertex shader required (see [Fragment Shaders](./fragment.md)).

## Getting Started

To define a vertex shader in WGSL:

- Use the `@vertex` annotation
- Provide a `@builtin(vertex_index)` or custom attributes
- Return a `@builtin(position)` output

```wgsl
@vertex // [!code focus]
fn main(@builtin(vertex_index) vertexIndex: u32) -> @builtin(position) vec4<f32> {  // [!code focus]
  var pos = array<vec2<f32>, 3>(
    ...
  );
  return vec4<f32>(pos[vertexIndex], 0.0, 1.0);
}
```

## Passing Custom Attributes to the Fragment Shader

To pass values (like color or UVs) to the fragment shader, return a struct with `@location(n)` attributes:

```wgsl
// [!code focus:4]
struct VertexOut {
  @builtin(position) pos: vec4<f32>,     // Position is required
  @location(0) color: vec3<f32>,         // Custom data passed to fragment shader
};

@vertex
fn main(@builtin(vertex_index) i: u32) -> VertexOut {
  var positions = array<vec2<f32>, 3>(...);
  var colors = array<vec3<f32>, 3>(...);

  var out: VertexOut;
  out.pos = vec4<f32>(positions[i], 0.0, 1.0);
  out.color = colors[i];
  return out;
}
```
The fragment shader can receive `@location(0)` inputs to use the color, UV, etc., from each vertex.

## Inputting Geometry

To go beyond hardcoded arrays, you can use the [Mesh Panel](../meshes/what-is.md) in the **Splitshade** UI to upload a `.obj` file. This lets you visualize complex geometry without writing vertex buffers by hand.