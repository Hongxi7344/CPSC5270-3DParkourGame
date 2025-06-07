shader_type spatial;

uniform float pulse_speed = 0.2;
uniform vec3 base_color = vec3(1.0, 0.8, 0.0);
uniform float min_emission = 0.1;
uniform float max_emission_boost = 5.0;

void fragment() {
    float pulse = 0.5 + 0.5 * sin(TIME * pulse_speed);
	float shaped_pulse = pow(pulse, 4.0);

    float emission_strength = mix(min_emission, max_emission_boost, shaped_pulse);

    ALBEDO = base_color;
    EMISSION = base_color * emission_strength;
}
