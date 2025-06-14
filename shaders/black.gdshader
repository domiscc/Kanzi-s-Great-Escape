shader_type canvas_item;

uniform float value = 0.0;

void fragment() {
	
	COLOR = vec4(0.0, 0.0, 0.0, value);
}
