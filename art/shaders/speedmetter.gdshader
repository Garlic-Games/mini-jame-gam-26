shader_type canvas_item;

void fragment() {
	vec4 final_color = vec4(1, smoothstep(0.0, 1.0, cos(TIME + UV.x + UV.y)), 1 ,COLOR.a);
	COLOR = final_color;
}
