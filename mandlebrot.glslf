#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
const vec2 bottom_left = vec2(-1.20, 0.20);
const vec2 upper_right = vec2(-1.0, 0.35);
const int iterations = 255;
const float f_iterations = float(iterations);
const float threshold = 4.0;

int escape_time(vec2 c) {
	vec2 z = vec2(0.0, 0.0);
	for (int i = 0; i<iterations; i++) {
		z = vec2(z[0]*z[0] - z[1]*z[1], 2.0 *z[0] * z[1]) + c;
		if (z[0] * z[0] + z[1] * z[1] > threshold) {
			return iterations-i;
		}
	}
	return 0;
}

void main( void ) {
	vec2 position = ( gl_FragCoord.xy / u_resolution.xy );

	vec2 c = (vec2(1.0, 1.0) - position) * bottom_left + position * upper_right;

	float intensity = float(escape_time(c))/f_iterations;

	gl_FragColor = vec4(intensity, intensity*2.0, intensity, 1.0);
}

