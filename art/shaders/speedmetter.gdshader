shader_type canvas_item;

void fragment() {
	vec4 final_color = vec4(UV.x * sin(TIME), 0, UV.y * (1.0 - cos(TIME)), 1.0);
	COLOR = mix(COLOR, final_color, COLOR.g);
}
