# What are Meshes?

Meshes allow your shader to render custom geometry instead of the default fullscreen triangle. They provide access to actual vertex data — such as position and color — enabling you to create more complex and meaningful visuals in both 2D and 3D contexts.

A mesh is a collection of **vertices** and **faces** that define a 2D or 3D object. Each vertex can carry attributes like:

- Position
- Color
- (In future versions: normals, UVs, etc.)

## Why Use Meshes?

Using a mesh opens up new possibilities in shader design:

- Visualize custom shapes and models
- Enable the use of vertex shaders
- Animate or distort geometry using vertex inputs
- Represent 3D objects, characters, or abstract structures

## Attributes Passed to Shaders

When a mesh is provided, vertex data is passed to your `WGSL` shader as:

- `@location(0)` → `vec3<f32>` position
- `@location(1)` → `vec3<f32>` color

You can access this in your `@vertex` function and pass it to the fragment stage as needed.

## What Happens at Runtime

When you upload or select a mesh, Splitshade:
- Parses the `.obj` file
- Extracts vertex positions and colors
- Passes this data to your vertex shader using WGSL input attributes

See [Mesh Usage](usage.md) to learn how to upload and apply your own.

