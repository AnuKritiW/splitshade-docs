# iMouse

The `iMouse` uniform captures the user's mouse interaction with the canvas. It is passed to the shader as a `vec4<f32>` and allows you to create interactive effects that respond to cursor position or movement.

Its components are:

- `x`: X position of the mouse in pixels (from left)
- `y`: Y position of the mouse in pixels (from bottom)
- `z`: 1.0 if the mouse button is currently held down, 0.0 otherwise
- `w`: unused (reserved for padding, always 0.0)

If no mouse interaction occurs, all values are `0.0`.

## Usage

`iMouse` is most commonly used to introduce interactivity in your shaders — like cursor-driven ripples, highlights, or drawing effects.

### Common Use Cases

- **Track live cursor position**
  ```wgsl:no-line-numbers
  let mouse = iMouse.xy;
  ```

- **Check if mouse is pressed**
  ```wgsl:no-line-numbers
  let isDown = iMouse.z > 0.0;
  ```

- **Compute distance from mouse to a fragment**
  ```wgsl:no-line-numbers
  let dist = distance(pos.xy, iMouse.xy);
  ```

## Examples

### Following cursor with a circle
![Follow Cursor](/images/imouse-xy.gif)
```wgsl
@fragment
fn main(@builtin(position) pos: vec4<f32>) -> @location(0) vec4<f32> {
  // Distance from current pixel to mouse position
  let d = distance(pos.xy, iMouse.xy);
  
  // Simple threshold-based circle around the cursor
  if (d < 20.0) {
    return vec4(1.0, 0.8, 0.2, 1.0); // orange highlight
  } else {
    return vec4(0.0, 0.0, 0.0, 1.0); // background
  }
}
```
This example uses `iMouse.xy` to draw a small glowing circle around the current cursor location. You can replace the hard-coded `20.0` with a uniform to control the radius dynamically.

### Detecting Click State with iMouse.z
![Detect Click](/images/imouse-z.gif)
```wgsl
@fragment
fn main(@builtin(position) pos: vec4<f32>) -> @location(0) vec4<f32> {
  // Use red if mouse is pressed (z = 1.0), else green
  if (iMouse.z > 0.0) {
    return vec4(1.0, 0.0, 0.0, 1.0); // red on click
  }
  return vec4(0.0, 1.0, 0.0, 1.0); // green otherwise
}
```
This example uses `iMouse.z` to switch the output color based on whether the mouse button is currently pressed. A red screen means the mouse is down, while green means it's up. This is a minimal way to check if your click state is working correctly.