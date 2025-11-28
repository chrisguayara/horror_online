shader_type sky;

// Base sky colors
uniform vec3 top_color   : source_color = vec3(1.0, 0.3, 0.0);   // deep red
uniform vec3 bottom_color: source_color = vec3(1.0, 0.8, 0.2); // yellow fire

// Cloud parameters
const vec2 cloud_speed  = vec2(0.01, 0.0);
const float cloud_scale = 10.0;
// const float cloud_threshold = 0.8; // unused for now

float rand(vec2 co) {
    return fract(sin(dot(co.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

float cloud_pattern(vec2 uv) {
    uv *= cloud_scale;
    uv += TIME * cloud_speed;
    vec2 id = floor(uv);
    vec2 f = fract(uv);

    float rect = step(f.x, 0.7) * step(f.y, 0.4);
    float variation = rand(id);

    return rect * variation;
}

void sky() {
    vec3 dir = EYEDIR; // built‑in for sky shaders

    // Sky gradient
    float t = dir.y * 0.5 + 0.5;
    vec3 color = mix(bottom_color, top_color, t);

    // Clouds — use the horizontal (xz) direction for uv
    vec2 uv = dir.xz;
    float clouds = cloud_pattern(uv);

    // Light clouds (white-ish) blended over sky
    color = mix(color, vec3(1.0), clouds * 0.5);

    COLOR = color;
}
