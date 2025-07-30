### Rotating Cube

Adapted from [Shadertoy "Just another cube" by mrange](https://www.shadertoy.com/view/3XdXRr)
![Display Texture](/images/examples-rotatingcube.gif)

<details>
<summary>Click to view code</summary>

```wgsl
// ——— module-scope state ———
var<private> R: mat2x2<f32>;
var<private> d: f32 = 1.0;
var<private> z: f32 = 0.0;
var<private> G: f32 = 9.0;
const M: f32 = 1e-3;

// ——— SDF + glow function ———
fn D(p: vec3<f32>) -> f32 {
  var q = p;
  // Rotate in XY plane
  let rot1 = R * q.xy;
  q.x = rot1.x; q.y = rot1.y;
  // Then rotate that result in XZ plane
  let rot2 = R * vec2<f32>(q.x, q.z);
  q.x = rot2.x; q.z = rot2.y;

  let S = sin(123.0 * q);
  // superquadric distance
  let base = pow(dot(q*q*q*q, q*q*q*q), 0.125) - 0.5;
  // subtract surface detail
  d = base - pow(1.0 + S.x * S.y * S.z, 8.0) / 1e5;
  // track glow
  G = min(G, max(abs(length(q) - 0.6), d));
  return d;
}

@fragment
fn main(@builtin(position) fragCoord: vec4<f32>) -> @location(0) vec4<f32> {
  // 1) pull in injected uniforms
  let r = iResolution;   // vec3<f32>, .xy = screen size
  let t = iTime;         // f32

  // 2) ShaderToy-style ray direction in *pixel* units
  let dx = fragCoord.x - 0.5 * r.x;
  let dy = fragCoord.y - 0.5 * r.y;
  let I  = normalize(vec3<f32>(dx, dy, r.y));

  // 3) glow color & rotation
  let B     = vec3<f32>(1.0, 2.0, 9.0) * M;
  let angle = 0.3 * t;
  R = mat2x2<f32>(
    cos(angle), -sin(angle),
    sin(angle),  cos(angle)
  );

  // 4) raymarch loop from camera at z = –4
  let camPos = vec3<f32>(0.0, 0.0, -4.0);
  z = 0.0; d = 1.0; G = 9.0;
  loop {
    let P = camPos + z * I;
    if (!(z < 9.0 && d > M)) { break; }
    z += D(P);
  }

  // 5) shading
  var O = vec3<f32>(0.0);
  if (z < 9.0) {
    // estimate normal via central differences
    var N = vec3<f32>(0.0);
    for (var i = 0u; i < 3u; i = i + 1u) {
      var off = vec3<f32>(0.0);
      off[i] = M;
      let P = camPos + z * I;
      N[i] = D(P + off) - D(P - off);
    }
    N = normalize(N);

    let fres = 1.0 + dot(N, I);
    let refl = reflect(I, N);
    let hit  = camPos + z * I;
    let Cxy  = (hit + refl * ((5.0 - hit.y) / abs(refl.y))).xz;

    O = fres*fres * select(
      exp(-2.0 * length(Cxy)) * (B/M - 1.0),
      5e2 * smoothstep(5.0, 4.0, sqrt(dot(Cxy, Cxy)) + 1.0)
           * (sqrt(dot(Cxy, Cxy)) + 1.0) * B,
      refl.y > 0.0
    ) + pow(1.0 + O.y, 5.0) * B;
  }

  // 6) tonemap & output
  return vec4<f32>(sqrt(O + B/G), 1.0);
}
```
</details>