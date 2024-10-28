shader_type canvas_item;

uniform float intensity: hint_range(0.0, 1.0, 0.01) = 0.0;
uniform float speed = 5.0;

void fragment() {
	float variation = (sin(TIME * speed) / 2.0) + 0.5;
	vec3 color = mix(COLOR.rgb, vec3(1.0), variation * intensity);
	float alpha = COLOR.a;
	COLOR = vec4(color, alpha);
}
