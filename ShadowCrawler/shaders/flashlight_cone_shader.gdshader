shader_type canvas_item;

uniform float u_cone_length : hint_range(1.0, 1000.0) = 100.0;   // Length of the cone, half of resolution_size
uniform float u_cone_width : hint_range(0.0, 3.14159) = 1.0;     // Width of the cone in radians (spread angle)
uniform vec4 u_color : source_color = vec4(1.0, 0.5, 0.0, 1.0);  // Color of the cone

void fragment() {
	
	vec2 u_resolution = vec2(2.0 * u_cone_length, 2.0 * u_cone_length);
	
    // Normalize the UV coordinates and center them at (0.5, 0.5)
    vec2 uv = FRAGCOORD.xy / u_resolution;
    vec2 centered_uv = uv - vec2(0.5, 0.5);

    // Calculate the angle and distance from the center point
    float angle = atan(centered_uv.y, centered_uv.x);
    float distance = length(centered_uv);

    // Check if the pixel falls within the cone shape
    if (abs(angle) < u_cone_width && distance < 0.5) {
        // Inside the cone: set color
        COLOR = u_color;
    } else {
        // Outside the cone: transparent
        COLOR = vec4(0.0, 0.0, 0.0, 0.0);
    }
}
