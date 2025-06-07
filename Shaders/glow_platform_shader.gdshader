shader_type spatial;

uniform vec3 glow_color : source_color = vec3(1.0, 0.8, 0.4);
uniform float glow_strength : hint_range(0.0, 10.0) = 2.5;

void fragment() {
    ALBEDO = vec3(0.2);
    EMISSION = glow_color * glow_strength;
}

