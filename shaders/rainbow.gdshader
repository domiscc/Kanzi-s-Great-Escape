shader_type canvas_item;

// --- Uniforms --- //
uniform float horizontal_influence: hint_range(0.0, 1.0, 0.1) = 0.5;
uniform float vertical_influence: hint_range(0.0, 1.0, 0.1) = 0.0;

// --- Functions --- //
vec3 hsv2rgb(vec3 _c) {
    vec4 _K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 _p = abs(fract(_c.xxx + _K.xyz) * 6.0 - _K.www);
    return _c.z * mix(_K.xxx, clamp(_p - _K.xxx, 0.0, 1.0), _c.y);
}

void fragment() {
	COLOR.rgb = horizontal_influence * hsv2rgb(vec3(UV.x, 1.0, 1.0))
			+ vertical_influence * hsv2rgb(vec3(UV.y, 1.0, 1.0));
}
/*shader_type canvas_item;

float noise(vec2 input) {
	return fract(sin(dot(input, vec2(12.25, 10.356)) * 23.12) * 1054.52);
}

void fragment() {
	// Called for every pixel the material is visible on.
	float random = noise(UV);
	COLOR = vec4(vec3(random), 1.0);
}*/