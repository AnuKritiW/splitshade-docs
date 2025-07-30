# Using Meshes in Splitshade

You can load `.obj` files in the Splitshade playground to replace the default fullscreen triangle with custom geometry.

## Mesh Panel Features

### Set Mesh

To use a mesh:

- Click the **mesh dropdown** to choose a preset (`triangle`, `circle`, `sphere`, etc.)
- Or click the **upload** button to import your own `.obj` file
- The selected mesh will be parsed and passed to your vertex shader

You can preview the uploaded geometry in the viewport and manipulate it using `WGSL`.

### Supported Formats

Splitshade currently accepts `.obj` files.

- Only `v` (positions), `vt` (texture coords), and `f` (faces) are used
- Other features (materials, bones, normals) are ignored
- Presets like `sphere`, `triangle`, and `circle` are also available

### Copy Starter Code

Click **Copy Starter Code** in the Mesh Panel to quickly insert a boilerplate `WGSL` shader that matches the selected mesh's layout.

This provides a working example that includes:

- A `@vertex` shader to read position and color from the mesh
- A `@fragment` shader that receives the interpolated color

```wgsl
// Default shader code for uploaded mesh
struct VertexOut {
  @builtin(position) position: vec4<f32>,
  @location(0) color: vec3<f32>,
};

@vertex
fn main(@location(0) pos: vec3<f32>, @location(1) color: vec3<f32>) -> VertexOut {
  var out: VertexOut;
  // Adjust as needed to ensure the object is in clip space and in front of the camera
  out.position = vec4<f32>(pos, 1.0);
  out.color = color;
  return out;
}

@fragment
fn main_fs(@location(0) color: vec3<f32>) -> @location(0) vec4<f32> {
  return vec4<f32>(color, 1.0);
}
```

> Note: If your shader doesn’t include a vertex stage, Splitshade falls back to rendering a fullscreen triangle.

See [Vertex Shaders](../shaders/vertex.md) to learn how to write your own vertex stage from scratch.
