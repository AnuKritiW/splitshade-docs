# Usage

This guide shows how to assign and manage textures using the Splitshade interface.

To understand what textures are and how they’re used in rendering, see [What are Textures](what-are.md).  
To use textures in your WGSL shader code, see [iChannel0–iChannel3](../uniforms/iChannel.md).

## Assigning Textures in the UI

In the **Textures Panel** below the editor, you can assign images to one of four channels:

- `iChannel0`, `iChannel1`, `iChannel2`, `iChannel3`

For each channel, you can:

- **Use a built-in preset** – choose from several default textures.
- **Upload your own image** – select a file from your computer.
- **Swap or clear textures** – click the thumbnail to update or remove.

These textures are automatically made available in your shader through the corresponding `iChannelN` uniforms.

> Tip: Each assigned texture also includes a `sampler`, so you can use `textureSample(iChannel0, iChannel0Sampler, uv)` in your shader.



---
Need help with the WGSL syntax? Head to the [iChannel](/uniforms/iChannel) page for full examples.