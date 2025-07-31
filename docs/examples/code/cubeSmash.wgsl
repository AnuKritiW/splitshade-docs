// --- Utility functions ---
fn rot(t: f32) -> mat2x2<f32> {
    return mat2x2<f32>(
        cos(t),  sin(t),
       -sin(t),  cos(t)
    );
}

// iq’s rounded box SDF
fn udRoundBox(p: vec3<f32>, b: vec3<f32>, r: f32) -> f32 {
    let q = max(abs(p) - b, vec3<f32>(0.0));
    return length(q) - r;
}

// compute the 3-phase “times” vector
fn times() -> vec3<f32> {
    let gt = fract(iTime * 0.5) * 3.0;
    let a = clamp(gt - 0.0, 0.0, 1.0);
    let b = clamp(gt - 1.0, 0.0, 1.0);
    let c = clamp(gt - 2.0, 0.0, 1.0);
    return vec3<f32>(a, b, c);
}

// --- corrected map() ---
fn map(p: vec3<f32>) -> f32 {
    // copy into a mutable local
    var pos = p;

    let height = 1.0;
    let ground = pos.y + height;

    let pt = times();
    var pound = 1.0 - pow(1.0 - pt.y, 2.0) - pow(pt.z, 32.0);
    pound = pound * 2.0;

    let srot = smoothstep(0.0, 1.0, (pt.y + pt.z) * 0.5);
    let mrot = rot(-0.3 + srot * 3.1415926);

    // rotate XZ
    let xz = mrot * vec2<f32>(pos.x, pos.z);
    pos = vec3<f32>(xz.x, pos.y, xz.y);

    let boxOff = vec3<f32>(0.0, pound, 0.0);
    let boxDist = udRoundBox(pos - boxOff, vec3<f32>(height) * 0.5, height * 0.25);

    return min(ground, boxDist);
}

// simple ray-march
fn trace(o: vec3<f32>, r: vec3<f32>) -> f32 {
    var t: f32 = 0.0;
    for (var i: i32 = 0; i < 32; i = i + 1) {
        let p = o + r * t;
        let d = map(p);
        t = t + d * 0.5;
    }
    return t;
}

// ray-plane intersection
fn rayPlane(o: vec3<f32>, r: vec3<f32>, p: vec3<f32>, n: vec3<f32>) -> f32 {
    return dot(p - o, n) / dot(r, n);
}

// triple-axis texture
fn _texture(p: vec3<f32>) -> vec3<f32> {
    let ta = textureSample(iChannel2, iChannel2Sampler, p.xz).xyz;
    let tb = textureSample(iChannel2, iChannel2Sampler, p.yz).xyz;
    let tc = textureSample(iChannel2, iChannel2Sampler, p.xy).xyz;

    return (ta * ta + tb * tb + tc * tc) / 3.0;
}

// compute normal via finite diff
fn normal(p: vec3<f32>) -> vec3<f32> {
    let eps = 0.01;
    let dx = vec3<f32>(eps, 0.0, 0.0);
    let dy = vec3<f32>(0.0, eps, 0.0);
    let dz = vec3<f32>(0.0, 0.0, eps);
    return normalize(vec3<f32>(
        map(p + dx) - map(p - dx),
        map(p + dy) - map(p - dy),
        map(p + dz) - map(p - dz)
    ));
}

// volumetric smoke
fn smoke(o: vec3<f32>, r: vec3<f32>, f: vec3<f32>, tMax: f32) -> vec3<f32> {
    let tms = times();
    var sm: vec3<f32> = vec3<f32>(0.0);
    let steps: i32 = 32;

    for (var i: i32 = 0; i < steps; i = i + 1) {
        let j = f32(i) / f32(steps);
        let bout = 1.0 + tms.x;
        var p = vec3<f32>(cos(j * 6.2831853), 0.0, sin(j * 6.2831853)) * bout;
        p.y = -1.0;

        let pt = rayPlane(o, r, p, f);
        let pp = o + r * pt;
        let cd = length(pp - p);
        let uv = (pp - p).xy * 0.1 + vec2<f32>(j, j) * 2.0;

        // **always** sample in uniform control flow
        let rawTex = textureSample(iChannel1, iChannel1Sampler, uv).xyz;
        let tex = vec3<f32>(
            (rawTex.x * rawTex.x + rawTex.y * rawTex.y + rawTex.z * rawTex.z) / 3.0
        );

        // build a 0/1 mask without branching
        let inside = select(
            0.0,
            1.0,
            (pt >= 0.0) && (pt <= tMax)
        );

        // now all math is branchless
        var part = tex / (1.0 + cd * cd * 10.0 * tms.x);
        part = part * clamp(abs(tMax - pt), 0.0, 1.0);
        part = part / (1.0 + pt * pt);
        part = part * clamp(pt, 0.0, 1.0);
        part = part * inside;

        sm = sm + part;
    }

    return sm * (1.0 - smoothstep(0.0, 1.0, tms.x));
}

// main shading
fn shade(o: vec3<f32>, r: vec3<f32>, f: vec3<f32>, w: vec3<f32>, t: f32) -> vec3<f32> {
    var tuv = w;
    if (tuv.y > -0.85) {
        let pt = times();
        let srot = smoothstep(0.0, 1.0, (pt.y + pt.z) * 0.5);
        let mrot = rot(-0.3 + srot * 3.1415926);
        let xz = mrot * vec2<f32>(tuv.x, tuv.z);
        tuv.x = xz.x; tuv.z = xz.y;

        var pound = 1.0 - pow(1.0 - pt.y, 2.0) - pow(pt.z, 32.0);
        pound = pound * 2.0;
        tuv.y = tuv.y - pound;
    }

    let tex = _texture(tuv * 0.5);
    let sn  = normal(w);
    let ground = vec3<f32>(1.0);
    let sky    = vec3<f32>(1.0, 0.9, 0.9);
    let slight = mix(ground, sky, 0.5 + 0.5 * sn.y);

    // ambient occlusion hack
    var aoc: f32 = 0.0;
    let aocs = 8;
    for (var i: i32 = 0; i < aocs; i = i + 1) {
        let p = w - r * f32(i) * 0.2;
        aoc = aoc + map(p) * 0.5;
    }
    aoc = 1.0 - 1.0 / (1.0 + (aoc / f32(aocs)));

    let fog = 1.0 / (1.0 + t * t * 0.01);
    let smk = smoke(o, r, f, t);
    let fakeOcc = 0.5 + 0.5 * pow(1.0 - times().y, 4.0);

    var col = slight * tex * aoc + smk * sky;
    col = mix(col * fakeOcc, sky, 1.0 - fog);
    return col;
}

@fragment
// fn main(@location(0) fragCoord: vec2<f32>) -> @location(0) vec4<f32> {
fn main(@builtin(position) fragCoord: vec4<f32>) -> @location(0) vec4<f32> {
    // let uv0 = fragCoord / iResolution;
    let uv0 = vec2<f32>(
        1.0 - fragCoord.x / iResolution.x, // horizontal flip (X)
        1.0 - fragCoord.y / iResolution.y  // vertical flip (Y)
    );
    var uv = uv0 * 2.0 - vec2<f32>(1.0);
    uv.x = uv.x * (iResolution.x / iResolution.y);

    var r = normalize(vec3<f32>(uv, 0.8 - dot(uv, uv) * 0.2));
    var o = vec3<f32>(0.0, 0.125, -1.5);
    let f = vec3<f32>(0.0, 0.0, 1.0);

    let pt = times();
    let shake = pow(1.0 - pt.x, 4.0);
    var smack = textureSample(iChannel0, iChannel0Sampler, vec2<f32>(pt.x, 0.5)).xyz * 2.0 - vec3<f32>(1.0);
    smack = smack * shake;

    o.x = o.x + smack.x * shake * 0.25;
    o.z = o.z + smack.y * shake * 0.1;

    let rot2 = rot(0.3 + smack.z * shake * 0.1);
    let rxy = rot2 * r.xy;
    r.x = rxy.x; r.y = rxy.y;

    let t = trace(o, r);
    let w = o + r * t;
    let col = shade(o, r, f, w, t);

    return vec4<f32>(sqrt(col), 1.0);
}