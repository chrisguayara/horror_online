shader_type spatial;

uniform sampler2D albedo_tex;

void fragment() {
    vec4 tex = texture(albedo_tex, UV);
    ALBEDO = tex.rgb * COLOR.rgb; // combine texture + vertex color
    ALPHA = tex.a * COLOR.a;
}
