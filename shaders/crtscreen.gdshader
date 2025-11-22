shader_type canvas_item;
render_mode unshaded, skip_vertex_transform;

const float curvature = 7.0;

// 🔥 Export variables
uniform float vignette_strength : hint_range(0.0, 5.0, 0.01) = 1.0;
uniform float saturation_boost : hint_range(0.0, 3.0, 0.01) = 1.0;
uniform float scanline_strength : hint_range(0.0, 2.0, 0.01) = 1.0;

uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;

void fragment() {
    vec2 centered_uv = SCREEN_UV * 2.0 - 1.0;
    vec2 uv_offset = centered_uv.yx / curvature;
    vec2 warped_uv = centered_uv + centered_uv * uv_offset * uv_offset;

    vec3 cutoff = vec3(
        step(abs(warped_uv.x), 1.0) *
        step(abs(warped_uv.y), 1.0)
    );

    // ----- Scanlines with adjustable strength -----
    float scan = sin(2.0 * warped_uv.y * 180.0) * 0.1 + 0.9;
    vec3 scanlines = mix(vec3(1.0), vec3(scan), scanline_strength);

    // ----- Sample warped screen -----
    vec3 screen_color = textureLod(
        screen_texture,
        (warped_uv + 1.0) / 2.0,
        0.2
    ).rgb * cutoff * scanlines;

    // ----- Vignette -----
    float vignette = length(pow(abs(centered_uv), vec2(4.0))) / 3.0;
    screen_color -= vignette * vignette_strength;

    // ----- Saturation -----
    float luma = dot(screen_color, vec3(0.299, 0.587, 0.114));
    screen_color = mix(vec3(luma), screen_color, saturation_boost);

    COLOR = vec4(screen_color, 1.0);
}
