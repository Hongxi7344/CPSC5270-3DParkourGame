shader_type spatial;

uniform float pulse_speed = 2.0;
uniform vec3 base_color = vec3(1.0, 0.8, 0.0);

void fragment() {
    float pulse = 0.5 + 0.5 * sin(TIME * pulse_speed);
    ALBEDO = base_color * pulse;
}
