# What is Splitshade?

**Splitshade** is a lightweight, browser-based playground for writing and visualizing [`WGSL`](https://www.w3.org/TR/WGSL/) shaders using [WebGPU](https://developer.mozilla.org/en-US/docs/Web/API/WebGPU_API). Designed for rapid iteration and creative exploration, Splitshade makes it easy to develop and debug fragment shaders with real-time feedback -- all from within your browser.

Whether you're experimenting with visual effects or learning how modern GPU pipelines work, **Splitshade** provides an interactive environment tailored for shader development.

## Key Features

- Live-editing support for both fragment and vertex shaders
- Real-time preview powered by WebGPU
- Built-in [uniforms](../uniforms/iTime.md) such as `iTime`, `iResolution`, and `iMouse`
- Interactive [texture upload system](../textures/usage.md) with support for multiple channels
- Integrated [mesh visualization](../meshes/usage.md) with `.obj` support
- Fast iteration with instant reloading and error feedback

## Who is it for?

**Splitshade** is designed for:

- Shader authors and creative coders
- Graphics programmers experimenting with `WGSL`
- Technical artists building visual prototypes
- Students learning WebGPU and GPU programming concepts

If you've ever used [Shadertoy](https://www.shadertoy.com/) or tried authoring `GLSL` shaders and want to explore the next generation of GPU tools, Splitshade is for you.

## Common Use Cases

- Prototyping visual effects in WGSL
- Exploring the [WebGPU shading pipeline](https://gpuweb.github.io/gpuweb/)
- Learning GPU concepts through code
- Testing how textures and geometry interact with custom shaders
- Building shader demos

## Next Steps

Ready to dive in? Head to [Getting Started](../introduction/getting-started.md) to learn how the playground works and start writing your first shader.
